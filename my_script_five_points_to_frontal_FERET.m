 clear;
global vertex_dtdt;
fp = fopen('eyecoords.txt');
load('../02_save_mat/gem_vertex.mat');
img_dir = dir('D:\learning_opengl\pose\*.tif');
start_num = 1;
end_num = length(img_dir);
% a = 1:7:length(img_dir);
angle_save = zeros(1800,4);
% for i = 100: 1 :length(img_dir)
for i = 1 : 9 : 1800
    fprintf( ' i = %d\n', i);
    in_image_name = img_dir(i).name;
    [five_x, five_y, ~] = textread(['D:\learning_opengl\pose\' in_image_name(1:end - 4) '_5loc.txt'],'%f %f %f');
    tmp_num = [five_x five_y]';
    tmp_num = tmp_num(:)';
%     tmp_num = tmp_num - 1;
    five_points_to_frontal_FERET( ['D:\learning_opengl\pose\' in_image_name], tmp_num );
    
%     fprintf('%s\n',['D:\learning_opengl\MPIE\' tmp_name '.bmp']);
%     fprintf('%d %d %d %d %d %d %d %d %d %d\n',tmp_num);
%      pause;
end
fclose(fp);
% clear; 
% global vertex_dtdt;
% image_name_all = 'D:\learning_opengl\MPIE\001_01_01_041_07.bmp';
% load('../02_save_mat/gem_vertex.mat');
% five_points_ to_frontal( image_name_all, [347 212 405 208 404 244 368 285 412 282] );