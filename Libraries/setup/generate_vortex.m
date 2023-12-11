% %% Create motion profile to generate a vortex with an oscilating foil
% % 2023/10/09 - ehandy
% % 2023/10/18 - ehandy, last update
%
%% Generate Vortex Motion Profile %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Generates the pitching and heaving motion trajectory for a foil to
% generate a single vortex. The upstroke generates a vortex while the
% downstroke tries to minimize flow separation by feathering the foil to
% the flow.
%
% -------------------------------------------------------------------------
% Example:
%
% [tprof, hprof, pprof, alpha_max] = generate_vortex(0.1, 0.2, 0.4, 0.2, 0.12, 1000, 'sinusoidal')
%
% -------------------------------------------------------------------------
% Inputs: 
%
% chord = chord-length (m)
%
% heave_amp = amplitude of heave stroke (m)
%
% AoAmax = maximum desired effective angle of attack on the upstroke (rad)
%
% U = free-stream velocity (m/s)
%
% fred = reduced frequency fred = freq*c/U
%
% srate = data sample rate (Hz)
%
% profType = type of profile desired:
%
%               > 'sinusoidal' = purely sinusoidal motion with symmetric
%                                heave upstroke and downstroke.
%
%               > 'eldredge' = upstroke motion modulated with Eldredge's
%                              smooth acceleration function, with a slower
%                              downstroke.
%
% -------------------------------------------------------------------------
% Outputs:
%
% tprof = motion profile time vector (s)
%
% hprof = heaving profile (m)
%
% pprof = pitching profile (deg)
%
% alpha_max = maximum effective angle attack achieved during the upstroke
%
% -------------------------------------------------------------------------

function [tprof, hprof, pprof, alpha_max] = generate_vortex(chord, heave_amp, AoAmax, U, fred, srate, profType)

%% Check arguments
if ~strcmp(profType,'eldredge') && ~strcmp(profType,'sinusoidal')
    warning("Profile 'type' not specified, motion default is 'eldredge'.")
    profType = 'eldredge';
end

%% General parameters

dt = 1/srate; % sampling period (s)
N = 20; % approximate motion time (s)

%% Using Eldredge's smooth acceleration function --------------------------
% courtesy of Xiaowei He, as implemented on He and Williams (2020)

if strcmp(profType,'eldredge')

    n = round(0.1/dt); % transition length (samples = seconds / period)
    maxh_fctr = 0.995; % heave amplitude reached threshold (percentage)
    
    as1 = 6; % up-stroke acceleration smoothing factor
    as2 = 4; % down-stroke acceleration smoothing factor

    %% Heave motion
    
    % 1. Up-stroke motion -------------------------------------------------
    
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
    % NOTE: maybe just use a tanh ramp-down?
    
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
    
    % 3. Modulate signals into eachother ----------------------------------
    
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
    
    % 4. Profile smoothing ------------------------------------------------
    
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
    
    % temp plotting
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
    
    % % temp plotting
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

%% Sinusoidal motion profile ----------------------------------------------
    
if strcmp(profType,'sinusoidal')

    freq = fred*U/chord; % real frequency (Hz)
    time_vec_strt = 0:dt:N/4; % time vector before motion starts
    hprof_strt = zeros(size(time_vec_strt)); % heave position before motion starts
    time_vec_stop = 0:dt:N/4; % time vector after motion ends
    hprof_end = zeros(size(time_vec_stop)); % heave position after motion ends

    n = 10; % smoothing range (smoothing factor)

    %% Heave motion

    % 1. Full heave motion --------------------------------------------

    T_cycle = 1/freq;
    time_vec_cyc = 0:dt:T_cycle;
    hprof1 = heave_amp/2 * sin(2*pi*freq.*time_vec_cyc - pi/2) + heave_amp/2;

    tprof = [time_vec_strt(1:end-1), time_vec_cyc+time_vec_strt(end), time_vec_stop(2:end)+time_vec_strt(end)+time_vec_cyc(end)];
    hprof = [hprof_strt(1:end-1), hprof1, hprof_end(2:end)];

    % Determine the indeces for the start and end of the motion (for subsequent use)
    index_strt = length(time_vec_strt);
    index_stop = length(tprof)- length(time_vec_stop);

    %% Pitch motion
    
    % 1. Determine the upstroke angle needed to reach the desired max alpha_effective
    hvel = movmean(gradient(hprof,dt),n); % heaving velocity profile
    [~,idx1p] = max(hprof);
    hvel_max = max(hvel(1:idx1p));
    theta_amp = rad2deg(atan(-hvel_max/U) - AoAmax); % theta_up = alpha_induced + alpha_effective

    % 2. Calculate resulting induced angle of attack
    % The resulting alpha_induced will be matched with the downstroke pitch angle
    % in order to make the alpha_effective == 0
    aoa_ind = rad2deg(atan(-hvel/U)); % theta_down = alpha_induced + 0 

    % 3. Create amplitude modulation function

    % Find the period of time over which we want to modulate the pitching amplitude
    [~,idx2p] = min(aoa_ind);
    [aoa_ind_max,idx3p] = max(aoa_ind);
    idxp_start = idx2p - length(idx2p:idx3p);
    idxp_stop  = idx3p;
    tprofp1 = tprof(idxp_start:idxp_stop);

    % modulating function
    mod_fact = abs(theta_amp/aoa_ind_max);
    modp = mod_fact/2 * sin(2*pi*freq.*(tprofp1-tprofp1(1)) - pi/2) + mod_fact/2;

    % 4. Modulate function
    pprof1 = aoa_ind;
    pprof1(idxp_start:idxp_stop) = pprof1(idxp_start:idxp_stop).*modp;

    % 5. Splice together upstroke and downstroke

    % Find the zero-crossing of aoa_ind to determine where to stitch the upstroke to the downstroke
    [~,idx4p] = max(gradient(aoa_ind(idx2p:idx3p))); % zero-crossing (excluding ramp up and down)

    idx5p = idx4p + idx2p;
    pprof_temp = smooth([pprof1(1:idx5p), aoa_ind(idx5p+1:end)],n);
    
    % 6. Fit a cubic spline to the beggining and end of the profile in order
    % to have a smooth transition into the sinusoidal motion.

    idx6p = index_strt;
    idx7p = index_stop;

    sf = 7; % spline size (smoothing factor for seams)
    p_query = pprof_temp([1:(idx6p-10*sf*n),(idx6p+sf*n):(idx7p-sf*n),(idx7p+10*sf*n):end]);
    t_query = tprof([1:(idx6p-10*sf*n),(idx6p+sf*n):(idx7p-sf*n),(idx7p+10*sf*n):end]);

    pprof_temp2 = smooth(spline(t_query,p_query,tprof),n);

    % 7. Fit another cubic spline in the zero-crossing, the seam between the two sine waves

    p_query2 = pprof_temp2([1:(idx5p-sf*n),(idx5p+sf*n):end]);
    t_query2 = tprof([1:(idx5p-sf*n),(idx5p+sf*n):end]);

    pprof = smooth(spline(t_query2,p_query2,tprof),n);


    % 8. Resulting AoA check
    alpha_eff = rad2deg(atan(-hvel/U)) - pprof'; % alpha_effective = alpha_induced - theta
    % alpha_max = max(alpha_eff);
    alpha_max = alpha_eff(idx2p);
    
    disp(['Maximum resulting effective AoA: ',num2str(alpha_max), ' deg (',num2str(deg2rad(alpha_max)),' rad)']);

    hprof = hprof';

end


end


