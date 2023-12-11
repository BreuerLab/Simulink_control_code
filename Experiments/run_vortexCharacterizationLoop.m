%% Run Vortex Characterization Loop
% 2023/10/19 - eh, last update

%% Setup

cd('R:\ENG_Breuer_Shared\ehandyca\handy_simulink_control_code\Simulink_control_code\')

if ~exist('experiment','var') ||  ~exist('bias_unloaded','var') || ~exist('bias_loaded','var')
    error('Run "setup_DAQ_simulink" to establish experimental setup. Vars "experiment", "bias_unloaded", "bias_loaded" must be established.')
end

FOLDERNAME = 'R:\ENG_Breuer_Shared\ehandyca\DATA_main_repo\20231020_VortexThursday_vortex_characterization_day2\';
% FOLDERNAME = ('R:\ENG_Breuer_Shared\ehandyca\DATA_main_repo\2023mmdd_folderName');
% mkdir(FOLDERNAME);

%% Parameters for simulink (disregard)
freq = 0; % unused
heave1 = 0; % unused

%% Experiment fixed parameters

% freestream velocity
U = 0.2; % m/s

% Standby time before and after motion
stdby_strt_time = 2; % seconds
stdby_end_time = 3; % seconds

% Reduced frequency and experimental frequency
fred_up = 0.12; % non-dim
freq_up = fred_up*U/foil.chord; % Hz

hstar_up_amp = 2; % [chords] heave amplitude in upstroke
heave_up_amp = hstar_up_amp*foil.chord; % [m] dimensional heave amplitude

%% Experiment varied parameters

% Number of times the same experiment is repeated for each streamwise position
exp_scans = 10;

% Number of streamwise positions
sPosition_vec = [15,24,33,42,51,60]; % <-- manually changed

% Number of vortices tested (AoAmax)
AoAmax_vec = [0.3, 0.5];

%% VORTEX GENERATION LOOP

sPosition = input('LDV streamwise position in [cm]: ');

for AoAmax = AoAmax_vec
    for exp_scan = 1:exp_scans
        
        % BIAS MEASUREMENT ------------------------------------------------

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

        % VORTEX MOTION PROFILES ------------------------------------------

        % Ramp to offset time
        ramp_time = 4; % seconds
        
        % Generate ramp profiles
        [~, ramp_p1, ramp_h1] = ramp_fn(ramp_time, experiment.T, bias_trial, experiment.offset_home, 'g');
        [~, ramp_p2, ramp_h2] = ramp_fn(ramp_time, experiment.T, bias_trial, experiment.offset_home, 'w');
        
        % Generate motion profile
        dt = 1/experiment.srate; % duration of each time step
        
        profType = 'sinusoidal'; % type of motion profile desired
        [time_vec, heave_fn, pitch_fn, AoAmax_calc] = generate_vortex_profile(foil, heave_up_amp, AoAmax, U, fred_up, experiment.srate, profType);
        
        disp(['Approximate max velocity: ',num2str(heave_up_amp*2*pi*freq_up),' m/s']);
        
        % Assign vectors to profile variables
        pitch_motion = [zeros(length(0:dt:stdby_strt_time),1); pitch_fn; zeros(length(0:dt:stdby_end_time),1)];
        heave_motion = [zeros(length(0:dt:stdby_strt_time),1); heave_fn; zeros(length(0:dt:stdby_end_time),1)];


        % ASSEMBLE FULL MOTION PROFILES -----------------------------------

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
        close all
        figure(1)
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

        % RUN EXPERIMENT ON SIMULINK --------------------------------------

        % clear variables before next experiment
        clear raw_encoder_p1 raw_encoder_h1 raw_encoder_p2 raw_encoder_h2 raw_force_wallace raw_force_gromit ref_signal
        
        % start simulation timestamp
        timeStamp_start = datetime;

        set_param('simulink_traverse_control','SimulationCommand','start');
        
        disp('Running traverse...')
        pause(sim_time);
        disp('Acquiring data...')
        while ~exist('raw_encoder_p1','var') || ~exist('raw_encoder_h1','var') || ~exist('raw_encoder_p2','var') || ~exist('raw_encoder_h2','var') || ~exist('raw_force_wallace','var') || ~exist('raw_force_gromit','var') || ~exist('ref_signal','var')
                pause(5)
                disp('Loading...')
        end
        disp('Done')


        % DATA CONVERSION -------------------------------------------------

        range_x = find(ref_signal);
        raw_encoders = [raw_encoder_p1, raw_encoder_h1, raw_encoder_p2, raw_encoder_h2];
        out = convert_output(raw_encoders, raw_force_wallace, raw_force_gromit, raw_vectrino, ref_signal, bias_trial, range_x, experiment.offset_home);

        % SAVE DATA -------------------------------------------------------

        % save data timestamp
        timeStamp_save = datetime;

        FILENAME = (['\20231020_VortexThursday_day2_',...
            'U=',num2str(U,3),'_h=',num2str(heave_up_amp/foil.chord,3),'c_fred=',num2str(fred_up,3),'_AoAmax=',num2str(AoAmax,3),'rad_sPosition=',num2str(sPosition,3),'cm_scan=',num2str(exp_scan),'.mat']);
        
        clear fig1 % to not save into each file
        
        save(fullfile(FOLDERNAME,FILENAME));

    end
end

%% Notify experiment is finished

message = strjoin(['All scans of all vortices were finished at ',string(datetime),'. Move the LDV for the next streamwise position.']);
sendmail('eric_handy-cardenas@brown.edu','Experiment loop done',message);















