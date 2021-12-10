function [prnu, dsnu] = cal_prnu_dsnu(img, exp, pos_idx)
% img: raw image matrix for one color channel (3D matrix for all exposure
% times and timestamps)
% pos_idx: vector of size of image patch 

num_exp = 5;
m = pos_idx(2) - pos_idx(1);
n = pos_idx(4) - pos_idx(3);

k = size(img,1);

% calculate prnu and dsnu for each pixel in block
% loop over each pixel in block 
prnu = zeros(1, m*n);
dsnu = zeros(1, m*n);
for i=pos_idx(1):pos_idx(2)
    for j=pos_idx(3):pos_idx(4)
        avg_pix_val = zeros(2,num_exp);
        pix_col = img(:, i, j);
        exp_sort = cat(2, exp', double(pix_col));
        exp_sorted = sortrows(exp_sort);
        for x=1:num_exp
            avg_pix_val(1,x) = exp_sorted((x-1)*k/num_exp+1,1);
            avg_pix_val(2,x) = mean(exp_sorted(((x-1)*k/num_exp)+1:x*k/num_exp, 2));
        end

        c = polyfit(avg_pix_val(1,:), avg_pix_val(2,:),1);
        prnu((i-pos_idx(1))*m + j-pos_idx(3)+1) = c(1);
        dsnu((i-pos_idx(1))*m + j-pos_idx(3)+1) = c(2);
    end
end



