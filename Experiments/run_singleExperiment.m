%% Single experiment

cd('R:\ENG_Breuer_Shared\ehandyca\handy_simulink_control_code\Simulink_control_code\')

if ~exist('experiment','var') ||  ~exist('bias_unloaded','var') || ~exist('bias_loaded','var')
    error('Run "setup_DAQ_simulink" to establish experimental setup. Vars "experiment", "bias_unloaded", "bias_loaded" must be established.')
end

% FOLDERNAME = ('R:\ENG_Breuer_Shared\ehandyca\DATA_main_repo\20230418_TandemTuesday_4c_separation_3alphaSweep_diffAlphaValues_APHPH_A3E');
% mkdir(FOLDERNAME);

% FOLDERNAME = experiment.fname;
FOLDERNAME = 'R:\ENG_Breuer_Shared\ehandyca\DATA_main_repo\20230506_TandemThursday_4c_separation_3alphaSweep_A3E_diffAlpha\';

%% Take experiment bias measurement

use_bias_measurement = 1;

if use_bias_measurement == 1
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

%% Experiment loop

% non-changing parameters
U = 0.33;
phi = -90;
num_cyc = 24;
transient_cycs = 3;
fred = 0.11;
freq = fred*U/foil.chord;
% freq = 1.2; % very close

phase = -180;

% non-dim parameters
P1star = 80; % pitch amp leading [deg]
H1star = 1.2; % heave amp leading [chords]
P2star = 75; % pitch amp leading [deg]
H2star = 1.4; % heave amp leading [chords]

% dimensional parameters
pitch1 = P1star;
heave1 = H1star*foil.chord;
pitch2 = P2star;
heave2 = H2star*foil.chord;

% constant amplitude
const_p1 = 0;
const_h1 = 0;
const_p2 = 0;
const_h2 = 0;

aT4 = atan(-2*pi*(heave1/foil.chord)*fred) + deg2rad(pitch1);

%% Profile generation

% ramp to offset time
ramp_time = 5; % in [s]

% Generate ramp profiles
[~, ramp_p1, ramp_h1] = ramp_fn(ramp_time, experiment.T, bias_trial, experiment.offset_home, 'g');
[~, ramp_p2, ramp_h2] = ramp_fn(ramp_time, experiment.T, bias_trial, experiment.offset_home, 'w');

% Generate experiment profiles
[~, pprof1] = generate_profile(num_cyc, freq, experiment.srate, transient_cycs, transient_cycs, pitch1, phi, const_p1);
[~, pprof2] = generate_profile(num_cyc, freq, experiment.srate, transient_cycs, transient_cycs, heave1, 0, const_h1);
[~, pprof3] = generate_profile(num_cyc, freq, experiment.srate, transient_cycs, transient_cycs, pitch2, phase+phi, const_p2);
[~, pprof4] = generate_profile(num_cyc, freq, experiment.srate, transient_cycs, transient_cycs, heave2, phase, const_h2);
[~, rprof5] = generate_profile(num_cyc-4, freq, experiment.srate, transient_cycs+2, transient_cycs+2, 1, 0, 1); % reference signal
rprof5(rprof5~=1) = 0;

clear profs
dumb_delay = 50; % phase difference between pitch wallace and heave wallace (heave lags behind pitch)
% Assemble output profiles
profs(:,1) = [zeros(dumb_delay,1); zeros(experiment.motion_delay,1); ramp_p1; pprof1+experiment.offset_home(1)+bias_trial.pitch(1); flip(ramp_p1)];
profs(:,2) = [zeros(dumb_delay,1); zeros(experiment.motion_delay,1); ramp_h1; pprof2+experiment.offset_home(2)+bias_trial.heave(1); flip(ramp_h1)];
profs(:,3) = [zeros(dumb_delay,1); ramp_p2; pprof3+experiment.offset_home(3)+bias_trial.pitch(2); flip(ramp_p2); zeros(experiment.motion_delay,1)];
profs(:,4) = [ramp_h2; pprof4+experiment.offset_home(4)+bias_trial.heave(2); flip(ramp_h2); zeros(experiment.motion_delay,1); zeros(dumb_delay,1)];
profs(:,5) = [zeros(dumb_delay,1); zeros(experiment.motion_delay,1); zeros(size(ramp_p1)); rprof5; zeros(size(ramp_p1))]; % reference signal

% plot trajectories
plot_profiles(profs);

% convert into time series to be output to simulink
toime = (0:size(profs,1)-1)'/experiment.srate; % time vector to create time series objects
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

FILENAME = (['\20230506_TandemSaturday_4c_test_04_',...
    'aT4=',num2str(aT4,3),'_p2=',num2str(pitch2,2),'deg_h2=',num2str(heave2/foil.chord,3),'c_ph=',num2str(phase),'deg.mat']);

save(fullfile(FOLDERNAME,FILENAME));

% message = strjoin(['This is a test email sent at ',string(datetime),'from the Flume.']);
% sendmail('eric_handy-cardenas@brown.edu','Experiment done',message);

close all
