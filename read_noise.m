%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% PSYCH 221 Final Project - Google Pixel 4 Camera Noise Estimation 
% File for loading raw data and calculating read noise 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Init
ieInit;

%% Use sensorIMX363 for creating sensor base model
% This is the sensor used on the Pixel 4a

sensor = sensorCreate('IMX363');

%% Load files and calculate dark noise

folder_list = dir('ReadNoise/ISO_*');

% Variables to keep our data in
iso_stds = zeros(length(folder_list),1);
iso_stds_r = zeros(length(folder_list),1);
iso_stds_g = zeros(length(folder_list),1);
iso_stds_b = zeros(length(folder_list),1);
iso_stds_g_ave = zeros(length(folder_list),1);
iso_stds_g1 = zeros(length(folder_list),1);
iso_stds_g2 = zeros(length(folder_list),1);
iso_values = zeros(length(folder_list),1);
iso_means = zeros(length(folder_list),1);
for i = 1:length(folder_list)
    file_list = dir(append('ReadNoise/', folder_list(i).name, '/*.dng'));
    iso_value = str2double(folder_list(i).name(5:end));
    stds = zeros(length(file_list),1);
    means = zeros(length(file_list),1);
    stds_r = zeros(length(file_list),1);
    stds_g = zeros(length(file_list),1);
    stds_b = zeros(length(file_list),1);
    stds_g_ave = zeros(length(file_list),1);
    stds_g1 = zeros(length(file_list),1);
    stds_g2 = zeros(length(file_list),1);
    for j = 1:length(file_list)
        fname = append(file_list(j).folder, '/', file_list(j).name);
        [img, info] = ieDNGRead(fname);
        img_mV = sensor.pixel.voltageSwing/1023*1e3*img;
        [r, g, b, g_ave, g1, g2] = separateRGBBayer(img_mV);
        means(j) = mean(double(img_mV), 'all');
        stds(j) = std2(img_mV);
        stds_r(j) = std2(r);
        stds_g(j) = std2(g);
        stds_b(j) = std2(b);
        stds_g_ave(j) = std2(g_ave);
        stds_g1(j) = std2(g1);
        stds_g2(j) = std2(g2);
    end
    iso_stds(i) = mean(stds);
    iso_values(i) = iso_value;
    iso_means(i) = mean(means(j));
    iso_stds_r(i) = mean(stds_r);
    iso_stds_g(i) = mean(stds_g);
    iso_stds_b(i) = mean(stds_b);
    iso_stds_g_ave(i) = mean(stds_g_ave);
    iso_stds_g1(i) = mean(stds_g1);
    iso_stds_g2(i) = mean(stds_g2);

end
%% Make histogram
folder_list = dir('ReadNoise/ISO_7*');
file_list = dir(append('ReadNoise/', folder_list(1).name, '/*.dng'));
fname = append(file_list(1).folder, '/', file_list(1).name);
[img, info] = ieDNGRead(fname);
img_mV = sensor.pixel.voltageSwing/1023*1e3*img;
[r, g, b, g_ave, g1, g2] = separateRGBBayer(img_mV);
chartTitle = 'ISO798';
figure,
plotHist(r,g,b, chartTitle)
%% Make Line Plot
figure,
set(gcf, 'units', 'normalized');
gradient_r = plotLine(iso_values,iso_stds_r, '#D95319','o','-');
hold on
gradient_g1 = plotLine(iso_values,iso_stds_g1, '#598C30','*' ,'-');
hold on
gradient_g2 = plotLine(iso_values,iso_stds_g2, '#77AC30','+' ,'-.');
hold on
gradient_g_ave = plotLine(iso_values,iso_stds_g_ave, '#97BC40','d' ,'-.');
hold on
gradient_b = plotLine(iso_values,iso_stds_b, '#0072BD','x','--');
legend(append('R: slope = ',num2str(1e3*gradient_r), ' uV/ISO'),'', ...
    append('G1: slope = ',num2str(1e3*gradient_g1), ' uV/ISO'),'', ...
    append('G2: slope = ',num2str(1e3*gradient_g2), ' uV/ISO'),'', ...
    append('G averaged: slope = ',num2str(1e3*gradient_g_ave), ' uV/ISO'),'', ...
    append('B: slope = ',num2str(1e3*gradient_b), ' uV/ISO'),...
    'Location','northwest')

set(gcf, 'Position', [0.5, 0.5, 0.33, 0.4]);
saveas(gcf,'read_noise4.png')
hold off

%%
function plotHist(r,g,b, chartTitle)
    
    channels = {r, g ,b};
    color_names = {'R', 'G', 'B'};
    colors = {'#D95319', '#77AC30', '#0072BD'};
    annotation_dim_y = {.66, .36, .06};
    x = 20:0.1:35;
    
    % Loop over different channels
    for i = 1:3
        subplot(3,1,i);

        c = channels{i};
        
        % Plot histogram
        histogram(c, max(max(double(c))) - min(min(double(c)))+1, 'faceColor', colors{i})
        hold on
        
        % Plot norm pdf
        plot(x,normpdf(x, mean2(c),std2(c))*prod(size(c)), 'k--')
        dim = [.37 annotation_dim_y{i} .2 .2];

        str = append('\sigma = ', num2str(round(std2(c),1)), ' mV');
        annotation('textbox',dim,'String',str,'FitBoxToText','on');
        legend(color_names{i})
        ylabel('Counts')
        xlim([0 60])
        if i == 1
            title(chartTitle)
        end
        hold off
    end
end

%% plotLine function
function output = plotLine(iso_values, iso_stds, color, stylePoints, styleLine)
    % Fit linear least squares
    iso_values_1 = [ones(length(iso_values),1) iso_values];
    b = iso_values_1\iso_stds;
    % Plot data
    plot(iso_values,iso_stds, stylePoints, 'Color', color,'LineWidth',1.5)
    hold on
    x = 0:798;
    % Plot fit
    plot(x,b(1)+b(2)*x, styleLine, 'Color', color,'LineWidth',1.5)
    title('Read noise vs ISO')
    ylim([0 2.3])
    xlabel('ISO')
    ylabel('RMS Noise (mV)')
    saveas(gcf, 'ISO_vs_Read_Noise.png')
    output = b(2);
end

%% Separate RGB
function [r, g, b, g_ave, g1, g2] = separateRGBBayer(img_all)
    r = img_all(1:2:end,1:2:end);
    g1 = img_all(1:2:end,2:2:end);
    g2 = img_all(2:2:end,1:2:end);
    g_ave = (g1+g2)/2;
    g = reshape([g1(:) g2(:)]',2*size(g1,1), []);
    b = img_all(2:2:end,2:2:end);
end



