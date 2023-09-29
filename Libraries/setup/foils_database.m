%% Foils Database

function foil = foils_database(foiltype, print_properties)

% This function acts as a database for the different foil pairs that may be
% used in the Flume. It requires a string of the desired foil/foils as an
% input.
%
% v2.0.0, Handy, 03/17/2023
% -------------------------------------------------------------------------
% Inputs:
%
% foiltype = string containing the two or three digit code for the desired
%            foil.
%
% print_properties = string, "y". If defined this function will print the
%                    properties of the selected foil to the command line.
%
% -------------------------------------------------------------------------
% Outputs:
%
% foil = structure containing properties of the selected foil:
%           > chord (in m), AR (Aspect Ratio), mass1 (in kg), mass2 (in
%             case there is a foil pair), span (in m), profile (shape),
%             material.
% -------------------------------------------------------------------------
% Examples:
%
% foil = foils_database('A1')
%
% foil = foils_database('A1', [])
%
% foil = foils_database('A1', 'y')
%
% -------------------------------------------------------------------------
% NOTES:
% -------------------------------------------------------------------------

FoilProperties =...
      ["Name:";"Chord [m]:";"AspectRatio:";" Mass1 [kg]:";" Mass2 [kg]:";"    Profile      :"; "Material    :"   ]; % COMMENTS:
E1 =  [ "E1";     0.1;         3.5;          0.450;         0.450;         "Elliptical";       "Carbon fiber"    ]; % Built by someone
A1 =  [ "A1";     0.1;         3.5;          1.026;         1.174;         "Rectangular";      "Aluminum"        ]; % Nick's foils
A2 =  [ "A2";   3*0.0254;      6.0;          0.928;         0.924;         "Rectangular";      "Aluminum"        ]; % Yunxing's foils
A2E = [ "A2E";  3*0.0254;      6.0;          1.000;         1.000;         "Rectangular";      "Aluminum"        ]; % Yunxing's foils with endplates
C1 =  [ "C1";     0.054;       8.28;         0.386;         0.0;           "Cylindrical";      "Carbon fiber"    ]; % Joel's cylinder
V1 =  [ "V1";     0.0535;      7.50;         0.306;         0.0;           "VibrissaeBeem50x"; "PLA3DprintWepoxy"]; % Joel's vibrissae model
EC1 = [ "EC1";    0.0594;      6.81;         0.302;         0.0;           "Elliptical";       "PLA3DprintWepoxy"]; % Joel's vibrissae model
A3E = [ "A2E";    0.061;       6.0;          0.538;         0.538;         "Rectangular";      "Aluminum"        ]; % Eric's main medium foils with endplates
F1E = [ "F1E";  3*0.0254;      6.0;          0.614;         0.0;           "NACA0022";         "Silicone"        ]; % Ian's fishtail foil with shaft extension
A4E = [ "A4E";    0.1;         3.0;          0.500;         0.0;           "NACA0022";         "Acrylic"         ]; % Yuanhang's transparent airfoil


foils = table(FoilProperties, E1, A1, A2, A2E, C1, V1, EC1, A3E, F1E, A4E); % constructing a table out of the foil data

selected_data = foils.(foiltype); % identifies the column of the selected foils

foil.name = selected_data(1);
foil.chord = str2double(selected_data(2)); % asigns first column's value to the chord variable
foil.AR    = str2double(selected_data(3)); % asigns second column's value to the aspect ratio var
foil.mass1 = str2double(selected_data(4)); % asigns third column's value to the leading foil's mass var
foil.mass2 = str2double(selected_data(5)); % asigns fourth column's value to the trailing foil's mass var
foil.span  = foil.chord*foil.AR; % calculates the span
foil.profile  = selected_data(6); % asigns fifth column's value to the geometric profile of the foils
foil.material = selected_data(7); % asigns sixth column's value to the geometric profile of the foils

if exist('print_properties','var')
    if strcmp(print_properties,'y')
        foil % prints out the data of the selected foil
    elseif ~isempty(print_properties)
        error("Wrong argument for input var 'print_properties', must either be 'y' or empty.")
    end
end

end
