function out = conv_output_gromit_force(dat,Gbias)
% Gromit always refers to the upstream traverse.
% As of 2023/09/24 the upstream traverse is the Bell-Everman traverse.

% Currently mounted sensor: Delta IP65, FT16810
% Part number SI-165-15
% CalDate = 4/10/2019

Gromit_Cal = [-0.02196   0.00419  -0.18612 -17.48351   1.22423  16.64416;
               0.96534  19.79354  -0.23317 -10.13370  -0.76519  -9.66913;
              29.81128   0.07585  30.34957   0.45068  29.88613   0.42909;
               0.01875   0.45533  -1.04343  -0.24517   1.02371  -0.20924;
               1.18230  -0.00140  -0.58680   0.39485  -0.64106  -0.38929;
              -0.02868  -0.63898  -0.01154  -0.65955  -0.04413  -0.62759];

dat = dat-repmat(Gbias,numel(dat(:,1)),1);
out = dat*Gromit_Cal';
