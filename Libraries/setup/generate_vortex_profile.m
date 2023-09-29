%% Generate motion profile
% This code is ugly and unpolished but generates the motion profile to generate a desired vortex.
% 20230926 - ehandyca

function [time_vector, pitch_motion, heave_motion] = generate_vortex_profile(srate, foil, stdby_time, U, fred_up, pitch_up_amp, heave_up_amp)
% amplitudes are DIMENSIONAL

% Sampling time
dt = 1/srate;

% Heave down-stroke factor
% heave distance at which motion profile slows [hdf*max_amplitude]
hdf = 0.8;

% Up-stroke frequency
freq_up = fred_up*U/foil.chord;

% Down-stroke frequency
fred_dwn = 0.05; % [Hz] Frequency of down motion
freq_dwn = fred_dwn*U/foil.chord;

pitch_dwn_amp = rad2deg(0-atan(-2*pi*heave_up_amp*fred_dwn)); % [deg] pitch amp in down-stroke considering aT4 = 0
heave_dwn_amp = heave_up_amp; % [m] dimensional heave amplitude


%% Full stroke heave piece-wise motion profile

% 1. Up-stroke
up_period = 1/freq_up; % cycle period
num_tsteps = round(up_period/dt); % time steps for cycle

time_vec_1 = (0:num_tsteps)*dt;
heave_fn_1 = heave_up_amp/2*sin(2*pi*freq_up*time_vec_1 - pi/2) + heave_up_amp/2;

% 2. Down-stroke
down_period = 1/freq_dwn; % cycle period
num_tsteps = round(down_period/dt); % time steps for two cycles

[~,indx2] = min(abs(heave_dwn_amp*hdf - heave_fn_1(round(end/2):end)));
time_vec_2 = (0:num_tsteps)*dt;
heave_fn_2 = -(heave_dwn_amp*hdf)*sin(2*pi*freq_dwn*time_vec_2) + (heave_dwn_amp*hdf);
time_vec_2 = time_vec_2 + time_vec_1(indx2 + round(length(heave_fn_1)/2));

% 3. Truncate down-stroke and up-stroke
[~,indx3] = min(heave_fn_2);
time_vec_3 = time_vec_2(1:indx3);
heave_fn_3 = heave_fn_2(1:indx3);
time_vec_4 = time_vec_1(1:indx2 + round(length(heave_fn_1)/2));
heave_fn_4 = heave_fn_1(1:indx2 + round(length(heave_fn_1)/2));

% 4. Remove a range of end-points from the profiles
% down-stroke
time_vec_5 = time_vec_3(101:end);
heave_fn_5 = heave_fn_3(101:end);
% up-stroke
time_vec_6 = time_vec_4(1:end-100);
heave_fn_6 = heave_fn_4(1:end-100);

% 5. Fit a fifth-order polinomial to the whole data
time_vec = 0:dt:time_vec_5(end);
fun_h = fit([time_vec_6,time_vec_5]',[heave_fn_6,heave_fn_5]','spline');
heave_fn = fun_h(time_vec);


%% Full stroke pitch piece-wise motion profile

% 1. Up-stroke
up_period = 1/freq_up; % cycle period
num_tsteps = round(up_period/dt); % time steps for cycle

time_vec_1 = (0:num_tsteps)*dt;
pitch_fn_1 = pitch_up_amp*sin(2*pi*freq_up*time_vec_1 + pi);

% 2. Down-stroke (and align at pitch reversal)
time_vec_2 = (0:round(num_tsteps/2))*dt;
% time_vec_2 = round(num_tsteps/2)*dt:dt:time_vec(end);
pitch_fn_2 = pitch_dwn_amp*sin(2*pi*2*freq_dwn*time_vec_2);
time_vec_2 = (0:round(num_tsteps/2))*dt + time_vec_1(round(end/2));

% 3. Truncate up-stroke
time_vec_3 = time_vec_1(1:round(num_tsteps/2));
pitch_fn_3 = pitch_fn_1(1:round(num_tsteps/2));

% 4. Remove range of endpoints to splice functions together
% up-stroke
time_vec_4 = time_vec_3(1:end-100);
pitch_fn_4 = pitch_fn_3(1:end-100);
% down-stroke
time_vec_5 = time_vec_2(201:end);
pitch_fn_5 = pitch_fn_2(201:end);

% 5. Fit a fifth-order polinomial to the whole data
fun_p = fit([time_vec_4,time_vec_5]',[pitch_fn_4,pitch_fn_5]','spline');
pitch_fn = fun_p(time_vec);

% 6. Modulate pitch ramp-up and ramp-down
[~,indx_up] = min(pitch_fn);
tup = (0:indx_up-1)*dt;
mod_up = 0.5*sin(2*pi*2*freq_up*tup - pi/2) + 0.5;
pitch_fn(1:indx_up) = mod_up'.*pitch_fn(1:indx_up);

[~,indx_dn] = max(pitch_fn);
ramp_freq = 1/abs(time_vec(end)-time_vec(indx_dn));
tdn = (0:length(time_vec(indx_dn+1:end)))*dt;
mod_dn = 0.5*sin(pi*ramp_freq*tdn + pi/2) + 0.5;
pitch_fn(indx_dn:end) = mod_dn'.*pitch_fn(indx_dn:end);


%% Assemble full motions

time_vec_stdby = (0:dt:stdby_time);
time_vector = [time_vec_stdby, time_vec+time_vec_stdby(end), time_vec_stdby+time_vec(end)+time_vec_stdby(end)];
pitch_motion = [zeros(size(time_vec_stdby)), pitch_fn', zeros(size(time_vec_stdby))];
heave_motion = [zeros(size(time_vec_stdby)), heave_fn', zeros(size(time_vec_stdby))];

end












