%% Generate single vortex
% 20230925 -ehandyca

cd('R:\ENG_Breuer_Shared\ehandyca\handy_simulink_control_code\Simulink_control_code\')

if ~exist('experiment','var') ||  ~exist('bias_unloaded','var') || ~exist('bias_loaded','var')
    error('Run "setup_DAQ_simulink" to establish experimental setup. Vars "experiment", "bias_unloaded", "bias_loaded" must be established.')
end

% FOLDERNAME = ('R:\ENG_Breuer_Shared\ehandyca\DATA_main_repo\20230418_TandemTuesday_4c_separation_3alphaSweep_diffAlphaValues_APHPH_A3E');
% mkdir(FOLDERNAME);

% FOLDERNAME = experiment.fname;
FOLDERNAME = 'R:\ENG_Breuer_Shared\ehandyca\DATA_main_repo\20231009_VortexMonday_motionTesting_pt2\';

%% Take experiment bias measurement

use_bias_measurement = 'yes';

if strcmp(use_bias_measurement,'yes')
    bias = bias_loaded; % use bias_loaded as the bias to update the pitch and heave biases in the "fin_bias_simulink" routine
    run("find_bias_simulink.m"); % find another loaded bias that contains the drifting and the load bias
    bias_newloaded = bias; % establish new loaded bias
    % for experiment: bias_trial = bias_newloaded - bias_loaded + bias_unloaded
    bias_trial = bias; % inherits pitch and heave biases
    bias_trial.Wallace = bias_newloaded.Wallace - bias_loaded.Wallace + bias_unloaded.Wallace;
    bias_trial.Gromit = bias_newloaded.Gromit - bias_loaded.Gromit + bias_unloaded.Gromit;
else
    bias_trial = bias_unloaded;
end

%% Experiment section

% non-changing parameters
U = 0.2; % [m/s] freestream velocity
stdby_time = 3; % [seconds] standby time before and after motion
phi = -90; % [deg] phase lag between heave and pitch (pitch leads the motion)

% noly for use of the simulink control
freq = 0; % unused
heave1 = 0; % unused

% MODIFY STROKE PARAMETERS HERE !! ----------------------------------------

fred_up = 0.12; % reduced frequency upstroke
freq_up = fred_up*U/foil.chord; % real frequency upstroke

hstar_up_amp = 2.5; % [chords] heave amplitude in upstroke
heave_up_amp = hstar_up_amp*foil.chord; % [m] dimensional heave amplitude

% Maximum angle of attack desired in upstroke
AoAmax = 0.3;
exp_label = 0; % temporary: experiment number

% VORTEX GENERATION -------------------------------------------------------

% ramp to offset time
ramp_time = 5; % in [s]

% Generate ramp profiles
[~, ramp_p1, ramp_h1] = ramp_fn(ramp_time, experiment.T, bias_trial, experiment.offset_home, 'g');
[~, ramp_p2, ramp_h2] = ramp_fn(ramp_time, experiment.T, bias_trial, experiment.offset_home, 'w');

% Generate motion profile
dt = 1/experiment.srate; % duration of each time step

profType = 'sinusoidal';
[time_vec, heave_fn, pitch_fn, AoAmax_calc] = generate_vortex_profile(foil, heave_up_amp, AoAmax, U, fred_up, experiment.srate, profType);

disp(['Approximate max velocity: ',num2str(heave_up_amp*2*pi*freq_up),' m/s']);

% plotting
figure(1)
yyaxis left
plot(time_vec,heave_fn);
ylim([-0.05,0.25])
yyaxis right
plot(time_vec,pitch_fn);
ylim([-60,60])

pitch_motion = pitch_fn;
heave_motion = heave_fn;

% plotting result
plot_motion = 'no';
if strcmp(plot_motion,'yes')
    body = [-foil.chord/2,foil.chord/2; 0,0];

    for frame = 1:40:length(time_vec)
        % rotate body
        theta = deg2rad(pitch_motion(frame));
        rotation = [cos(theta), -sin(theta); sin(theta), cos(theta)];
        body_rot = rotation*body;
        body_rot(2,:) = body_rot(2,:) + heave_motion(frame);
    
        fig1 = figure(1);
        set(fig1,'units','normalized','position',[0.1,0.1,0.7,0.8])
        
        subplot(1,4,1:3)
        yyaxis left
        plot(time_vec, heave_motion); hold on;
        plot(time_vec(frame), heave_motion(frame), '.', 'markersize', 40); hold off;
        ylim([-0.1,0.8])
        ylabel('$h(t)$ (m)','interpreter','latex')
        yyaxis right
        plot(time_vec, pitch_motion); hold on;
        plot(time_vec(frame), pitch_motion(frame), '.', 'markersize', 40); hold off;
        ylim([-80,80])
        ylabel('$\theta(t)$ ($^\circ$)','interpreter','latex')
        xlabel('$t$ (s)','interpreter','latex')
        set(gca,'fontsize',14);
    
        subplot(1,4,4)
        plot(body_rot(1,:),body_rot(2,:),'linestyle','-','linewidth',6,'color','k')
        axis equal
        ylim([-0.1,0.8])
        xlim([-foil.chord,foil.chord])
        set(gca,'xtick',[],'ytick',[])
        
%         figname = ['frame_T=6.5_',num2str(frame),'.png'];
%         save_folder = 'C:\Users\ehandyca\Documents\MAT Local quick access figures\20230927_singleVortexMotion\aT4_negative';
%         export_fig(fullfile(save_folder,figname));
%         close(fig1)
        
    end
end

% Motion definition -------------------------------------------------------

clear profs
dumb_delay = 50; % phase difference between pitch Bell-E and heave Bell-E (heave lags behind pitch)

% motion profiles new-traverse:
profs(:,3) = [zeros(dumb_delay,1); ramp_p2; pitch_motion+experiment.offset_home(3)+bias_trial.pitch(2); flip(ramp_p2); zeros(experiment.motion_delay,1)];
profs(:,4) = [ramp_h2; heave_motion+experiment.offset_home(4)+bias_trial.heave(2); flip(ramp_h2); zeros(experiment.motion_delay,1); zeros(dumb_delay,1)];
profs(:,5) = [zeros(dumb_delay,1); zeros(size(ramp_p2)); ones(size(pitch_motion)); zeros(size(ramp_p2)); zeros(experiment.motion_delay,1)];

% unused channels (Parker-Aerotech motion)
profs(:,1) = [zeros(size(profs(:,3)))];
profs(:,2) = [zeros(size(profs(:,4)))];

% plot trajectories
plot_profiles(profs);

% convert into time series to be output to simulink
toime = (0:size(profs,1)-1)'/experiment.srate; % time vector to create time series objects
disp(['Expected motion time: ', num2str(ceil(toime(end))-10), ' seconds']);
outp1 = timeseries(profs(:,1),toime);
outh1 = timeseries(profs(:,2),toime);
outp2 = timeseries(profs(:,3),toime);
outh2 = timeseries(profs(:,4),toime);
sync_sig = timeseries(profs(:,5),toime);

% simulation time
sim_time = ceil(toime(end))+2;
disp(['Expected simulation time: ', num2str(sim_time), ' seconds']);

%% Run actual experiment

% clear variables before next experiment
clear raw_encoder_p1 raw_encoder_h1 raw_encoder_p2 raw_encoder_h2 raw_force_wallace raw_force_gromit ref_signal

set_param('simulink_traverse_control','SimulationCommand','start');

disp('Running traverse...')
pause(sim_time);
disp('Acquiring data...')
while ~exist('raw_encoder_p1','var') || ~exist('raw_encoder_h1','var') || ~exist('raw_encoder_p2','var') || ~exist('raw_encoder_h2','var') || ~exist('raw_force_wallace','var') || ~exist('raw_force_gromit','var') || ~exist('ref_signal','var')
        pause(5)
        disp('Loading...')
end
disp('Done')

%% Data conversion

range_x = find(ref_signal);
raw_encoders = [raw_encoder_p1, raw_encoder_h1, raw_encoder_p2, raw_encoder_h2];
out = convert_output(raw_encoders, raw_force_wallace, raw_force_gromit, raw_vectrino, ref_signal, bias_trial, range_x, experiment.offset_home);

%% Save data

FILENAME = (['\20231009_VortexMonday_',num2str(exp_label),'_withFoil_withFlow_',...
    'U=',num2str(U,3),'_aT4=',num2str(AoAmax,3),'_p2=',num2str(max(pitch_fn),2),'deg_h2=',num2str(heave_up_amp/foil.chord,3),'c_fred=',num2str(fred_up,3),'.mat']);

clear fig1

save(fullfile(FOLDERNAME,FILENAME));

% message = strjoin(['This is a test email sent at ',string(datetime),'from the Flume.']);
% sendmail('eric_handy-cardenas@brown.edu','Experiment done',message);

% close all
