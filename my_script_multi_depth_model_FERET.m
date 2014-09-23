clear;
start_num = 1;
end_num = 200;
img_dir2 = dir('D:\learning_opengl\pose_frontal\*.tif');
load('D:\learning_opengl\BaselFace\02_save_mat\gem_vertex.mat');
for i = 1 : length(img_dir2)
    img_str{i} = img_dir2(i).name(1:end - 4);
end
for i = 1 : length(img_dir2)
    img_str_all{i} = img_dir2(i).name;
end
outDir2 = 'D:\learning_opengl\BaselFace\02_FERET_generated_ply2\';
for i = start_num : end_num    
    tmptmp_str{i} = strcat('D:\learning_opengl\BaselFace\02_FERET_save_mat\',img_str{i},'.mat');
    load(tmptmp_str{i},'tmp_ge','tmp_ge_tex','tmp_new_xy');
    z_scale = [1.3 1.2 1.1 1 0.9 0.8 0.7 0.6];
    ge{i} = tmp_ge;
    tmp_ge_z = ge{i}(3,:);
    z1 = tmp_ge_z(16172);
    for cnt = 1
       ge{i}(3,:) = (tmp_ge_z - z1)*z_scale(cnt) + z1;
       tmptmp_str{i} = strcat(img_str{i},'_',num2str(cnt - 2),'.ply');
       plywrite(fullfile(outDir2,tmptmp_str{i}), ge{i}, repmat(tmp_ge_tex,3,1), vertex_dtdt); 
       tmptmp_str{i} = strcat('D:\learning_opengl\BaselFace\02_FERET_save_mat2\',img_str{i},'_',num2str(cnt - 2),'.mat');
       tmp_ge = ge{i};
%        tmp_ge_tex = ge_tex{i};
%        tmp_new_xy = new_xy{i};
       save(tmptmp_str{i},'tmp_ge','tmp_ge_tex','tmp_new_xy');
    end
end