% This script moves the traverses smoothly to either the 'home' position or the 'start' position
 sampleTime = 1/Parameters.sampleRate;

rampTime = 5; % ramp time in seconds
% Generate ramp profiles
[~, rampPitchG] = ramp_fn(rampTime,startPitchDegG, MotorPositions.endPitchDegG, Parameters.sampleRate);
[~, rampHeaveG] = ramp_fn(rampTime,startHeaveMetersG, MotorPositions.endHeaveMetersG, Parameters.sampleRate);
[~, rampPitchW] = ramp_fn(rampTime,startPitchDegW, MotorPositions.endPitchDegW, Parameters.sampleRate);
[rampTimesVector, rampHeaveW] = ramp_fn(rampTime,startHeaveMetersW, MotorPositions.endHeaveMetersW, Parameters.sampleRate);

% convert into time series to be output to simulink
pitchDegreesG = timeseries(rampPitchG,rampTimesVector);
heaveMetersG = timeseries(rampHeaveG,rampTimesVector);
pitchDegreesW = timeseries(rampPitchW,rampTimesVector);
heaveMetersW = timeseries(rampHeaveW,rampTimesVector);
syncSig = timeseries(zeros(size(rampPitchG)),rampTimesVector);

% simulation time
simTime = ceil(rampTimesVector(end))+2;
disp(['Expected simulation time: ', num2str(simTime), ' seconds']);

% plot trajectories
plot_profiles(rampTimesVector,rampPitchW,rampHeaveW,rampPitchG,rampHeaveG);

% pass parameters for gromit heave gain in simulation
freqGain = 0; heaveGain = 0;

    %% Run traverse
simStatus='stopped'; % Check if the model ran correctly
while strcmp(simStatus,'stopped') 
    % clear variables in case done after an experiment
%         clear raw_encoder_p1 raw_encoder_h1 raw_encoder_p2 raw_encoder_h2 raw_force_wallace raw_force_gromit ref_signal
        clear rawEncoderPitchCountsG rawEncoderHeaveCountsG rawEncoderPitchCountsW rawEncoderHeaveCountsW ...
            rawForceVoltsW rawForceVoltsG   rawVoltsVectrino rawVoltsAccelmeter refSig
   
%     set_param('simulink_traverse_control','sampleTime',);
    set_param('simulink_traverse_control','SimulationCommand','start');
    simStatus = get_param('simulink_traverse_control','SimulationStatus');
    disp('Running traverse...')
    pause(simTime+2);
%     disp('Acquiring data...')
    while ~exist('refSig','var')
            simStatus = get_param('simulink_traverse_control','SimulationStatus');
            disp('Loading...')
            pause(5)
            if strcmp(simStatus,'stopped') % Break out if the trial is taking unexpectedly long to avoid hanging on failure to build model
                delete('SimulationCache\simulink_traverse_control.slxc')
                disp('Model failed to run.  Deleting cache (.slxc) and trying again.')
                break
            end
    end
end

disp('Done')