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
start_num = 1;
phi = 0;
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
if mode == 2
    [vertex_nr] = xlsread('..\11_feature_points\fp.xlsx','B1:B77');
    vertex_nr = vertex_nr + 1;%ply num begin from 0 but matlab matrix begin from 1   
%% read the information of shapeMU
     [model msz] = load_model();
     shape = reshape(model.shapeMU,3,size(model.shapeMU,1)/3); %shape 3*n
     tex = reshape(model.texMU,3,size(model.texMU,1)/3); %tex 3*n
%% rotation     
%   rot_phi = 0*pi/180;
%   rot_z = [cos(rot_phi) -sin(rot_phi) 0;
%            sin(rot_phi) cos(rot_phi)  0;
%            0            0             1];
%   rot_y = [cos(rot_phi)   0   sin(rot_phi);
%            0              1   0;
%            -sin(rot_phi)  0   cos(rot_phi)];
%   shape = rot_y*shape; 
  vertex = shape(:,vertex_nr'); % vertex 77*3
end
 %% 3D shapeMU delaunayTriangulation       
%     vertex_x = double(vertex(1,:))'; %vertex_x column vector
%     vertex_y = double(vertex(2,:))'; %vertex_y column vector
%     vertex_z = double(vertex(3,:))'; %vertex_z column vector
%     vertex_tex = tex(:,vertex_nr')'; %vertex_tex 77*3
%     vertex_dt = delaunayTriangulation(vertex_x,vertex_y);
%     vertex_dt1 = vertex_dt(:,1);
%     vertex_dt2 = vertex_dt(:,2);
%     vertex_dt3 = vertex_dt(:,3);
%     vertex_dtdt = [vertex_dt1';vertex_dt2';vertex_dt3']'; %vertex_dtdt n*3
%     save([mat_dir 'sparse_vertex.mat'],'vertex_dtdt','vertex_x','vertex_y','vertex_z');
    load([mat_dir 'sparse_vertex.mat']); %load 77 sparse_vertex triangle index 
    tim = toc;
    fprintf('load sparse_vertex.mat,use time:%3.5f\n',tim);
    tic;
%     h = figure(1);
%     triplot(vertex_dtdt,vertex_x,vertex_y);   
%% read sparse 2D image information,make delaunayTriangulation,4x loopSubdivision 
    %run minimal.exe
    vertex_dtdt_copy = vertex_dtdt;
    new_x{new_num}=[];
    new_y{new_num}=[];
    label{new_num}=[];
    new_xy{new_num}=[];
    new_vertex_dt{new_num}=[];
    new_vertex_dt1{new_num}=[];
    new_vertex_dt2{new_num}=[];
    new_vertex_dt3{new_num}=[];
    new_vertex_dtdt{new_num}=[];
    eye_x{new_num} = [];
    eye_y{new_num} = [];
    p_2_12_x{new_num} = [];
    p_2_12_y{new_num} = [];
    p_7_x{new_num} = [];
    p_7_y{new_num} = [];
    p_15_x{new_num} = [];
    p_15_y{new_num} = [];
    scale_x{new_num} = [];
    scale_y{new_num} = [];
    center_x{new_num} = [];
    center_y{new_num} = [];
    ge{new_num} = [];
    ge_tex{new_num} = [];
    exe_str{new_num} = [];
    inp{new_num} = [];
for i = start_num:new_num
    tic;
    if i ~= 213
     if mode == 1 %minimal.exe
         exe_str{i} = strcat('D:\learning_opengl\stasm4.1.0\vc10\minimal.exe',frontal_face_dir,img_str_all{i},xy_dir,img_str{i},'.txt'); 
%          exe_str = exe_str{1};
         system(exe_str{i});
     end
     if lunkuo == 1 | lunkuo ==2
         tmp_str = ['D:\learning_opengl\BaselFace\02_xy_ordinate\' img_str{i} '.txt'];
         [new_x{i} new_y{i}] = textread(tmp_str,'%d %d');         
     elseif lunkuo == 3 | lunkuo == 4
         %001_01_01_051_07017_01_01_051_07_77loc.txt
         tmp_str = ['D:\learning_opengl\BaselFace\02_xy_ordinate3\001_01_01_051_07' img_str{i} '_77loc.txt'];
         [new_x{i} new_y{i} ~] = textread(tmp_str,'%f %f %d');         
         new_y{i} = 480 + 1 - new_y{i};
     end
         new_x{i} = double(new_x{i});
         new_y{i} = double(new_y{i});
         center_x{i} = new_x{i}(53);
         center_y{i} = new_y{i}(53);
         new_x{i} = new_x{i} - center_x{i};
         new_y{i} = new_y{i} - center_y{i};
         eye_x{i} = (abs(new_x{i}(39)) + abs(new_x{i}(40)))/2;
         eye_y{i} = (abs(new_y{i}(39)) + abs(new_y{i}(40)))/2;
         p_2_12_x{i} = (abs(new_x{i}(2)) + abs(new_x{i}(12)))/2;
         p_2_12_y{i} = (abs(new_y{i}(2)) + abs(new_y{i}(12)))/2;
         p_7_x{i} = abs(new_x{i}(7));
         p_7_y{i} = abs(new_y{i}(7));
         p_15_x{i} = abs(new_x{i}(15));
         p_15_y{i} = abs(new_y{i}(15));
         new_xy{i} = [new_x{i} new_y{i}];
%         h = figure(1);
%         triplot(vertex_dtdt,new_x{i},new_y{i});
    vertex_dtdt = vertex_dtdt_copy;
    if mode == 1
        for j = 1:4 % 4x loopSubdivision
           [new_xy{i},vertex_dtdt] = loopSubdivision(new_xy{i}',vertex_dtdt'); 
           new_xy{i} = new_xy{i}';
           vertex_dtdt = vertex_dtdt';
        end
    %     new_xy{i} = new_xy{i}';
    %     vertex_dtdt = vertex_dtdt';
        tim = toc;
        fprintf('number:%d,2d 4x loop subdivision finished,use time:%3.5f\n',i,tim);
        tic;
    end
    end
end;
%% write to ply model    
%       plywrite(fullfile(outDir,['shapeMU_shrink' '.ply']), vertex, vertex_tex, vertex_dtdt );
%       tex(:,vertex_nr') = repmat([255; 0; 0],1,size(vertex_nr,1)); % draw feature point in red
%       plywrite(fullfile(outDir,['shapeMU_feature_colored' '.ply']), shape, tex, model.tl );
%% Render parameters
      rp     = defrp;%set some default parameters
      rp.phi = 0;
      rp.dir_light.dir = [0;1;1];
      rp.dir_light.intens = 0.6*ones(3,1);
      rp.sbufsize=2000;
%% 3D loop subdivision,save data
if mode == 2
    vertex = vertex';
    h = figure(10);
       subplot(1,2,1); triplot(vertex_dtdt,vertex(:,1),vertex(:,2));
       subplot(1,2,2); trimesh(vertex_dtdt,vertex(:,1),vertex(:,2),vertex(:,3));
     for j = 1:4
       [vertex,vertex_dtdt] = loopSubdivision(vertex',vertex_dtdt');
       vertex = vertex';
       vertex_dtdt = vertex_dtdt';
       h = figure(2+j);
       subplot(1,2,1); triplot(vertex_dtdt,vertex(:,1),vertex(:,2));
       subplot(1,2,2); trimesh(vertex_dtdt,vertex(:,1),vertex(:,2),vertex(:,3));
     end 
end
%  save('D:\learning_opengl\BaselFace\02_save_mat\vertex.mat','vertex','vertex_dtdt');
%  load('D:\learning_opengl\BaselFace\02_save_mat\vertex.mat');    
%% build GEM  
%     aja_dis = 1000;
%     tex_vertex = zeros(size(vertex,1),3);
%     vertex_xy = vertex(:,1:2);
%      for i = 1:size(vertex_xy,1)
%         aja_dis = 1000;
%         current_x = vertex_xy(i,1);
%         current_y = vertex_xy(i,2);
%         current_z = vertex(i,3);
%         while(1)
%             fanwei = find(shape(1,:) < (current_x + aja_dis) & shape(1,:) > (current_x - aja_dis) ...
%                      &shape(2,:) < (current_y + aja_dis) & shape(2,:) > (current_y - aja_dis));
%             if size(fanwei,2)>3
%                 break;
%             else
%                 aja_dis = aja_dis + 500;
%             end
%         end
%         fanwei_z = shape(3,fanwei);
%         [max_z,tmp_index] = max(fanwei_z);
%         max_z_index = fanwei(tmp_index);
%         vertex(i,3) = max_z;
%         tex_vertex(i,:) = tex(:,max_z_index)'; 
%       end
    
%        vertex = vertex';
%        tex_vertex = tex_vertex';   
%        save('D:\learning_opengl\BaselFace\02_save_mat\gem_vertex.mat','vertex','tex_vertex','vertex_dtdt');
%% read gem data,read input image
    load('D:\learning_opengl\BaselFace\02_save_mat\gem_vertex.mat');
if  mode == 0
     for i = 1:new_num
         if i ~= 213
             if lunkuo == 1
                tmptmp_str{i} = strcat('D:\learning_opengl\BaselFace\02_save_mat\',img_str{i},'.mat');
             elseif lunkuo == 2
                tmptmp_str{i} = strcat('D:\learning_opengl\BaselFace\02_save_mat2\',img_str{i},'.mat');
             elseif lunkuo == 3 | lunkuo == 4
                tmptmp_str{i} = strcat('D:\learning_opengl\BaselFace\02_save_mat3\',img_str{i},'.mat'); 
             end
             load(tmptmp_str{i});
             ge{i} = tmp_ge;
             ge_tex{i} = tmp_ge_tex;
             new_xy{i} = tmp_new_xy;
         end
     end
end
 for i = start_num:new_num
    if i ~= 213
    ri_dir{i} = strcat('D:\learning_opengl\BaselFace\02_frontal_face\',img_str_all{i});
%     img_dir = img_dir{i};
%     i = 1;
    inp{i} = imread(ri_dir{i});
    inp_height{i} = size(inp{i},1);
    inp_width{i} = size(inp{i},2);
    tim = toc;
    fprintf('number:%d,read gem data and input image,use time:%3.5f\n',i,tim);
    tic;

%%  generate 3D data for 2D input image 
if mode == 1
    ge{i} = zeros(size(new_xy{i},1),3);
    ge_tex{i} = zeros(size(new_xy{i},1),1);%gray image
%     ge_tex{i} = zeros(size(new_xy{i},1),3);%rgb image
%     scale_x{i} = 39000/eye_x{i};
%     scale_y{i} = 34000/eye_y{i};
%     scale_x{i} = 31200/eye_x{i};
    scale_x{i} = 63000/p_2_12_x{i};
%     scale_y{i} = (70000/p_7_y{i} + 100000/p_15_y{i})/2;
    scale_y{i} = scale_x{i};
    ge{i}(:,1) = new_xy{i}(:,1)*scale_x{i};
    ge{i}(:,2) = new_xy{i}(:,2)*scale_y{i};
    ge{i}(:,3) = vertex(3,:)';
    for j = 1:size(new_xy{i},1)
        ge_tex{i}(j,1) = interp2(inp{i}, new_xy{i}(j,1)  + center_x{i},inp_height{i} + 1 - ( new_xy{i}(j,2)  + center_y{i}));
%         ge_tex{i}(j,1) = inp{i}( inp_height{i} + 1 - (int32( new_xy{i}(j,2) ) + center_y{i}) , int32( new_xy{i}(j,1) ) + center_x{i} ); 

%         ge_tex{i}(j,2) = inp{i}( inp_height{i} + 1 - (int32( new_xy{i}(j,2) ) + center_y{i}) , int32( new_xy{i}(j,1) ) + center_x{i} , 2);
%         ge_tex{i}(j,3) = inp{i}( inp_height{i} + 1 - (int32( new_xy{i}(j,2) ) + center_y{i}) , int32( new_xy{i}(j,1) ) + center_x{i} , 3);
    end  
    ge{i} = ge{i}'; 
    ge_tex{i} = ge_tex{i}';
end
    rot_phi = phi*pi/180;
      rot_z = [cos(rot_phi) -sin(rot_phi) 0;
               sin(rot_phi) cos(rot_phi)  0;
               0            0             1];
      rot_y = [cos(rot_phi)   0   sin(rot_phi);
               0              1   0;
               -sin(rot_phi)  0   cos(rot_phi)];
      ge{i} = rot_y*ge{i}; 
%%  draw feature point
    %     for j = 1:size(new_x{i},1)
%         inp{i}( inp_height{i} + 1 - new_y{i}(j) - center_y{i} , new_x{i}(j) + center_x{i} ,1) = 255;
%         inp{i}( inp_height{i} + 1 - new_y{i}(j) - center_y{i} , new_x{i}(j) + center_x{i} ,2) = 255;
%         inp{i}( inp_height{i} + 1 - new_y{i}(j) - center_y{i} , new_x{i}(j) + center_x{i} ,3) = 255;
%     end

%     h = figure(3);
%     imshow(inp{i});
%     hold on;
%     plot(new_x{i} + center_x{i},inp_height{i} + 1 - new_y{i} - center_y{i},'+w');
%     hold on;
%     triplot(vertex_dtdt_copy,new_x{i} + center_x{i},inp_height{i} + 1 - new_y{i} - center_y{i});
%     hold off;
% %
% 
%     h = figure(2);
%     my_display_face_2d(ge{i},ge_tex{i},vertex_dtdt,rp);
%% write jpg,write ply,write mat
    
   img_write_dir{i} = strcat('D:\learning_opengl\BaselFace\02_projected_jpg\',img_str{i},'_f.jpg');
%    saveas(h,img_write_dir);
if mode == 0
   %write ply 
   fprintf('write ply and mat\n');
   tmptmp_str{i} = strcat(img_str{i},'.ply');
%    rgb image
%    plywrite(fullfile(outDir,tmptmp_str{i}), ge{i}, ge_tex{i}, vertex_dtdt);
   if lunkuo == 1
       plywrite(fullfile(outDir,tmptmp_str{i}), ge{i}, repmat(ge_tex{i},3,1), vertex_dtdt); 
   elseif lunkuo == 2
       plywrite(fullfile(outDir2,tmptmp_str{i}), ge{i}, repmat(ge_tex{i},3,1), vertex_dtdt); 
   elseif lunkuo == 3
       plywrite(fullfile(outDir3,tmptmp_str{i}), ge{i}, repmat(ge_tex{i},3,1), vertex_dtdt); 
   end
   %write mat
   if lunkuo == 1
       tmptmp_str{i} = strcat('D:\learning_opengl\BaselFace\02_save_mat\',img_str{i},'.mat');
   elseif lunkuo == 2
       tmptmp_str{i} = strcat('D:\learning_opengl\BaselFace\02_save_mat2\',img_str{i},'.mat');
   elseif lunkuo == 3
       tmptmp_str{i} = strcat('D:\learning_opengl\BaselFace\02_save_mat3\',img_str{i},'.mat');
   end
   if lunkuo <= 3
       tmp_ge = ge{i};
       tmp_ge_tex = ge_tex{i};
       tmp_new_xy = new_xy{i};
       save(tmptmp_str{i},'tmp_ge','tmp_ge_tex','tmp_new_xy');
   end
   z_scale = [1.1 1 0.9 0.8 0.7 0.6];
   tmp_ge_z = ge{i}(3,:);
   z1 = tmp_ge_z(16172);
   if lunkuo == 4
       for cnt = 1:6
           ge{i}(3,:) = (tmp_ge_z - z1)*z_scale(cnt) + z1;
           tmptmp_str{i} = strcat(img_str{i},'_',num2str(cnt),'.ply');
           plywrite(fullfile(outDir4,tmptmp_str{i}), ge{i}, repmat(ge_tex{i},3,1), vertex_dtdt); 
           tmptmp_str{i} = strcat('D:\learning_opengl\BaselFace\02_save_mat4\',img_str{i},'_',num2str(cnt),'.mat');
           tmp_ge = ge{i};
           tmp_ge_tex = ge_tex{i};
           tmp_new_xy = new_xy{i};
           save(tmptmp_str{i},'tmp_ge','tmp_ge_tex','tmp_new_xy');
       end
   end
end


   %write jpg
%       pause;
% if mode == 1
%    F = getframe(gcf);
%    imwrite(F.cdata,img_write_dir{i});
% end
   tim = toc;
   fprintf('write jpg:%d,write ply,write mat finished,use time:%3.5f\n',i,tim);
%    if i ~= new_num
%    delete(h);
%    end
   %%  draw 2D input image feature point in black
   
%      tmptmp_str{i} = strcat('D:\learning_opengl\BaselFace\02_feature_face\',img_str{i},'_feature_points.jpg');
%      imwrite(inp{i},tmptmp_str{i});
    end
end   
%    plywrite(fullfile(outDir,['shapeMU_regenerated' '.ply']), vertex, tex_vertex, vertex_dtdt );
%%  some useless code  
%   my_display_face_2d(vertex,tex_vertex,vertex_dtdt,rp);%use 02scan's shape,tex;MM's tl,rp parameters
%     fanwei = find(vertex_xy(:,1)<-60000 & vertex_xy(:,1)>-65000 & vertex_xy(:,2) <45000 & vertex_xy(:,2) > 40000);
   
%   h = figure(7);
%   vertex = vertex(1:77,:)';
%   vertex_x = double(vertex(1,:))';
%     vertex_y = double(vertex(2,:))';
%     vertex_z = double(vertex(3,:))';
%     vertex_tex = tex(:,vertex_nr')';
%     vertex_dt = delaunayTriangulation(vertex_x,vertex_y);
%     vertex_dt1 = vertex_dt(:,1);
%     vertex_dt2 = vertex_dt(:,2);
%     vertex_dt3 = vertex_dt(:,3);
%     vertex_dtdt = [vertex_dt1';vertex_dt2';vertex_dt3']';
%     subplot(1,2,1); triplot(vertex_dtdt,vertex_x,vertex_y);
%   subplot(1,2,2); trimesh(vertex_dtdt,vertex_x,vertex_y,vertex_z);
% 
%   h = figure(8);
%   plot3(shape(1,:), shape(2,:), shape(3,:), '.b');
%  im_data = imread('00001fa010_930831.bmp');
%  im_data = imresize(im_data,10,'bilinear');
%  imwrite(im_data,'new.bmp','bmp');
% display_face(shape,tex,model.tl,rp);%use 02scan's shape,tex;MM's tl,rp parameters

