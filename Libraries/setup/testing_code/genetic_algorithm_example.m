%% Genetic algorithm

clear;
cd('R:\ENG_Breuer_Shared\ehandyca\handy_simulink_control_code\Simulink_control_code\Libraries\setup');

rng default

%% For FMEET 2023/12/13

% Paramterized function:
[tvec, hprof, pprof, aprof] = genVortex(0.2, 0.1, 0.3, 0.5, 1000, 2);

fig1 = figure(1);
set(fig1,'units','normalized','position',[1.1,0.1,0.5,0.7],'color','w');

fnt = 16;

subplot(3,1,1)
plot(tvec,hprof,'linewidth',2,'color','k'); hold on;
xregion(1,2,'facecolor','g');
hold off;
xlim([0,4])
ylim([-0.01,0.11])
set(gca,'ticklabelinterpreter','latex','fontsize',fnt);

ylabel('Heave (m)')

subplot(3,1,2)
plot(tvec,rad2deg(pprof),'linewidth',2,'color','k'); hold on;
xregion(1,2,'facecolor','g');
hold off;
xlim([0,4])
ylim([-80,70])
set(gca,'ticklabelinterpreter','latex','fontsize',fnt);

ylabel('Pitch (deg)')

subplot(3,1,3)
plot(tvec,rad2deg(aprof),'linewidth',2,'color','k'); hold on;
xregion(1,2,'facecolor','g');
hold off;
xlim([0,4])
ylim([-1,20])
set(gca,'ticklabelinterpreter','latex','fontsize',fnt);

ylabel('\alpha_{eff} (deg)')

xlabel('time (s)')

%% Target trajectory

% clear;

U = 0.5;
H = 0.38;
alpha = 0.01;

freq = 0.46;
srate = 1000;

[t_tgt, h_tgt, p_tgt, a_tgt] = genVortex(U, H, alpha, freq, srate);

target = p_tgt;
% noise = 0.1*rand(size(target));
% target = target + noise-mean(noise);

fig2 = figure(2);
set(fig2,'units','normalized','position',[1.2,0.2,0.7,0.5],'color','w')

plot(t_tgt,target,'linestyle','-','color',[0,0,0],'linewidth',2);
hold on;

%% Genetic algorithm

PopSize = 25;
MaxGenerations = 30;

options = optimoptions(@ga,'PopulationSize',PopSize,'MaxGenerations',MaxGenerations);

% Without constraints

sol = ga(@(x) func(x,freq),3,[],[],[],[],[],[],[],[],options);

[t_sol, h_sol, p_sol, a_sol] = genVortex(sol(1), sol(2), sol(3), freq, srate);

plot(t_sol,p_sol,'linestyle','--','color',[1,0,0],'linewidth',2);

% With constraints

sol = ga(@(x) func(x,freq),3,[],[],[],[],[0.1,0.01,0.01],[0.6,3*0.1,0.5],[],[],options);

[t_sol, h_sol, p_sol, a_sol] = genVortex(sol(1), sol(2), sol(3), freq, srate);

plot(t_sol,p_sol,'linestyle','--','color',[1,0,1],'linewidth',2);

hold off;

xlabel('time (s)')
ylabel('pitch (deg)')

xlim([3,7])

legend('Target','GA w/o constraints','GA w constraints','interpreter','latex','fontsize',fnt)
set(gca,'ticklabelinterpreter','latex','fontsize',fnt);

%% Objective function

function E = func(vars,freq)
    % target signal
    [~, ~, target, ~] = genVortex(0.33, 0.12, 0.4, freq, 1000);
    target = target + rand(size(target));
    % trial signal
    [~, ~, test, ~] = genVortex(vars(1), vars(2), vars(3), freq, 1000);

    % root-mean-square error calculation
    E = rmse(target,test);
end

