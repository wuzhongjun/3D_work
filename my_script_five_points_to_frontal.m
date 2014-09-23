 clear;
global vertex_dtdt;
fp = fopen('eyecoords.txt');
load('../02_save_mat/gem_vertex.mat');
img_dir = dir('D:\learning_opengl\MPIE\*.bmp');
start_num = 1;
end_num = length(img_dir);
% a = 3:7:length(img_dir);
angle_save = zeros(1743,4);
for i = 1:length(img_dir)
    tmp_name = fscanf(fp,'%s',[1 1]);
    tmp_num = fscanf(fp,'%d%d%d%d%d%d%d%d%d%d', [1 10]);
    tmp_num = tmp_num + 1;
    if i >= start_num & i <= end_num
%     if find(a == i)
        fprintf('i = %d\n',i);
        image_name_all = ['D:\learning_opengl\MPIE\' tmp_name '.bmp'];
        five_points_to_frontal( image_name_all, tmp_num );
    end
    
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