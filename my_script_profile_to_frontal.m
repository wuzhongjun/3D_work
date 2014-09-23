%% some comment
%    triplot(triangle_list n*3 , vector x , vector y )
%    trimesh(triangle_list n*3 , vector x , vector y , vector z)
%    plywrite(filename , shape 3*n , tex 3*n , triangle list n*3)  
%    my_display_face_2d(shape 3*n , tex 3*n , triangle list n*3 , rp);
%%
clear
close all
tic;
global kkk;
kkk = 1;
mode = 0; % mode = 0 for auto landmark ,mode = 1 for manul landmark
% img_str{1} the profile
img_str = {'002_test_l_15','002_test_frontal'};
img_str_all = {'002_test_l_15.png','002_test_frontal.png'};
outDir = 'D:\learning_opengl\BaselFace\02_generated_ply\';
frontal_face_dir = ' D:\learning_opengl\BaselFace\02_frontal_face\';
mat_dir = 'D:\learning_opengl\BaselFace\02_save_mat\';
xy_dir = ' D:\learning_opengl\BaselFace\02_xy_ordinate\';
projected_dir = ' D:\learning_opengl\BaselFace\02_projected_jpg\';
pa_dir = 'D:\learning_opengl\BaselFace\02_pieceaffine\';
pa_dir2 = ' D:\learning_opengl\BaselFace\02_pieceaffine\';
[vertex_nr] = xlsread('..\11_feature_points\fp.xlsx','B1:B77');
vertex_nr = vertex_nr + 1;%ply num begin from 0 but matlab matrix begin from 1

%% rotation     
  rot_phi = 0*pi/180;
  rot_z = [cos(rot_phi) -sin(rot_phi) 0;
           sin(rot_phi) cos(rot_phi)  0;
           0            0             1];
  rot_y = [cos(rot_phi)   0   sin(rot_phi);
           0              1   0;
           -sin(rot_phi)  0   cos(rot_phi)];
