%% Create motion profile to generate a vortex with an oscilating foil
% 2023/10/09 - eh, last update

% %% TESTING
% 
% addpath(genpath('Libraries'))
% 
% foil.chord = 0.1;
% 
% [tprof, hprof, pprof] = generate_vortex_profile1(foil, 0.2, 0.35, 0.2, 0.12, 1000);
% % [tprof, hprof, pprof] = generate_vortex_profile1(foil, heave_amp, AoAmax, U, fred, srate)
% 
% % Plot resulting motion
% 
% % body = [-foil.chord/2,foil.chord/2; 0,0];
% [foil_x, foil_y] = naca00xxairfoil(0012, foil.chord, 101, 'cos');
% body = [foil_x'; foil_y'];
% 
% step = 100;
% for frame = 1:step:length(tprof)
%     % rotate body
%     theta = deg2rad(pprof(frame));
%     rotation = [cos(theta), -sin(theta); sin(theta), cos(theta)];
%     body_rot = rotation*body;
%     body_rot(2,:) = body_rot(2,:) + hprof(frame);
%     foilbody = polyshape(body_rot');
% 
%     fig1 = figure(1);
% %     set(fig1,'units','normalized','position',[0.1,0.1,0.7,0.8])
% 
%     subplot(1,4,1:3)
%     yyaxis left
%     plot(tprof, hprof); hold on;
%     plot(tprof(frame), hprof(frame), '.', 'markersize', 40); hold off;
%     ylim([-0.1,0.7])
%     ylabel('$h(t)$ (m)','interpreter','latex')
%     yyaxis right
%     plot(tprof, pprof); hold on;
%     plot(tprof(frame), pprof(frame), '.', 'markersize', 40); hold off;
%     ylim([-80,80])
%     ylabel('$\theta(t)$ ($^\circ$)','interpreter','latex')
%     xlabel('$t$ (s)','interpreter','latex')
%     set(gca,'fontsize',14);
%     grid on;
% 
%     subplot(1,4,4)
%     % plot(body_rot(1,:),body_rot(2,:),'linestyle','-','linewidth',2,'color','k')
%     plot(foilbody);
%     axis equal
%     ylim([-0.1,0.7])
%     xlim([-0.75*foil.chord,1.5*foil.chord])
%     set(gca,'xtick',[],'ytick',[],'box','on')
% 
% %         figname = ['frame_T=6.5_',num2str(frame),'.png'];
% %         save_folder = 'C:\Users\ehandyca\Documents\MAT Local quick access figures\20230927_singleVortexMotion\aT4_negative';
% %         export_fig(fullfile(save_folder,figname));
% %         close(fig1)
% 
% end


%% Generate Vortex Profile %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [tprof, hprof, pprof, alpha_max] = generate_vortex_profile(foil, heave_amp, AoAmax, U, fred, srate)

%% General parameters

chord = foil.chord; % foil chord (m)
dt = 1/srate; % sampling period (s)
N = 20; % approximate motion time (s)

n = round(0.1/dt); % transition length (samples = seconds / period)
maxh_fctr = 0.995; % heave amplitude reached threshold (percentage)

as1 = 6; % up-stroke acceleration smoothing factor
as2 = 4; % down-stroke acceleration smoothing factor

%% Heave motion

% 1. Up-stroke motion -----------------------------------------------------

freq = fred*U/chord; % real frequency (Hz)
Vmax_up = heave_amp*2*pi*freq; % max velocity (from the reduced frequency) (m/s)

t1up = 5; % start of motion (s)
t2up = t1up + abs(heave_amp)/Vmax_up; % end of motion (s)

time1 = 0:dt:N; % time vector (s)

% Eldredge's function (courtesy of Xiaowei He, as implemented on He and Williams (2020))
profile = heave_amp/2 + sign(heave_amp)*(Vmax_up/as1*log(cosh(as1*(time1-t1up))./cosh(as1*(time1-t2up))))/2; % Eldredge's function

[~,indx1] = min(abs(profile-maxh_fctr*heave_amp));

hprof1 = profile(1:indx1+n);
tprof1 = time1(1:indx1+n);

% 2. Down-stroke motion ---------------------------------------------------

% MAYBE JUST USE A TANH RAMP DOWN

fred = 0.03; % reduced frequency going down

freq = fred*U/chord; % real frequency (Hz)
Vmax_dwn = heave_amp*2*pi*freq; % max velocity (from the reduced frequency) (m/s)

t1dwn = 5; % start of motion (s)
t2dwn = t1dwn + abs(heave_amp)/Vmax_dwn; % end of motion (s)

time2 = 0:dt:N; % time vector (s)

heave_amp_dwn = heave_amp*2;

% Eldredge's function (courtesy of Xiaowei He, as implemented on He and Williams (2020))
profile = heave_amp/2 + sign(heave_amp_dwn)*(Vmax_dwn/as2*log(cosh(as2*(time2-t1dwn))./cosh(as2*(time2-t2dwn))))/2;

[~,indx2] = min(abs(profile-maxh_fctr*heave_amp));

hprof2 = flip(profile(1:(indx2-1+n)));
tprof2 = time2(2:indx2+n) + tprof1(indx1);

% 3. Modulate signals into eachother --------------------------------------

tseam = tprof2(1):dt:tprof1(end);

hmodulator = 0.5*sin(2*pi*0.5/abs(tseam(end)-tseam(1))*(tseam-tseam(1)) + pi/2) + 0.5;

% modulating signals
h1mod = hmodulator;
h2mod = flip(hmodulator);

hprof1(end-n+1:end) = hprof1(end-n+1:end).*h1mod;
hprof2(1:n) = hprof2(1:n).*h2mod;

% heave "seam"
hseam = hprof1(end-n+1:end) + hprof2(1:n);

% assemble full profile (unsmoothed)
tprof = [tprof1(1:end-n), tseam, tprof2(n+1:end)];
htemp = [hprof1(1:end-n), hseam, hprof2(n+1:end)];

% % temp plotting
% plot(tprof,htemp); hold on;

% 4. Profile smoothing ----------------------------------------------------

% Differentiate signal for smoothing
hvtmp = gradient(htemp,dt); % heave velocity
hatmp = gradient(hvtmp,dt); % heave acceleration temporary

% % temp plotting
% plot(tprof,hvtmp);
% plot(tprof,hatmp);

% Smoothing range indexes
indxs1 = indx1 - 10;
indxs2 = indx1 + n + 10;
% Smoothing time range
tsmth_temp = tprof(indxs1:indxs2);

% interpolate with cubic spline
npts = round(0.1/dt); % num samples before dscnty. and after dscnty. used for interpolation
ttemp = [tprof(indxs1+(-npts:5)),tprof(indxs2+(-5:npts))];
atemp = [hatmp(indxs1+(-npts:5)),hatmp(indxs2+(-5:npts))];
asmth_temp = spline(ttemp,atemp,tsmth_temp);

% Reassemble ful acceleration profile
hacc = hatmp;
hacc(indxs1:indxs2) = asmth_temp;

% % temp plotting
% plot(tprof,hacc);

% 5. Signal integration and reconstruction

% Integrate signal to obtain the heave profile
hvel = cumtrapz(hacc)*dt;
hprof = cumsum(hvel)*dt;

% % temp plotting
% plot(tprof,hvel)
% plot(tprof,hprof)

% Bring downstroke value back to zero (correct smoothing-introduced error)
% m = n+450;
[~,indxr1] = max(hprof);
[~,indxr2] = min(hprof(indxr1:end));
indxr2 = indxr2 + indxr1;
hprof(indxr2+1:end) = hprof(indxr2);
% ramp down signal for modulation
modul = 0.5*sin(2*pi*(0.5/(dt*length(tprof(indxr1:indxr2))))*(tprof(indxr1:indxr2)-tprof(indxr1)) + pi/2) + 0.5;

% ramp down heave
hprof(indxr1:indxr2) = hprof(indxr1:indxr2).*modul;
hprof(indxr2+1:end) = 0;

% % temp plotting
% plot(tprof,hprof)
% hold off;

% smooth resulting profile once more
hprof = smooth(hprof,2*n);

% % temp plotting
% figure()
% plot(tprof,hprof); hold on;
% plot(tprof,gradient(hprof,dt))
% plot(tprof,gradient(gradient(hprof,dt),dt)); hold off;

%% Pitch motion

% First determine the upstroke angle needed to reach the desired max alpha_effective
hvel = movmean(gradient(hprof,dt),n); % heaving velocity profile
theta_amp = rad2deg(atan(min(-hvel(1:indxr1)/U)) - AoAmax); % theta_up = alpha_induced + alpha_effective
% theta_amp = rad2deg(AoAmax - atan(-2*pi*(heave_amp/chord)*fred));

% Time limits of pitch up-stroke
t1theta = t1up - 1.5*(t2up-t1up);
[~,idx1th] = min(abs(tprof-t1theta));

% Calculate resulting induced angle of attack
% The resulting alpha_induced will be matched with the downstroke pitch angle
% in order to make the alpha_effective == 0
aoa_ind = rad2deg(atan(-hvel/U)); % theta_down = alpha_induced + 0 

[aoat_amp, idx2th] = max(aoa_ind);
t2theta = tprof(idx2th);
% t2theta = t2up + (t2up-t1up)*(2/4);

% time vector for up-stroke
time3 = (t1theta:dt:t2theta) - t1theta; % time vector (s)

% Make a sine wave that reaches such amplitude
profile1p = theta_amp/2*sin(2*pi*1/abs(t1theta-t2theta)*time3(1:round(end/2)) - pi/2) + theta_amp/2;

% Second part of the sine wave goes to the modulated angle of attack section of the motion
% aoat_amp = max(aoat); % maximum angle from downstroke
prof2amp = aoat_amp - theta_amp; % profile amplitude (from upstroke max to downstroke max)

profile2p = prof2amp/2*sin(2*pi*1/abs(t1theta-t2theta)*time3(round(end/2)+1:end) + pi/2) - prof2amp/2 + aoat_amp;

% Put both sections together
profile_up = [profile1p,profile2p];

% Now connect this to the rest of the downstroke AoA profile
prof_temp = zeros(size(tprof));
indx2p = (idx1th+length(profile_up)-1);
prof_temp(idx1th:indx2p) = profile_up;

prof_temp(indx2p+1:end) = aoa_ind(indx2p+1:end);

% Smooth profile
pprof = smooth(prof_temp,n/2);

% temp plotting
% figure()
% plot(tprof,pprof); hold on;
% plot(tprof,gradient(pprof,dt))
% plot(tprof,gradient(gradient(pprof,dt),dt)); hold off;

% Resulting AoA check
alpha_eff = rad2deg(atan(-hvel/U)) - pprof; % alpha_effective = alpha_induced - theta
% alpha_max = max(alpha_eff);
alpha_max = alpha_eff(round((idx1th+idx2th)/2));

disp(['Maximum resulting effective AoA: ',num2str(alpha_max), ' deg (',num2str(deg2rad(alpha_max)),' rad)']);

end
