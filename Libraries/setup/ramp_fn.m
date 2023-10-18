%% Traverse Offset Ramp Function
% 2023/10/18 - eh, last update
% 
% Used by both traverses in order to smoothly ramp up and down from their
% starting position to offset and bias.
% -------------------------------------------------------------------------
% Inputs:
%
% ramp_time = time in [s] to go from starting position to offset position.
%
% T = sampling period [s] (1/srate).
%
% bias = traverse bias structure.
%
% offset_home = offset distance and angle from the homing (or starting) position of the motors
%               NOTE: This is about where the motion will be generated.
%
% traverse = traverse for which the ramp function will be generated.
%               > 'g' : Parker-Aerotech traverse (formerly 'gromit')
%               > 'w' : Bell-Everman traverse (formerly 'wallace')
% -------------------------------------------------------------------------
% Outputs:
%
% t_ramp = ramp time vector [s]
%
% ramp_p = pitching axis ramp vector [deg]
%
% ramp_h = heaving axis ramp vector [m]
% -------------------------------------------------------------------------

function [t_ramp, ramp_p, ramp_h] = ramp_fn(ramp_time, T, bias, offset_home, traverse)

    switch traverse
        case 'g' % corresponds to the Parker-Aerotech traverse
            offset_p = offset_home(1);
            offset_h = offset_home(2);
            bias_pitch = bias.pitch(1);
            bias_heave = bias.heave(1);
        case 'w' % corresponds to the Bell-Everman traverse
            offset_p = offset_home(3);
            offset_h = offset_home(4);
            bias_pitch = bias.pitch(2);
            bias_heave = bias.heave(2);
    end

    Npts_ramp = ramp_time/T;
    t_ramp = T*(0:Npts_ramp-1); % dimensional ramping time vector
    
    ramp_p = (offset_p+bias_pitch)*(0.5*(1-cos( pi*(0:Npts_ramp-1)/Npts_ramp)))';
    ramp_h = (offset_h+bias_heave)*(0.5*(1-cos( pi*(0:Npts_ramp-1)/Npts_ramp)))';

end


