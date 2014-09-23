clear;
outDir = 'D:\learning_opengl\BaselFace\02_generated_ply\';
load('D:\learning_opengl\BaselFace\02_save_mat\gem_vertex_sym.mat');

% a = vertex(1,1);
% b = vertex(2,1);
% index = find(vertex(1,:) == -a & vertex(2,:) == b);
cnt = 0;
cnt_r = 0;
cnt_l = 0;
cnt_m = 0;
for i = 1 : size(vertex,2)
    if vertex(1,i) > 0
        a = vertex(1,i);
        b = vertex(2,i);
        aja = 1;
        index = find(vertex(1,:) > (-a - aja) & vertex(1,:) < (-a + aja) & vertex(2,:) < (b + aja) & vertex(2,:) > (b - aja));
        while isempty(index)
            aja = aja + 10;
            index = find(vertex(1,:) > (-a - aja) & vertex(1,:) < (-a + aja) & vertex(2,:) < (b + aja) & vertex(2,:) > (b - aja));
        end            
        if ~isempty(index)
%             tmp_z = 0;
%             if length(index) ~= 1               
%                 fprintf( 'i = %d ,len = %d\n', i, length(index));
%             end
%             for j = 1:length(index)   
%                 if length(index) ~= 1               
%                     fprintf( 'j = %d\n', index(j));
%                 end
%                 tmp_z = tmp_z + vertex(3,index(j));               
%             end            
%             vertex(3,i) = tmp_z / length(index);
            vertex(1,i) = -vertex(1,index(1));
            vertex(2:3,i) = vertex(2:3,index(1));
            tex_vertex(:,i) = tex_vertex(:,index(1)); 
            cnt = cnt + 1;
        end
        cnt_r = cnt_r + 1;
    elseif vertex(1,i) < 0
        cnt_l = cnt_l + 1;
    else
        cnt_m = cnt_m + 1;
    end
end
% tex_vertex(1:3,[4500,7644,12500,5159,3863]) = repmat([255; 0; 0],[1 5]);
plywrite(fullfile(outDir,['shapeMU_regenerated_sym' '.ply']), vertex, tex_vertex, vertex_dtdt );
save('D:\learning_opengl\BaselFace\02_save_mat\gem_vertex_sym.mat','vertex','tex_vertex','vertex_dtdt');

% load('reconstruct.mat','all_mat');
% [vertex_nr] = xlsread('..\11_feature_points\fp.xlsx','B1:B77');
% vertex_nr = vertex_nr + 1;%ply num begin from 0 but matlab matrix begin from 1
% [model msz] = load_model();
% shape = reshape(model.shapeMU,3,size(model.shapeMU,1)/3); %shape 3*n
% tex = reshape(model.texMU,3,size(model.texMU,1)/3); %tex 3*n
% vertex = shape(:,vertex_nr'); % vertex 77*3
% vertex(1,39) = (vertex(1,39)-vertex(1,40))/2;
% vertex(2,39) = (vertex(2,39)+vertex(2,40))/2;
% vertex(1,[13:-1:8 14 23:28 29 40 41:48 49 55 56 54 64:66 67 72 73 74]) = -vertex(1,[1:6 16 22 17 18 19 20 21 30 39 31:38 51 59 58 52 62 61 60 69 70 76 77]);
% vertex(2,[13:-1:8 14 23:28 29 40 41:48 49 55 56 54 64:66 67 72 73 74]) = vertex(2,[1:6 16 22 17 18 19 20 21 30 39 31:38 51 59 58 52 62 61 60 69 70 76 77]);
% vertex(1,[7, 15, 50, 53, 57, 63, 68, 71, 75]) = 0;
% vertex_x = double(vertex(1,:))'; %vertex_x column vector
% vertex_y = double(vertex(2,:))'; %vertex_y column vector
% vertex_dt = delaunayTriangulation(vertex_x,vertex_y);
% vertex_dt = vertex_dt(:,:);
% triplot(vertex_dt,vertex_x,vertex_y); 
% new_xy = [vertex_x vertex_y];
% new_xy = all_mat' * new_xy;
% vertex = zeros( size(new_xy,1),3);
% vertex(:, 1:2) = new_xy;
% 
% %% build GEM  
% aja_dis = 1000;
% tex_vertex = zeros(size(vertex,1),3);
% vertex_xy = vertex(:,1:2);
% for i = 1:size(vertex_xy,1)
%     aja_dis = 1000;
%     current_x = vertex_xy(i,1);
%     current_y = vertex_xy(i,2);
%     while(1)
%         fanwei = find(shape(1,:) < (current_x + aja_dis) & shape(1,:) > (current_x - aja_dis) ...
%                  &shape(2,:) < (current_y + aja_dis) & shape(2,:) > (current_y - aja_dis));
%         if size(fanwei,2)>3
%             break;
%         else
%             aja_dis = aja_dis + 500;
%         end
%     end
%     fanwei_z = shape(3,fanwei);
%     [max_z,tmp_index] = max(fanwei_z);
%     max_z_index = fanwei(tmp_index);
%     vertex(i,3) = max_z;
%     tex_vertex(i,:) = tex(:,max_z_index)'; 
% end
% 
% vertex = vertex';
% tex_vertex = tex_vertex';   
% save('D:\learning_opengl\BaselFace\02_save_mat\gem_vertex_new.mat','vertex','tex_vertex','vertex_dtdt');
% plywrite(fullfile(outDir,['shapeMU_regenerated_new' '.ply']), vertex, tex_vertex, vertex_dtdt );
