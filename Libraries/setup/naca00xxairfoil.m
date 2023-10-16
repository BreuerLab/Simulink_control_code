% naca 00xx airfoil coordinates generator
% xh, 03/22/2022
% -------------------------------------------------------------------------
% [foil_x, foil_y] = naca00xxairfoil(naca, c, N, 'cos', 'write2file')
% 
% [foil_x_front, foil_y_front, foil_x_rear, foil_y_rear] = naca00xxairfoil(naca, c, N, 'cos', 'write2file')
% -------------------------------------------------------------------------
% input:
% naca = 00xx;
% c = chord length;
% N = number of data points (odd number);
% 'cos' = cosine distribution of x-coordinate from leading edge;
% 'split' = split coordinates into front and rear at maximum thickness;
% 'write2file' = write to .txt, .csv, or .dat file, two sets of files if coordinate split enabled;
% 'write2file' can be 'txt', 'csv', or 'dat';
% -------------------------------------------------------------------------
% output:
% [foil_x, foil_y]
% foil_x = x-coordinate vector, trailing edge -> leading edge -> trailing edge;
% foil_y = y-coordinate vector, trailing edge -> leading edge -> trailing edge;
%
% [foil_x_front, foil_y_front, foil_x_rear, foil_y_rear]
% foil_x_front = x-coordinate vector, max thickness -> leading edge -> max thichness;
% foil_y_front = y-coordinate vector, max thickness -> leading edge -> max thichness;
% foil_x_rear = x-coordinate vector, max thickness -> trailing edge -> max thichness;
% foil_y_rear = y-coordinate vector, max thickness -> trailing edge -> max thichness;
%
% examples:
% linear x-coordinates without writing to file:
% [foil_x, foil_y] = naca00xxairfoil(naca, c, N)
%
% consine x-coordinates with writing to a .txt file:
% [foil_x, foil_y] = naca00xxairfoil(naca, c, N, 'cos', 'txt')
%
% linear x-coordinates splitted at max thickness with writing to a set of .csv file:
% [foil_x_front, foil_y_front, foil_x_rear, foil_y_rear] = naca00xxairfoil(naca, c, N, 'csv')
% -------------------------------------------------------------------------
function [varargout] = naca00xxairfoil(naca, c, N, strflag1, strflag2)
    % determine input
    if nargin == 3
        % linear x
        xlin = linspace(0, 1, N)';
        ylin = 5*(naca/100)*(0.2969*xlin.^0.5-0.126*xlin-0.3516*xlin.^2+0.2843*xlin.^3-0.1015*xlin.^4);
        xfoil = c*[flip(xlin(2:end)); xlin];
        yfoil = c*[flip(ylin(2:end)); -ylin];
    elseif nargin == 4 && strcmpi(strflag1, 'cos')
        % cosine x
        xcos = (2*1 - 0)*(0.5*(1-cos(linspace(0, pi/2, N))))' + 0;
        ycos = 5*(naca/100)*(0.2969*xcos.^0.5-0.126*xcos-0.3516*xcos.^2+0.2843*xcos.^3-0.1015*xcos.^4);
        xfoil = c*[flip(xcos(2:end)); xcos];
        yfoil = c*[flip(ycos(2:end)); -ycos];
    elseif nargin == 4 && (strcmpi(strflag1, 'txt') || strcmpi(strflag1, 'csv') || strcmpi(strflag1, 'dat'))
        % linear x
        xlin = linspace(0, 1, N)';
        ylin = 5*(naca/100)*(0.2969*xlin.^0.5-0.126*xlin-0.3516*xlin.^2+0.2843*xlin.^3-0.1015*xlin.^4);
        xfoil = c*[flip(xlin(2:end)); xlin];
        yfoil = c*[flip(ylin(2:end)); -ylin];
        if nargout == 2
            % no split
            foil = table([xfoil, yfoil]);
            writetable(foil, ['naca' num2str(naca, '%04.f') '_c' num2str(c) '_linear.' strflag1], ...
                       'WriteVariableNames', 0)
        elseif nargout == 4
            % split at max thickness
            [~, imx] = max(yfoil);
            [~, imn] = min(yfoil);
            xfoilf = xfoil(imx:imn);
            yfoilf = yfoil(imx:imn);
            xfoilr = [flip(xfoil(1:imx)); flip(xfoil(imn:end))];
            yfoilr = [flip(yfoil(1:imx)); flip(yfoil(imn:end))];
            foilf = table([xfoilf, yfoilf]);
            foilr = table([xfoilr, yfoilr]);
            writetable(foilf, ['naca' num2str(naca, '%04.f') '_c' num2str(c) '_linear_front.' strflag1], ...
                       'WriteVariableNames', 0)
            writetable(foilr, ['naca' num2str(naca, '%04.f') '_c' num2str(c) '_linear_rear.' strflag1], ...
                       'WriteVariableNames', 0)
        end
    elseif nargin == 5 && strcmpi(strflag1, 'cos') && (strcmpi(strflag2, 'txt') || strcmpi(strflag2, 'csv') || strcmpi(strflag2, 'dat'))
        % cosine x
        xcos = (2*1 - 0)*(0.5*(1-cos(linspace(0, pi/2, N))))' + 0;
        ycos = 5*(naca/100)*(0.2969*xcos.^0.5-0.126*xcos-0.3516*xcos.^2+0.2843*xcos.^3-0.1015*xcos.^4);
        xfoil = c*[flip(xcos(2:end)); xcos];
        yfoil = c*[flip(ycos(2:end)); -ycos];
        if nargout == 2
            % no split
            foil = table([xfoil, yfoil]);
            writetable(foil, ['naca' num2str(naca, '%04.f') '_c' num2str(c) '_cosine.' strflag2], ...
                       'WriteVariableNames', 0)
        elseif nargout == 4
            % split at max thickness
            [~, imx] = max(yfoil);
            [~, imn] = min(yfoil);
            xfoilf = xfoil(imx:imn);
            yfoilf = yfoil(imx:imn);
            xfoilr = [flip(xfoil(1:imx)); flip(xfoil(imn:end))];
            yfoilr = [flip(yfoil(1:imx)); flip(yfoil(imn:end))];
            foilf = table([xfoilf, yfoilf]);
            foilr = table([xfoilr, yfoilr]);
            writetable(foilf, ['naca' num2str(naca, '%04.f') '_c' num2str(c) '_cosine_front.' strflag2], ...
                       'WriteVariableNames', 0)
            writetable(foilr, ['naca' num2str(naca, '%04.f') '_c' num2str(c) '_cosine_rear.' strflag2], ...
                       'WriteVariableNames', 0)
        end
    else
        error('input arguments error')
    end
    
    % output
    if nargout == 2
        % no split
        varargout{1} = xfoil;
        varargout{2} = yfoil;
    elseif nargout == 4
        % split at max thickness
        [~, imx] = max(yfoil);
        [~, imn] = min(yfoil);
        xfoilf = xfoil(imx:imn);
        yfoilf = yfoil(imx:imn);
        xfoilr = [flip(xfoil(1:imx)); flip(xfoil(imn:end))];
        yfoilr = [flip(yfoil(1:imx)); flip(yfoil(imn:end))];

        varargout{1} = xfoilf;
        varargout{2} = yfoilf;
        varargout{3} = xfoilr;
        varargout{4} = yfoilr;
    else
        error('output arguments error')
    end
end