%%  
%if mode == 1
 %   xy_2d = xlsread(['..\11_feature_points\' img_str{1} '.xlsx'],'A1:B77');
 %   x_2d = xy_2d(:,1);
 %   y_2d = xy_2d(:,2);
%else
    i = 1;
if mode == 0
    exe_str{i} = strcat('D:\learning_opengl\stasm4.1.0\vc10\minimal.exe',pa_dir2,img_str_all{i},xy_dir,img_str{i},'.txt'); 
    system(exe_str{i});            
end    
    tmp_str = ['D:\learning_opengl\BaselFace\02_xy_ordinate\' img_str{1} '.txt'];
    [x_2d y_2d] = textread(tmp_str,'%d %d');
    xy_2d = [x_2d y_2d]; 
i = 2;
exe_str{i} = strcat('D:\learning_opengl\stasm4.1.0\vc10\minimal.exe',pa_dir2,img_str_all{i},xy_dir,img_str{i},'.txt'); 
system(exe_str{i});            
tmp_str = ['D:\learning_opengl\BaselFace\02_xy_ordinate\' img_str{2} '.txt'];
[x_2d_re y_2d_re] = textread(tmp_str,'%d %d');
xy_2d_re = [x_2d_re y_2d_re];         
xy_2d_ds = xy_2d(17:size(xy_2d,1),:);
eye_dist_2d = abs(x_2d(39) - x_2d(40));
x_2d_ds = xy_2d_ds(:,1);
y_2d_ds = xy_2d_ds(:,2);

xy_2d_ds = reshape(xy_2d_ds',size(xy_2d_ds,1)*size(xy_2d_ds,2),1);
load('..\02_save_mat\sparse_vertex.mat');
xyz_3d = [vertex_x vertex_y vertex_z];
eye_dist_3d = abs(vertex_x(39) - vertex_x(40));
scale = eye_dist_3d / eye_dist_2d;
xyz_3d = xyz_3d / scale;
xyz_3d_ds = xyz_3d(17:size(xyz_3d,1),:);
vertex_x = xyz_3d(:,1);
vertex_y = xyz_3d(:,2);
vertex_z = xyz_3d(:,3);
%%
figure(kkk);%    figure 1
kkk = kkk + 1;
% the gem
subplot(1,2,1);
vertex_dt = delaunayTriangulation(vertex_x,vertex_y);
vertex_dtdt = vertex_dt(:,:);
triplot(vertex_dtdt,vertex_x,vertex_y);
% hold on
% xyz_3d = xyz_3d*rot_y;
% subplot(1,2,2);
% triplot(vertex_dtdt,xyz_3d(:,1),xyz_3d(:,2));
% figure(2);
% subplot(1,2,1);
% triplot(vertex_dtdt,xy_2d(:,1),-xy_2d(:,2));
xy_2d = reshape(xy_2d',size(xy_2d,1)*size(xy_2d,2),1);
%%
re_xyz_3d = zeros(size(xy_2d,1),8);
re_xyz_3d(1:2:size(re_xyz_3d,1),:) = [xyz_3d repmat([1 0 0 0 0],size(xyz_3d,1),1)];
re_xyz_3d(2:2:size(re_xyz_3d,1),:) = [repmat([0 0 0 0],size(xyz_3d,1),1) xyz_3d repmat([1],size(xyz_3d,1),1)];

re_xyz_3d_ds = zeros(size(xy_2d_ds,1),8);
re_xyz_3d_ds(1:2:size(re_xyz_3d_ds,1),:) = [xyz_3d_ds repmat([1 0 0 0 0],size(xyz_3d_ds,1),1)];
re_xyz_3d_ds(2:2:size(re_xyz_3d_ds,1),:) = [repmat([0 0 0 0],size(xyz_3d_ds,1),1) xyz_3d_ds repmat([1],size(xyz_3d_ds,1),1)];
% P = pinv(re_xyz_3d) * xy_2d;
% r = xy_2d - re_xyz_3d * P;
%%
% re_xyz_3d_ds = zeros(size(xy_2d_ds,1),8);
% re_xyz_3d_ds(1:2:size(re_xyz_3d_ds,1),:) = [xyz_3d_ds repmat([1 0 0 0 0],size(xyz_3d_ds,1),1)];
% re_xyz_3d_ds(2:2:size(re_xyz_3d_ds,1),:) = [repmat([0 0 0 0],size(xyz_3d_ds,1),1) xyz_3d_ds repmat([1],size(xyz_3d_ds,1),1)];
P = pinv(re_xyz_3d) * xy_2d;
r = xy_2d - re_xyz_3d * P;
P_ds = pinv(re_xyz_3d_ds) * xy_2d_ds;
r_ds = xy_2d - re_xyz_3d * P_ds;
%  delta_3d = r * pinv(P);
%  predict_3d = re_xyz_3d + delta_3d;
%  rr = xy_2d - predict_3d * P;
P_1256 = zeros(2,2);
P_1256(1,1) = P(1);
P_1256(2,1) = P(2);
P_1256(1,2) = P(5);
P_1256(2,2) = P(6);
P_ds_1256 = zeros(2,2);
P_ds_1256(1,1) = P_ds(1);
P_ds_1256(2,1) = P_ds(2);
P_ds_1256(1,2) = P_ds(5);
P_ds_1256(2,2) = P_ds(6);
tmp_r(:,1) = r(1:2:end);
tmp_r(:,2) = r(2:2:end);
tmp_r_ds(:,1) = r_ds(1:2:end);
tmp_r_ds(:,2) = r_ds(2:2:end);
r = tmp_r;
r_ds = tmp_r_ds;
% r = reshape(r',size(r',2)/2,2);
delta_xy = r * inv(P_1256);
delta_xy_ds = r_ds * inv(P_ds_1256);
vertex_x = vertex_x + delta_xy(:,1);
vertex_y = vertex_y + delta_xy(:,2);
% add the residence
subplot(1,2,2);
triplot(vertex_dtdt,vertex_x,vertex_y,'r');
figure(kkk); % figure 2
% the real frontal figure
kkk = kkk + 1;
triplot(vertex_dtdt,x_2d_re,y_2d_re);
ans_xy =[ vertex_x vertex_y];
P_angle_z = atan(-P(5)/P(6))*180/pi;
P_angle_x = asin(-P(7))*180/pi;     
angle1 = asin(-P(3)/P(6)*cos(P_angle_z*pi/180))*180/pi;
%     angle_x = 
%     angle1 = asin(-P(3)/P(6))*180/pi;
%     angle2 = 180 - acos(P(1)/P(6))*180/pi;
%     P_angle = angle1/2 + sign(angle1)* angle2 /2
if isreal(angle1) 
    P_angle = angle1;
end
piece_affine_transformation;