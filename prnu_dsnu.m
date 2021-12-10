%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% PSYCH 221 Final Project - Google Pixel 4 Camera Noise Estimation 
% File for loading raw data and estimating PRNU and DSNU 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% load files 


img_path = "PRNU_DSNU/ISO_55/";
[info_55, img_55, exp_55] = loadFile(img_path);

pimg_path = "PRNU_DSNU/ISO_99/";
[info_99, img_99, exp_99] = loadFile(img_path);

img_path = "PRNU_DSNU/ISO_198/";
[info_198, img_198, exp_198] = loadFile(img_path);

img_path = "PRNU_DSNU/ISO_299/";
[info_299, img_299, exp_299] = loadFile(img_path);

img_path = "PRNU_DSNU/ISO_395/";
[info_395, img_395, exp_395] = loadFile(img_path);

img_path = "PRNU_DSNU/ISO_798/";
[info_798, img_798, exp_798] = loadFile(img_path);

% Extract R,G,B values from chunky format into separate matrices 
img_55_b = img_55(:, 1:2:end, 1:2:end);
img_55_g = img_55(:, 1:2:end, 2:2:end);
img_55_r = img_55(:, 2:2:end, 2:2:end);

img_99_b = img_99(:, 1:2:end, 1:2:end);
img_99_g = img_99(:, 1:2:end, 2:2:end);
img_99_r = img_99(:, 2:2:end, 2:2:end);

img_198_b = img_198(:, 1:2:end, 1:2:end);
img_198_g = img_198(:, 1:2:end, 2:2:end);
img_198_r = img_198(:, 2:2:end, 2:2:end);

img_299_b = img_299(:, 1:2:end, 1:2:end);
img_299_g = img_299(:, 1:2:end, 2:2:end);
img_299_r = img_299(:, 2:2:end, 2:2:end);

img_395_b = img_395(:, 1:2:end, 1:2:end);
img_395_g = img_395(:, 1:2:end, 2:2:end);
img_395_r = img_395(:, 2:2:end, 2:2:end);

img_798_b = img_798(:, 1:2:end, 1:2:end);
img_798_g = img_798(:, 1:2:end, 2:2:end);
img_798_r = img_798(:, 2:2:end, 2:2:end);

%%
% compute prnu and dsnu vectors for each ISO speed and each color
% channel 

pos_idx = [700, 800, 700, 800];

% exp 55
[prnu_55_r, dsnu_55_r] = cal_prnu_dsnu(img_55_r, exp_55, pos_idx);
prnu_55_r_v = pix2volt(prnu_55_r, 55);
dsnu_55_r_v = pix2volt(dsnu_55_r, 55);
[prnu_55_g, dsnu_55_g] = cal_prnu_dsnu(img_55_g, exp_55, pos_idx);
prnu_55_g_v = pix2volt(prnu_55_g, 55);
dsnu_55_g_v = pix2volt(dsnu_55_g, 55);
[prnu_55_b, dsnu_55_b] = cal_prnu_dsnu(img_55_b, exp_55, pos_idx);
prnu_55_b_v = pix2volt(prnu_55_b, 55);
dsnu_55_b_v = pix2volt(dsnu_55_b, 55);

% exp 99
[prnu_99_r, dsnu_99_r] = cal_prnu_dsnu(img_99_r, exp_99, pos_idx);
prnu_99_r_v = pix2volt(prnu_99_r, 99);
dsnu_99_r_v = pix2volt(dsnu_99_r, 99);
[prnu_99_g, dsnu_99_g] = cal_prnu_dsnu(img_99_g, exp_99, pos_idx);
prnu_99_g_v = pix2volt(prnu_99_g, 99);
dsnu_99_g_v = pix2volt(dsnu_99_g, 99);
[prnu_99_b, dsnu_99_b] = cal_prnu_dsnu(img_99_b, exp_99, pos_idx);
prnu_99_b_v = pix2volt(prnu_99_b, 99);
dsnu_99_b_v = pix2volt(dsnu_99_b, 99);

