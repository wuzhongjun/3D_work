function [ part_dist ] = cos_dist( pa_img_all  )
%COS_DIST Summary of this function goes here
%   Detailed explanation goes here
    len = size( pa_img_all, 1) - 1;
    part_dist = zeros( len, 1);
    val = sqrt( sum( pa_img_all( 1, :) .* pa_img_all( 1, :)));
    for i = 1 : len
        part_dist( i) = 1 - sum( pa_img_all( 1, :) .* pa_img_all( i + 1, :)) / sqrt( sum( pa_img_all( i + 1, :) .* pa_img_all( i + 1, :))) / val; 
    end
end

