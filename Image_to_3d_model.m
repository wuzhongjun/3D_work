function [ output_args ] = Image_to_3d_model( img_dir )
%IMAGE_TO_3D_MODEL Summary of this function goes here
%   Detailed explanation goes here
% ����vs����stasm������ͼ���77��x, y���꣬ ���ø�ʽ��exe ����ͼ�� ����ļ�
% �������ó۸�ı���������ȡ��ͼ���77��x, y����
load('reconstruct.mat','all_mat');
img = imread( img_dir);
[im_height im_width] = size( img);
exe_str = ['D:\learning_opengl\stasm4.1.0\vc10\minimal.exe', ' ', img_dir, ' 1.txt'];
system( exe_str);
[new_x new_y] = textread( '1.txt', '%d %d');
new_y = im_height + 1 - new_y;
center_x = new_x(53);
center_y = new_y(53);
new_x = new_x - center_x;
new_y = new_y - center_y;
p_2_12_x = ( abs( new_x(2) + abs( new_x(12)))) / 2;
scale = 63000 / p_2_12_x;
new_xy = [new_x, new_y];
new_xy = all_mat' * new_xy;



end