% exp 198
[prnu_198_r, dsnu_198_r] = cal_prnu_dsnu(img_198_r, exp_198, pos_idx);
prnu_198_r_v = pix2volt(prnu_198_r, 198);
dsnu_198_r_v = pix2volt(dsnu_198_r, 198);
[prnu_198_g, dsnu_198_g] = cal_prnu_dsnu(img_198_g, exp_198, pos_idx);
prnu_198_g_v = pix2volt(prnu_198_g, 198);
dsnu_198_g_v = pix2volt(dsnu_198_g, 198);
[prnu_198_b, dsnu_198_b] = cal_prnu_dsnu(img_198_b, exp_198, pos_idx);
prnu_198_b_v = pix2volt(prnu_198_b, 198);
dsnu_198_b_v = pix2volt(dsnu_198_b, 198);

% exp 299
[prnu_299_r, dsnu_299_r] = cal_prnu_dsnu(img_299_r, exp_299, pos_idx);
prnu_299_r_v = pix2volt(prnu_299_r, 299);
dsnu_299_r_v = pix2volt(dsnu_299_r, 299);
[prnu_299_g, dsnu_299_g] = cal_prnu_dsnu(img_299_g, exp_299, pos_idx);
prnu_299_g_v = pix2volt(prnu_299_g, 299);
dsnu_299_g_v = pix2volt(dsnu_299_g, 299);
[prnu_299_b, dsnu_299_b] = cal_prnu_dsnu(img_299_b, exp_299, pos_idx);
prnu_299_b_v = pix2volt(prnu_299_b, 299);
dsnu_299_b_v = pix2volt(dsnu_299_b, 299);

% exp 395
[prnu_395_r, dsnu_395_r] = cal_prnu_dsnu(img_395_r, exp_395, pos_idx);
prnu_395_r_v = pix2volt(prnu_395_r, 395);
dsnu_395_r_v = pix2volt(dsnu_395_r, 395);
[prnu_395_g, dsnu_395_g] = cal_prnu_dsnu(img_395_g, exp_395, pos_idx);
prnu_395_g_v = pix2volt(prnu_395_g, 395);
dsnu_395_g_v = pix2volt(dsnu_395_g, 395);
[prnu_395_b, dsnu_395_b] = cal_prnu_dsnu(img_395_b, exp_395, pos_idx);
prnu_395_b_v = pix2volt(prnu_395_b, 395);
dsnu_395_b_v = pix2volt(dsnu_395_b, 395);

% exp 798
[prnu_798_r, dsnu_798_r] = cal_prnu_dsnu(img_798_r, exp_798, pos_idx);
prnu_798_r_v = pix2volt(prnu_798_r, 798);
dsnu_798_r_v = pix2volt(dsnu_798_r, 798);
[prnu_798_g, dsnu_798_g] = cal_prnu_dsnu(img_798_g, exp_798, pos_idx);
prnu_798_g_v = pix2volt(prnu_798_g, 798);
dsnu_798_g_v = pix2volt(dsnu_798_g, 798);
[prnu_798_b, dsnu_798_b] = cal_prnu_dsnu(img_798_b, exp_798, pos_idx);
prnu_798_b_v = pix2volt(prnu_798_b, 798);
dsnu_798_b_v = pix2volt(dsnu_798_b, 798);

%%

% For each ISO speed, for each color channel plot histogram of prnu and
% dsnu values and calculate percentage values

prnu_percentage = zeros(6,3);
dsnu_val = zeros(6,3);

% exp 55
prnu_percentage(1,1) = std(prnu_55_r_v)/mean(prnu_55_r_v)*100;
prnu_percentage(1,2) = std(prnu_55_g_v)/mean(prnu_55_g_v)*100;
prnu_percentage(1,3) = std(prnu_55_b_v)/mean(prnu_55_b_v)*100;

