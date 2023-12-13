%% Find zero pitch simulink
sampleTime = 1/Parameters.sampleRate;
%% Alignment
disp(['Aligning ',traverse, ' traverse.']);
repeatFindZeroPitchFlag = 1;
while repeatFindZeroPitchFlag == 1
    %% Generate profiles
    % for initial search:
    scanTime = 6;
    pitchAmpDeg = 5;
    expandSearchFlag = 0;

    while expandSearchFlag < 1 %% <2 for expanding search ***
        expandSearchFlag = expandSearchFlag + 1;

        [times, pitchDegreesG, heaveMetersG, pitchDegreesW, heaveMetersW, syncSig] = ...
            trajectory_find_zero_pitch(Parameters.sampleRate,MotorPositions, scanTime, pitchAmpDeg, traverse);
        % simulation time
        simTime = ceil(times(end))+2;
        disp(['Expected simulation time: ', num2str(simTime), ' seconds']);
        
        % pass parameters for gromit heave gain in simulation
        freqGain = 0; heaveGain = 0;
    
        %% Run traverse

        % clear variables before next experiment
        clear rawEncoderPitchCountsG rawEncoderHeaveCountsG rawEncoderPitchCountsW rawEncoderHeaveCountsW ...
            rawForceVoltsW rawForceVoltsG   rawVoltsVectrino rawVoltsAccelmeter refSig

        disp(['Finding zero pitch.  Traverse will now move to +/- ',num2str(pitchAmpDeg),' degrees']);
        set_param('simulink_traverse_control','SimulationCommand','start');
        
        disp('Running traverse...')
        % NOTE: this needs to account for the build time
        pause(simTime+6);
        
        % check if data is
        while ~exist('refSig','var')
            pause(5)
            disp('Loading...')
        end
        % Put raw measurements into a single structure
        Measurements.rawEncoderHeaveCountsG = rawEncoderHeaveCountsG;
        Measurements.rawEncoderHeaveCountsW = rawEncoderHeaveCountsW;
        Measurements.rawEncoderPitchCountsG = rawEncoderPitchCountsG;
        Measurements.rawEncoderPitchCountsW = rawEncoderPitchCountsW;
        Measurements.rawForceVoltsW = rawForceVoltsW;
        Measurements.rawForceVoltsG = rawForceVoltsG;
        Measurements.rawVoltsVectrino = rawVoltsVectrino;
        Measurements.rawVoltsAccelmeter = rawVoltsAccelmeter;
        Measurements.refSig = refSig;
        disp('Done')
    
        %% Convert data
        rangeTimes = 1:length(rawEncoderPitchCountsG);
        rawEncoders = [rawEncoderPitchCountsG, rawEncoderHeaveCountsG, rawEncoderPitchCountsW, rawEncoderHeaveCountsW];
        Data = convert_output(rawEncoders, rawForceVoltsW, rawForceVoltsG, rawVoltsVectrino, rawVoltsAccelmeter, refSig, Biases.Initial, rangeTimes, Parameters);

        %% Extract relevant forces for analysis
        k = find(refSig == 1); % inices of non-zero elements
        
        rangePosSweep = k(1):k(2); % range of positive angle sweep
        rangeNegSweep = k(3):k(4); % range of negative angle sweep
    
        switch traverse
            case 'Gromit'
                Fy_pos = Data.forcesNewtonsG(rangePosSweep,2);
                pitch_pos = Data.pitchDegreesG(rangePosSweep);
                Fy_neg = Data.forcesNewtonsG(rangeNegSweep,2);
                pitch_neg = Data.pitchDegreesG(rangeNegSweep);
            case 'Wallace'
                Fy_pos = Data.forcesNewtonsW(rangePosSweep,2);
                pitch_pos = Data.pitchDegreesW(rangePosSweep);
                Fy_neg = Data.forcesNewtonsW(rangeNegSweep,2);
                pitch_neg = Data.pitchDegreesW(rangeNegSweep);
        end
    
        startPitchDegPosSweep = pitch_pos(1);
        slopeDegPosSweep = (pitch_pos(end)-startPitchDegPosSweep)/(scanTime*Parameters.sampleRate);
    
        startPitchDegNegSweep = pitch_neg(1);
        slopeDegNegSweep = (pitch_neg(end)-startPitchDegNegSweep)/(scanTime*Parameters.sampleRate);
    
        %% Linear fits on curves
        FyCoef_pos = polyfit(1:numel(Fy_pos), smooth(Fy_pos,100)', 1);
        aL_pos = FyCoef_pos(1);
        bL_pos = FyCoef_pos(2);
    
        FyCoef_neg = polyfit(1:numel(Fy_neg), smooth(Fy_neg,100)', 1);
        aL_neg = FyCoef_neg(1);
        bL_neg = FyCoef_neg(2);
    
        %% Expanding search    
        if max(aL_pos*(1:numel(Fy_pos))+bL_pos) < 0 || min(aL_pos*(1:numel(Fy_pos))+bL_pos) > 0
            if expandSearchFlag == 2
                disp('Pitch out of range. Align manually.')
                break
            else
                disp('Pitch out of range. Expanding search...')
                scanTime = 10;
                pitchAmpDeg = 10;
            end
        else
            break
        end

    end % expand search end

    %% Calculate the average pitch bias
    pitchOffsetDegPosSweep = slopeDegPosSweep*(-bL_pos/aL_pos) + startPitchDegPosSweep;
    pitchOffsetDegNegSweep = slopeDegNegSweep*(-bL_neg/aL_neg) + startPitchDegNegSweep;
    newPitchOffsetDeg = mean([pitchOffsetDegPosSweep, pitchOffsetDegNegSweep]);
    disp(['Pitch offset (degrees): ', num2str(newPitchOffsetDeg)])

%% Plot the results
        figure;
%         plot(1:numel(pitch_pos), pitch_pos, 1:numel(Fy_pos), smooth(Fy_pos,100), 1:numel(Fy_pos), aL_pos*(1:numel(Fy_pos))+bL_pos); hold on;
%         plot(1:numel(pitch_neg), pitch_neg, 1:numel(Fy_neg), smooth(Fy_neg,100), 1:numel(Fy_neg), aL_neg*(1:numel(Fy_neg))+bL_neg); hold off;
%         legend('Pitch negative','Fy smoothed','Linear fit','Pitch positive','Fy smoothed','Linear fit');
        plot(pitch_pos, Fy_pos,pitch_pos, aL_pos*(1:numel(Fy_pos))+bL_pos); hold on;
        plot(pitch_neg, Fy_neg,pitch_neg, aL_neg*(1:numel(Fy_neg))+bL_neg); 
        plot([newPitchOffsetDeg newPitchOffsetDeg],[-1 1],'LineStyle','--','Color','red'); hold off;
        legend('Fy smoothed','Linear fit','Fy smoothed','Linear fit')
        xlabel('Pitch (degrees)')
        ylabel('Force along y-axis of force sensor')
    
    %% Ask the user if they would like to repeat find zero pitch for other traverse
    pitchCheck = input(['Does this look alright to you? y/n + Enter', newline],"s");
%     % bypass input
%     pitch_check = 'y';

    if strcmp(pitchCheck,'y')
        switch traverse
            case 'Gromit'
        Parameters.pitchOffsetDegG = newPitchOffsetDeg+Parameters.pitchOffsetDegG;
            case 'Wallace'
        Parameters.pitchOffsetDegW = newPitchOffsetDeg+Parameters.pitchOffsetDegW;
        end
        disp([traverse, ' pitch bias updated'])
        break; % terminate while loop
    else
        disp([traverse, ' pitch bias not updated'])
        repeat_response = input(['Would you like to repeat find_zero_pitch for ',traverse,'? y/n + Enter',newline],"s");
        if strcmp(repeat_response,'n')
            break; % terminate while loop
        end
    end


end % repeat alignment search

% %% Plot force direction
% figure;
% pitch = out(rangePosSweep,prof_index);
% forceTorqueGromit = Data.forcesNewtonsG(rangePosSweep,2); %out(rangePosSweep,fy_index-1:fy_index+4);
% zerosVector = zeros(length(pitch),1);
% raw_force_gromit_labFrame_x = sum([cos(pitch) -sin(pitch)].*forceTorqueGromit(:,1:2),2);
% raw_force_gromit_labFrame_y = sum([sin(pitch) cos(pitch)].*forceTorqueGromit(:,1:2),2);
% raw_force_gromit_labFrame_z = forceTorqueGromit(:,3);
% raw_torque_gromit_labFrame_x = sum([cos(pitch) -sin(pitch)].*forceTorqueGromit(:,4:5),2);
% raw_torque_gromit_labFrame_y = sum([sin(pitch) cos(pitch)].*forceTorqueGromit(:,4:5),2);
% raw_torque_gromit_labFrame_z = forceTorqueGromit(:,6);
% hold on;
% plot(pitch,raw_force_gromit_labFrame_x,pitch,raw_force_gromit_labFrame_y,pitch,raw_force_gromit_labFrame_z)
% plot(pitch,raw_torque_gromit_labFrame_x,pitch,raw_torque_gromit_labFrame_y,pitch,raw_torque_gromit_labFrame_z)
% legend('Fx','Fy','Fz','Tx','Ty','Tz')
% ylabel('Forces and Torques')
% xlabel('Pitch ()')
% hold off;

%% Save bias into a subfolder within the active saving folder

dateAndTime = clock;
dataFolderName = [Parameters.dataFolderName,'\data'];

% Check how many bias files have been created in order to name the current one being generated
findZeroPitchFiles = dir([dataFolderName,'\FindZeroPitch*']);
numFindZeroPitchFiles = numel(findZeroPitchFiles);
filename = [dataFolderName,'\FindZeroPitch_',num2str(numFindZeroPitchFiles)];
save(filename,"Biases","Measurements","Parameters","Data","dateAndTime");
