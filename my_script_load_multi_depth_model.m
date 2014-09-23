%% some comment
%    triplot(triangle_list n*3 , vector x , vector y )
%    trimesh(triangle_list n*3 , vector x , vector y , vector z)
%    plywrite(filename , shape 3*n , tex 3*n , triangle list n*3)  
%    my_display_face_2d(shape 3*n , tex 3*n , triangle list n*3 , rp);
%%
clear
close all
tic;
mode = 0; % mode = 1 for write mat , mode = 0 for read
new_num = 250;
start_num = 22;
phi = 45;
lunkuo = 4;
 for i = 1 : new_num
     if i ~= 213
     img_str{i} = strcat(num2str(i,'%03d'),'_01_01_051_07');%to add more frontal face,change this cell
     end
 end
 for i = 1 : new_num
     if i ~= 213
     img_str_all{i} = strcat(num2str(i,'%03d'),'_01_01_051_07.bmp');%to add more frontal face,change this cell
     end
 end
%      img_str = {'frontal_face','testface'};
%      img_str_all = {'frontal_face.jpg','testface.jpg'};
outDir = 'D:\learning_opengl\BaselFace\02_generated_ply\';
outDir2 = 'D:\learning_opengl\BaselFace\02_generated_ply2\';
outDir3 = 'D:\learning_opengl\BaselFace\02_generated_ply3\';
outDir4 = 'D:\learning_opengl\BaselFace\02_generated_ply4\';
frontal_face_dir = ' D:\learning_opengl\BaselFace\02_frontal_face\';
mat_dir = 'D:\learning_opengl\BaselFace\02_save_mat\';
xy_dir = ' D:\learning_opengl\BaselFace\02_xy_ordinate\';
projected_dir = ' D:\learning_opengl\BaselFace\02_projected_jpg\';
% [vertex_nr x y z xx yy vertex_name] = textread('..\11_feature_points\MPEG4_FDP_face05.fp','%d %f %f %f %d %d %s');

%% read gem data,read input image
    load('D:\learning_opengl\BaselFace\02_save_mat\gem_vertex.mat');
    rp     = defrp;
if  mode == 0
     for i = start_num:new_num
         if i ~= 213
             for cnt = 1:6
                 tmptmp_str{i} = strcat('D:\learning_opengl\BaselFace\02_save_mat4\',img_str{i},'_',num2str(cnt),'.mat');              
                 load(tmptmp_str{i});
                 ge{cnt} = tmp_ge;
                 ge_tex{cnt} = tmp_ge_tex;
                 new_xy{cnt} = tmp_new_xy;
                 rot_phi = phi*pi/180;
                  rot_z = [cos(rot_phi) -sin(rot_phi) 0;
                           sin(rot_phi) cos(rot_phi)  0;
                           0            0             1];
                  rot_y = [cos(rot_phi)   0   sin(rot_phi);
                           0              1   0;
                           -sin(rot_phi)  0   cos(rot_phi)];
                  ge{cnt} = rot_y*ge{cnt}; 
                  h = figure(cnt);
                  my_display_face_2d(ge{cnt},ge_tex{cnt},vertex_dtdt,rp);
                  pause;
             end            
         end
         pause;
     end
end



  
