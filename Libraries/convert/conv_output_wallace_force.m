function out = conv_output_wallace_force(dat,Wbias)
% Wallace always refers to the downstream traverse.
% As of 2023/09/24 the upstream traverse is the old Parker-AeroTech traverse.

% Currently mounted sensor: Delta IP65, FT16811
% Part number SI-165-15
% CalDate = 5/24/2019

Wallace_Cal = [-0.35809  -0.01618   0.33848 -17.46307   0.89047  16.87724;
                0.15593  21.55978  -0.78597 -10.04538   0.43001  -9.68643;
               29.89951   0.37537  29.69256   0.45784  30.54626   0.60145;
                0.00323   0.49295  -1.03800  -0.24341   1.06263  -0.20340;
                1.21724   0.01128  -0.58994   0.39180  -0.63121  -0.39537;
               -0.00657  -0.71607   0.01762  -0.66346  -0.04251  -0.64421];

dat = dat-repmat(Wbias,numel(dat(:,1)),1);
out = dat*Wallace_Cal';