dsnu_val(1,1) = std(dsnu_55_r_v);
dsnu_val(1,2) = std(dsnu_55_g_v);
dsnu_val(1,3) = std(dsnu_55_b_v);
figure
histogram(prnu_55_r_v, 'FaceColor', '#D95319')
hold on
histogram(prnu_55_g_v, 'FaceColor', '#77AC30')
hold on
histogram(prnu_55_b_v, 'FaceColor', '#0072BD')
legend('R', 'G', 'B')
xlabel('PRNU')
title('PRNU Values, ISO Speed 55')
saveas(gcf,'prnu_55.png')

figure
histogram(dsnu_55_r_v, 'FaceColor', '#D95319')
hold on
histogram(dsnu_55_g_v, 'FaceColor', '#77AC30')
hold on
histogram(dsnu_55_b_v, 'FaceColor', '#0072BD')
legend('R', 'G', 'B')
xlabel('DSNU')
title('DSNU Values, ISO Speed 55')
saveas(gcf,'dsnu_55.png')



% exp 99
prnu_percentage(2,1) = std(prnu_99_r_v)/mean(prnu_99_r_v)*100;
prnu_percentage(2,2) = std(prnu_99_g_v)/mean(prnu_99_g_v)*100;
prnu_percentage(2,3) = std(prnu_99_b_v)/mean(prnu_99_b_v)*100;

dsnu_val(2,1) = std(dsnu_99_r_v);
dsnu_val(2,2) = std(dsnu_99_g_v);
dsnu_val(2,3) = std(dsnu_99_b_v);

figure
histogram(prnu_99_r_v, 'FaceColor', '#D95319')
hold on
histogram(prnu_99_g_v, 'FaceColor', '#77AC30')
hold on
histogram(prnu_99_b_v, 'FaceColor', '#0072BD')
legend('R', 'G', 'B')
xlabel('PRNU')
title('PRNU Values, ISO Speed 99')
saveas(gcf,'prnu_99.png')

figure
histogram(dsnu_99_r_v, 'FaceColor', '#D95319')
hold on
histogram(dsnu_99_g_v, 'FaceColor', '#77AC30')
hold on
histogram(dsnu_99_b_v, 'FaceColor', '#0072BD')
legend('R', 'G', 'B')
xlabel('DSNU')
title('DSNU Values, ISO Speed 99')
saveas(gcf,'dsnu_99.png')


% exp 198
prnu_percentage(3,1) = std(prnu_198_r_v)/mean(prnu_198_r_v)*100;
prnu_percentage(3,2) = std(prnu_198_g_v)/mean(prnu_198_g_v)*100;
prnu_percentage(3,3) = std(prnu_198_b_v)/mean(prnu_198_b_v)*100;

dsnu_val(3,1) = std(dsnu_198_r_v);
dsnu_val(3,2) = std(dsnu_198_g_v);
dsnu_val(3,3) = std(dsnu_198_b_v);

figure
histogram(prnu_198_r_v, 'FaceColor', '#D95319')
hold on
histogram(prnu_198_g_v, 'FaceColor', '#77AC30')
hold on
histogram(prnu_198_b_v, 'FaceColor', '#0072BD')
legend('R', 'G', 'B')
xlabel('PRNU')
title('PRNU Values, ISO Speed 198')
saveas(gcf,'prnu_198.png')

figure
histogram(dsnu_198_r_v, 'FaceColor', '#D95319')
hold on
histogram(dsnu_198_g_v, 'FaceColor', '#77AC30')
hold on
histogram(dsnu_198_b_v, 'FaceColor', '#0072BD')
legend('R', 'G', 'B')
xlabel('DSNU')
title('DSNU Values, ISO Speed 198')
saveas(gcf,'dsnu_198.png')


% exp 299
prnu_percentage(4,1) = std(prnu_299_r_v)/mean(prnu_299_r_v)*100;
prnu_percentage(4,2) = std(prnu_299_g_v)/mean(prnu_299_g_v)*100;
prnu_percentage(4,3) = std(prnu_299_b_v)/mean(prnu_299_b_v)*100;

dsnu_val(4,1) = std(dsnu_299_r_v);
dsnu_val(4,2) = std(dsnu_299_g_v);
dsnu_val(4,3) = std(dsnu_299_b_v);

