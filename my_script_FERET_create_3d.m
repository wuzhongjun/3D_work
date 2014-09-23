clear;
close all
img_dir = dir('D:\learning_opengl\pose_frontal\*.tif');
start_num = 1;
end_num = 200;
new_num = 200;
for i = 1 : new_num
    img_str{i} = img_dir(i).name(1:end - 4);
end
outDir = 'D:\learning_opengl\BaselFace\02_FERET_generated_ply\';
load('reconstruct.mat','all_mat');
load('D:\learning_opengl\BaselFace\02_save_mat\gem_vertex.mat');
for i = start_num : end_num
    ri_dir{i} = ['D:\learning_opengl\pose_frontal\' img_str{i} '.tif'];
    inp{i} = imread(ri_dir{i}); 
    inp_height{i} = size(inp{i},1);
    inp_width{i} = size(inp{i},2);
    tmp_str = ['D:\learning_opengl\pose_frontal\' img_str{i} '_77loc.txt'];
    [new_x{i} new_y{i} ~] = textread(tmp_str,'%f %f %d');
    new_x{i} = double(new_x{i});
    new_y{i} = double(new_y{i});
    new_y{i} = inp_height{i} + 1 - new_y{i};    
    center_x{i} = new_x{i}(53);
    center_y{i} = new_y{i}(53);
    new_x{i} = new_x{i} - center_x{i};
    new_y{i} = new_y{i} - center_y{i};
    eye_x{i} = (abs(new_x{i}(39)) + abs(new_x{i}(40)))/2;
    eye_y{i} = (abs(new_y{i}(39)) + abs(new_y{i}(40)))/2;
    p_2_12_x{i} = (abs(new_x{i}(2)) + abs(new_x{i}(12)))/2;
    p_2_12_y{i} = (abs(new_y{i}(2)) + abs(new_y{i}(12)))/2;
    scale_x{i} = 63000/p_2_12_x{i};
    scale_y{i} = scale_x{i};
    new_xy{i} = [new_x{i} new_y{i}];
    new_xy{i} = all_mat' * new_xy{i};  
    ge{i} = zeros(size(new_xy{i},1),3);
    ge_tex{i} = zeros(size(new_xy{i},1),1);%gray image
    ge{i}(:,1) = new_xy{i}(:,1)*scale_x{i};
    ge{i}(:,2) = new_xy{i}(:,2)*scale_y{i};
    ge{i}(:,3) = vertex(3,:)';
    for j = 1 : size(ge_tex{i},1)
        ge_tex{i}(j,1) = interp2(inp{i}, new_xy{i}(j,1)  + center_x{i},inp_height{i} + 1 - ( new_xy{i}(j,2)  + center_y{i}));
    end
    ge{i} = ge{i}'; 
    ge_tex{i} = ge_tex{i}';
    tmptmp_str{i} = strcat(img_str{i},'.ply');
    plywrite(fullfile(outDir,tmptmp_str{i}), ge{i}, repmat(ge_tex{i},3,1), vertex_dtdt); 
    tmptmp_str{i} = strcat('D:\learning_opengl\BaselFace\02_FERET_save_mat\',img_str{i},'.mat');
    tmp_ge = ge{i};
    tmp_ge_tex = ge_tex{i};
    tmp_new_xy = new_xy{i};
    save(tmptmp_str{i},'tmp_ge','tmp_ge_tex','tmp_new_xy');
end
