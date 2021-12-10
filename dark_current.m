%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% PSYCH 221 Final Project - Google Pixel 4 Camera Noise Estimation 
% File for loading raw data and calculating dark noise 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Init
ieInit;
%% Use sensorIMX363 for creating sensor base model
% This is the sensor used on the Pixel 4a
sensor = sensorCreate('IMX363');

%% Make list of files
fileinfo = readtable('DarkCurrentRate/fileinfo.xlsx');
% Remove first part of file path
for i = 1:height(fileinfo)
    shortened = fileinfo.fname{i}(47:end);
    fileinfo.fname{i} = shortened;
end

%%
section1 = [1:500; 1:500];
section2 = [1501:2000; 2001:2500];
for i = 1:height(fileinfo)
    disp(i)
    fname = fileinfo.fname{i};
    [img_all, info] = ieDNGRead(fname);   
    img_1 = img_all(section1);
    img_2 = img_all(section2);
    [r, g, b] = separateRGBBayer(img_all);
    [r1, g1, b1] = separateRGBBayer(img_1);
    [r2, g2, b2] = separateRGBBayer(img_2);
    fileinfo.m_r(i) = mean2(r);
    fileinfo.m_g(i) = mean2(g);
    fileinfo.m_b(i) = mean2(b);
    fileinfo.m_r1(i) = mean2(r1);
    fileinfo.m_g1(i) = mean2(g1);
    fileinfo.m_b1(i) = mean2(b1);
    fileinfo.m_r2(i) = mean2(r2);
    fileinfo.m_g2(i) = mean2(g2);
    fileinfo.m_b2(i) = mean2(b2);
end
%% Average across each image of same exposure and speed
file_info_averaged = groupsummary(fileinfo,{'exposure','speed'},'mean', ...
    {'m_r', 'm_g', 'm_b', 'm_r1', 'm_g1', 'm_b1', 'm_r2', 'm_g2', 'm_b2'});

%% Plot Volts vs exposure and save gradients
sp = unique(file_info_averaged.speed);
slope = zeros(length(sp),1);
intercept = zeros(length(sp),1);
for color =1:9
    color
    for i = 1:length(sp)
        figure,
        ex = file_info_averaged(file_info_averaged.speed == sp(i),:).exposure;
        if color == 1
            me = file_info_averaged(file_info_averaged.speed == sp(i),:).mean_m_r;
            color_pos = 'R';
        elseif color == 2
            me = file_info_averaged(file_info_averaged.speed == sp(i),:).mean_m_g;
            color_pos = 'G';
        elseif color == 3
            me = file_info_averaged(file_info_averaged.speed == sp(i),:).mean_m_b;
            color_pos = 'B';
        elseif color == 4
            me = file_info_averaged(file_info_averaged.speed == sp(i),:).mean_m_r1;
            color_pos = 'R position 1';
        elseif color == 5
            me = file_info_averaged(file_info_averaged.speed == sp(i),:).mean_m_g1;
            color_pos = 'G position 1';
        elseif color == 6
            me = file_info_averaged(file_info_averaged.speed == sp(i),:).mean_m_b1;
            color_pos = 'B position 1';
        elseif color == 7
            me = file_info_averaged(file_info_averaged.speed == sp(i),:).mean_m_r2;
            color_pos = 'R position 2';
        elseif color == 8
            me = file_info_averaged(file_info_averaged.speed == sp(i),:).mean_m_g2;
            color_pos = 'G position 2';
        elseif color == 9
            me = file_info_averaged(file_info_averaged.speed == sp(i),:).mean_m_b2;
            color_pos = 'G position 2';
        end
        % do voltage conversion
        me_mV = sensor.pixel.voltageSwing/1023*1e3*me;
        % determine linear fit
        ex_1 = [ones(length(ex),1) ex];
        b = ex_1\me_mV;
        str1 = append('Slope = ', num2str(b(2)), ' mV/s');
        str2 = append('Intercept = ', num2str(b(1)), ' mV');
        slope(i) = b(2);
        intercept(i) = b(1);
        dim = [.2 .5 .3 .3];
        plot(ex, me_mV,'bx');
        hold on
        ex_2 = linspace(0,ex(end),100);
        plot(ex_2,b(1)+b(2)*ex_2,'--r')
        title(append('Dark noise, ',color_pos,', ISO', num2str(sp(i))))
        annotation('textbox',dim,'String',{str1, str2},'FitBoxToText','on');
        xlabel('Exposure (s)')
        ylabel('Voltage (mV)')
        saveas(gcf, append('ISO',num2str(sp(i)), color_pos, '_DarkNoise.png'))
        hold off
    end
    if color == 1
        slope_R = slope;
        intercept_R = intercept;
    elseif color == 2
        slope_G = slope;
        intercept_G = intercept;
    elseif color == 3
        slope_B = slope;
        intercept_B = intercept;
    elseif color == 4
        slope_R1 = slope;
        intercept_R1 = intercept;
    elseif color == 5
        slope_G1 = slope;
        intercept_G1 = intercept;
    elseif color == 6
        slope_B1 = slope;
        intercept_B1 = intercept;
    elseif color == 7
        slope_R2 = slope;
        intercept_R2 = intercept;
    elseif color == 8
        slope_G2 = slope;
        intercept_G2 = intercept;
    elseif color == 9
        slope_B2 = slope;
        intercept_B2 = intercept;
    end
end

% make table
speed = sp;
slopeTable = table(speed, slope_R, slope_G, slope_B, slope_R1, slope_G1, ...
    slope_B1, slope_R2, slope_G2, slope_B2, intercept_R, intercept_G, ...
    intercept_B, intercept_R1, intercept_G1, intercept_B1, intercept_R2, ...
    intercept_G2, intercept_B2);

%%
slope_array_smaller = table2array(table(slope_R, slope_G, slope_B));

%% Plot bar chart
figure,
x = categorical({'55','99','198','299','395','798'});
x = reordercats(x,{'55','99','198','299','395','798'});
b = bar(x,slope_array_smaller, 'FaceColor', 'flat');
legend('R', 'G', 'B', 'Location','northwest')
xlabel('ISO value')
ylabel('mV/s')
title('Dark Voltage')
b(1).FaceColor = '#D95319';
b(2).FaceColor = '#77AC30';
b(3).FaceColor = '#0072BD';

saveas(gcf, append('DarkCurrent.png'))

%% Separate RGB
function [r, g, b] = separateRGBBayer(img_all)
    r = img_all(1:2:end,1:2:end);
    g1 = img_all(1:2:end,2:2:end);
    g2 = img_all(2:2:end,1:2:end);
    g = reshape([g1(:) g2(:)]',2*size(g1,1), []);
    b = img_all(2:2:end,2:2:end);
end