figure
histogram(prnu_299_r_v, 'FaceColor', '#D95319')
hold on
histogram(prnu_299_g_v, 'FaceColor', '#77AC30')
hold on
histogram(prnu_299_b_v, 'FaceColor', '#0072BD')
legend('R', 'G', 'B')
xlabel('PRNU')
title('PRNU Values, ISO Speed 299')
saveas(gcf,'prnu_299.png')

figure
histogram(dsnu_299_r_v, 'FaceColor', '#D95319')
hold on
histogram(dsnu_299_g_v, 'FaceColor', '#77AC30')
hold on
histogram(dsnu_299_b_v, 'FaceColor', '#0072BD')
legend('R', 'G', 'B')
xlabel('DSNU')
title('DSNU Values, ISO Speed 299')
saveas(gcf,'dsnu_299.png')

% exp 395
prnu_percentage(5,1) = std(prnu_395_r_v)/mean(prnu_395_r_v)*100;
prnu_percentage(5,2) = std(prnu_395_g_v)/mean(prnu_395_g_v)*100;
prnu_percentage(5,3) = std(prnu_395_b_v)/mean(prnu_395_b_v)*100;

dsnu_val(5,1) = std(dsnu_395_r_v);
dsnu_val(5,2) = std(dsnu_395_g_v);
dsnu_val(5,3) = std(dsnu_395_b_v);

figure
histogram(prnu_395_r_v, 'FaceColor', '#D95319')
hold on
histogram(prnu_395_g_v, 'FaceColor', '#77AC30')
hold on
histogram(prnu_395_b_v, 'FaceColor', '#0072BD')
legend('R', 'G', 'B')
xlabel('PRNU')
title('PRNU Values, ISO Speed 395')
saveas(gcf,'prnu_395.png')

figure
histogram(dsnu_395_r_v, 'FaceColor', '#D95319')
hold on
histogram(dsnu_395_g_v, 'FaceColor', '#77AC30')
hold on
histogram(dsnu_395_b_v, 'FaceColor', '#0072BD')
legend('R', 'G', 'B')
xlabel('DSNU')
title('DSNU Values, ISO Speed 395')
saveas(gcf,'dsnu_395.png')

% exp 798
prnu_percentage(6,1) = std(prnu_798_r_v)/mean(prnu_798_r_v)*100;
prnu_percentage(6,2) = std(prnu_798_g_v)/mean(prnu_798_g_v)*100;
prnu_percentage(6,3) = std(prnu_798_b_v)/mean(prnu_798_b_v)*100;

dsnu_val(6,1) = std(dsnu_798_r_v);
dsnu_val(6,2) = std(dsnu_798_g_v);
dsnu_val(6,3) = std(dsnu_798_b_v);

figure
histogram(prnu_798_r_v, 'FaceColor', '#D95319')
hold on
histogram(prnu_798_g_v, 'FaceColor', '#77AC30')
hold on
histogram(prnu_798_b_v, 'FaceColor', '#0072BD')
legend('R', 'G', 'B')
xlabel('PRNU')
title('PRNU Values, ISO Speed 798')
saveas(gcf,'prnu_798.png')

figure
histogram(dsnu_798_r_v, 'FaceColor', '#D95319')
hold on
histogram(dsnu_798_g_v, 'FaceColor', '#77AC30')
hold on
histogram(dsnu_798_b_v, 'FaceColor', '#0072BD')
legend('R', 'G', 'B')
xlabel('DSNU')
title('DSNU Values, ISO Speed 798')
saveas(gcf,'dsnu_798.png')

function [info, img, exp] = loadFile(img_path)
    img_files = dir(img_path + '*.dng');
    for i=1:size(img_files)
        [img_load, info_load] = ieDNGRead(append(img_files(i).folder , '/', img_files(i).name));
         img(i, :, :) = img_load; 
         info(i).imgMean = mean2(img_load);
         info(i).imgSTD = std2(img_load);
         info(i).isoSpeed = info_load.ISOSpeedRatings;
         exp(i) = info_load.ExposureTime;     
    end
end


