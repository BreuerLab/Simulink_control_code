%% Setup DAQ - Simulink control
% Updated 2023/09/24 for Vortex generation using the leading traverse (Gromit)
% - ehandyca

addpath(genpath('Libraries'))
setupEmail() % sets up email to send out when experiment is finished

% cd('R:\ENG_Breuer_Shared\ehandyca\handy_simulink_control_code');

%% General setup

srate = 1000;
T = 1/srate;
foil_shape = 'A5';

foil = foils_database(foil_shape);
experiment = setupPrompt(srate,foil);

% expected time delay between Gromit and Wallace (Gromit leading motion)
experiment.motion_delay = 0;%13; % 20230924
disp(['NOTE: Expected time delay between Gromit and Wallace motions (Gromit leading the motion) is set to ',num2str(experiment.motion_delay),' ms']);

clearvars -except experiment foil srate T

%% Unloaded bias measurement

% check for required parameters:
if ~exist('experiment','var')
    error('Missing necessary variables from workspace')
end

disp(['Finding unloaded bias. Ensure flume is OFF and motors are ON.',newline,'Press any key to continue.'])
pause()

run("find_bias_simulink.m")

clearvars -except experiment foil srate T out raw_encoders raw_force_wallace raw_force_gromit bias

%% Find zero pitch (aligns at center of flume)

% align_ans = input(['Run "find_zero_pitch" for Gromit? y/n + Enter',newline],"s");
align_ans = 'n';
disp('Pitch alignment will be skipped for Old traverse (Parker-AeroTech).');

if strcmp(align_ans,'y')
    % align gromit
    traverse = 'g';
    disp('Ensure flume is at speed and Gromit is ON. Press any key to continue')
    pause

    % check for required parameters:
    if ~exist('experiment','var') || ~exist('bias','var') || ~exist('traverse','var')
        error('Missing necessary variables from workspace. Vars "experiment", "bias", and "traverse" must be available.')
    end
    
    run("find_zero_pitch_simulink.m")
    
    clearvars -except experiment foil srate T out raw_encoders raw_force_wallace raw_force_gromit bias
end

% Only align the new traverse - edit 20230924
align_ans = input(['Run "find_zero_pitch" for Bell-Everman? y/n + Enter',newline],"s");
if strcmp(align_ans,'y')
    % align Bell-Everman
    traverse = 'w';
    disp('Ensure flume is at speed and Bell-Everman is ON. Press any key to continue')
    pause
    
    run("find_zero_pitch_simulink.m")
end

% Assign aligned pitch bias to unloaded bias variable
disp('Updating "bias_unloaded" with alignment.')


% temporary pitch bias overwrite - edit 20230504
overwrite = 'no';
if strcmp(overwrite,'yes')
    % these are manually input values
    bias = bias_unloaded;
    bias.pitch(2) = 0.0044+0.4-0.2; 
    bias.pitch(1) = -0.0065-0.5-0.3;
end

bias_unloaded = bias;
clearvars -except experiment foil srate T out raw_encoders raw_force_wallace raw_force_gromit bias bias_unloaded

%% Loaded bias measurement

% check for required parameters:
if ~exist('experiment','var') || ~exist('bias_unloaded','var') || ~exist('bias','var')
    % in this case, bias and bias_unloaded are the same, but "find_bias" uses the variable "bias" to run
    error('Missing necessary variables from workspace. Vars "experiment", "bias", and "bias_unloaded" must be available.')
end

disp(['Finding loaded bias. Ensure flume is ON and motors are ON. Bring flowspeed up to experiment value.',newline,'Press any key to continue.'])
pause
run("find_bias_simulink.m")

% Assign bias to loaded bias variable
bias_loaded = bias;
clearvars -except experiment foil srate T out raw_encoders raw_force_wallace raw_force_gromit bias bias_unloaded bias_loaded

%% Ready

disp('Done initializing experimental setup.')


