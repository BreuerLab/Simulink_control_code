% %% Testing --------------------------------------------------------------
% 
% clear;
% 
% srate = 1000;
% chord = 0.1;
% U = 0.2;
% fred = 0.12;
% freq = (U*fred)/chord;
% t0 = 4;
% tvec = 0:1/srate:4;
% tau = tvec - t0;
% nT = 2;
% 
% % Motion parameters
% H = 0.2; % max heave amplitude
% s = 2;
% alpha = 0.4;
% 
% [tvec, hprof, pprof, aeff] = genVortext(U, H, alpha, freq, t0, srate, s, nT);
% 
% % Plot trajectory and motion ----------------------------------------------
% 
% fig1 = figure(1);
% set(fig1,'units','normalized','position',[1.22,0.1,0.7,0.8],'color','w')
% 
% subplot(2,1,1)
% plot(tvec,hprof,'linewidth',3,'color','k');
% ylim([-0.01,H+0.01])
% ylabel('$h(t)$','interpreter','latex')
% 
% set(gca,'linewidth',1,'ticklabelinterpreter','latex','fontsize',16)
% 
% subplot(2,1,2)
% plot(tvec,rad2deg(pprof),'linewidth',3,'color','k');
% hold on;
% plot(tvec,rad2deg(aeff),'linestyle','--','linewidth',3,'color','k');
% hold off;
% ylim([rad2deg(min(pprof,[],'all'))-10,rad2deg(max(pprof,[],'all'))+10])
% % ylim([-50,70])
% ylabel('$\theta(t)$','interpreter','latex')
% 
% set(gca,'linewidth',1,'ticklabelinterpreter','latex','fontsize',16)
% 
% [foil_x, foil_y] = naca00xxairfoil(0012, chord, 101, 'cos');
% body = [(foil_x-chord/4)'; foil_y'];
% 
% step = 20;
% for frame = 1:step:length(tvec)
%     % rotate body
%     theta = -pprof(frame);
%     rotation = [cos(theta), -sin(theta); sin(theta), cos(theta)];
%     body_rot = rotation*body;
%     body_rot(2,:) = body_rot(2,:) + hprof(frame);
%     foilbody = polyshape(body_rot');
% 
%     fig2 = figure(2);
%     set(fig2,'units','normalized','position',[1.01,0.1,0.2,0.8],'color','w')
% 
%     plot(foilbody,'FaceColor','k');
%     tit = ['[',num2str(frame),'/',num2str(length(tvec)),']'];
%     title(tit,'interpreter','latex')
%     axis equal
%     ylim([-0.1,0.7])
%     xlim([-chord/2,chord])
% end
%
% -------------------------------------------------------------------------


%% Vortex generation motion function
function [tvec, hprof, pprof, aeff] = genVortex(U, H, alpha, freq, t0, srate, s, nT)
%
% Fully parametrized function to produce the heave and pitch motions for a
% single vortex.
%
% 2023/12/05 - eehc, last update
% -------------------------------------------------------------------------
% Syntax:
%
% [tvec, hprof, pprof, aeff] = genVortext(U, H, alpha, freq, srate, t0, s, nT);
%
% -------------------------------------------------------------------------
%
% Inputs:
%
% srate: sampling rate (Hz).
%
% U: flow velocity (m/s).
%
% alpha: effective angle of attack during upstroke (rad).
%
% freq: fundamental frequency of heaving motion (Hz).
%
% t0: time at which maximum heave is reached (s).
%
% s: smoothing factor, 1.5 < s < 5 (default is 2).
%
% nT: duration of the full motion profile in (number of periods).
%
% -------------------------------------------------------------------------
%
% Outputs:
%
% tvec: time vector (s).
%
% hprof: heaving motion profile (m).
%
% pprof: pitching motion profile (rad).
%
% aeff: effective angle of attack profile (rad).
%
% -------------------------------------------------------------------------
% version 1.0.0
% Eric Handy-Cardenas
% 2023/12/05
% -------------------------------------------------------------------------
%
%% Argument check
nargoutchk(3, 4)
narginchk(5, 8)

% Flag required inputs

% Default values

if ~exist('t0','var')
    t0 = 0;
end

if ~exist('srate','var')
    srate = 1000;
end

if ~exist('s','var')
    s = 2;
end

if ~exist('nT','var')
    nT = 4;
end


%% Time vector
tvec = 0:1/srate:(nT/freq); % time vector is equal to 10 fundamental frequency periods
tau = tvec - t0;

% Function transition smoothing
fd = s*freq;
fu = s*freq;

%% Heave motion
hprof = H.*(1+cos(2.*pi.*freq.*tau))/(4.*tanh(2.*pi/3)).*(tanh(2.*pi.*(1/3 - fd.*tau)) + tanh(2.*pi.*(1/3 + fu.*tau)));

% Heave velocity (considering fu == fd)
% analytical:
hdot = (H/4)*coth(2*pi/3).*(...
    2*pi*fu.*(1+cos(2*pi*freq.*tau)).*(-sech(2*pi.*(1/3 - fu*tau)).^2 + sech(2*pi.*(1/3 + fu*tau)).^2)...
    - 2*pi*freq.*sin(2*pi*freq.*tau).*(tanh(2*pi.*(1/3 - fu*tau)) + tanh(2*pi.*(1/3 + fu*tau)))...
    );
% numerical:
hvel = gradient(hprof,1/srate);

%% Pitch motion
fp = 2*fu; % for transition between regimes

% effective angle of attack we want to achieve:
% > upstroke
a_up = alpha;
% > downstroke
a_dw = 0;

% angle for upstroke and downstroke
theta_up = a_up - atan(-hdot/U);
theta_dw = a_dw - atan(-hdot/U);

% figure() % enable for debugging
% plot(theta_up); hold on;
% plot(theta_dw); hold off;

% modulating functions
A_up = (1/2)*(tanh(-2*pi*fp.*tau) + 1);
A_dw = (1/2)*(tanh(2*pi*fp.*tau) + 1);

% figure() % enable for debugging
% plot(A_up.*theta_up); hold on;
% plot(A_dw.*theta_dw); hold off;

% ramp-up function
B = (1/2)*(tanh(2*pi*fu.*tau + 4*pi/3) + 1);

% figure() % enable for debugging
% plot(B.*A_up.*theta_up); hold on;
% plot(B.*A_dw.*theta_dw); hold off;

% adding everything together
pprof = B.*(A_up.*theta_up + A_dw.*theta_dw);

% Resulting effective angle of attack
aeff = atan(-hdot/U) + pprof;

end







