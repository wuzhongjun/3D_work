clear;
global vertex_dtdt;
load('../02_save_mat/gem_vertex.mat');
img_dir = dir('D:\learning_opengl\lfw_5pts\*.bmp');
start_num = 1;
end_num = length(img_dir);
% a = 1:7:length(img_dir);
% for i = 100: 1 :length(img_dir)
fid = fopen( 'record.txt','w+');
total = zeros(1, 10);
for i = 1 : length(img_dir)
    fprintf( ' i = %d\n', i);
    in_image_name = img_dir(i).name;
    [five_x, five_y, ~] = textread(['D:\learning_opengl\lfw_5pts\' in_image_name(1:end - 4) '_5loc.txt'],'%f %f %f');
    tmp_num = [five_x five_y]';
    tmp_num = tmp_num(:)';
%     tmp_num = tmp_num - 1;
    angle = five_points_to_frontal_LFW( ['D:\learning_opengl\lfw_5pts\' in_image_name], tmp_num, fid );
%     fprintf(fid,'\nname:%s p_angle_y:%f p_angle_x:%f p_angle_z:%f\n',in_image_name,angle(1),angle(2),angle(3));
%     fprintf('%s\n',['D:\learning_opengl\MPIE\' tmp_name '.bmp']);
%     fprintf('%d %d %d %d %d %d %d %d %d %d\n',tmp_num);
%      total = total + tmp_num;
%      pause;
   
end
% total = total / length(img_dir);
fclose( fid);
% clear; 
% global vertex_dtdt;
% image_name_all = 'D:\learning_opengl\MPIE\001_01_01_041_07.bmp';
% load('../02_save_mat/gem_vertex.mat');
% five_points_ to_frontal( image_name_all, [347 212 405 208 404 244 368 285 412 282] );