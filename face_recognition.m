function [ dist_index , P_angle] = face_recognition( image_name_all , img_str, std_num,iii)
%FACE_RECOGNITION Summary of this function goes here
%   Detailed explanation goes here
%% crop the image
    print_fig = 1;
    print_fig2 = 0;
    xy_dir = ' D:\learning_opengl\BaselFace\02_xy_ordinate\';
    img = imread(image_name_all);
    img_height = size(img,1);
    img_width = size(img,2);
    xiexian = find(image_name_all == '\');
    image_name = image_name_all(xiexian(end) + 1:end);
     if strcmp(image_name(1:end - 4),'008_01_01_080_07') == 0 && strcmp(image_name(1:end - 4),'008_01_01_130_07') == 0
        exe_str = ['D:\learning_opengl\stasm4.1.0\vc10\minimal.exe',' ',image_name_all,xy_dir,image_name(1:end-4),'.txt']; 
    %          exe_str = exe_str{1};
        system(exe_str);   
     end
    tmp_str = strcat('D:\learning_opengl\BaselFace\02_xy_ordinate\',image_name(1:end-4),'.txt');
    [landmark_x landmark_y] = textread(tmp_str,'%d %d');  
    landmark_x = landmark_x + 1;
    landmark_y = img_height + 1 - landmark_y;
    min_x = min(landmark_x);
    max_x = max(landmark_x);
    min_y = min(landmark_y);
    max_y = max(landmark_y);
    img = imcrop(img,[min_x min_y (max_x - min_x + 1) (max_y - min_y + 1)]);
    
    img = imresize(img,1/3,'nearest');
%     figure(11);
%     imshow(img);
    
    img_height = size(img,1);
    img_width = size(img,2);
%% load five landmark
%     tmp_str = [image_name(1:end-4),'.jpg%d%d%d%d%d%d%d%d%d%d'];
    fp = fopen('D:\learning_opengl\session01\FaceFP_5_full.txt');    
    tmp_num = zeros(1:10);
%     tic;
    while(1)
        tmp_str = fscanf(fp,'%s',[1 1]);
        tmp_num = fscanf(fp,'%d%d%d%d%d%d%d%d%d%d',[1 10]);
        if strcmp(tmp_str,[image_name(1:end - 4),'.jpg']) == 1
            break;
        end
    end
%     tim = toc;
%     fprintf('read:%f\n',tim);
    five_xy = tmp_num';
    five_x = five_xy(1:2:end);
    five_y = five_xy(2:2:end);
    five_x = five_x - min_x + 2;
    five_y = five_y - min_y + 2;
    
    five_x = ceil(five_x / 3);
    five_y = ceil(five_y / 3);
    five_xy = ceil(five_xy / 3);
    
    eye_dist_2d = abs(five_x(1) - five_x(2));
if print_fig == 1    
    h = figure(1);
    subplot(1,2,1);
    imshow(img);    hold on;
     plot(five_x,five_y,'+r');   hold on;
end   
    P_angle = 0;
    dist_index = 0;
%% caculate the projected angle
    load('..\02_save_mat\sparse_vertex.mat');
    xyz_3d = [vertex_x vertex_y vertex_z];
    five_gem = xyz_3d([39 40 53 60 66],:);
    eye_dist_3d = abs(five_gem(1,1) - five_gem(2,1));
    scale = eye_dist_3d / eye_dist_2d;
    five_gem = five_gem ./ scale;
    re_five_gem = zeros(size(five_gem,1)*2,8);
    re_five_gem(1:2:size(re_five_gem,1),:) = [five_gem repmat([1 0 0 0 0],size(five_gem,1),1)];
    re_five_gem(2:2:size(re_five_gem,1),:) = [repmat([0 0 0 0],size(five_gem,1),1) five_gem repmat([1],size(five_gem,1),1)];
    P = pinv(re_five_gem) * five_xy;
    angle1 = asin(-P(3)/P(6))*180/pi;
    angle2 = 180 - acos(P(1)/P(6))*180/pi;
%     P_angle = angle1/2 + sign(angle1)* angle2 /2
    P_angle = angle1;
    
    if  image_name(11:13) == '080'
       P_angle = -45;
    end
    if  image_name(11:13) == '130'
       P_angle = -30;
    end
    if  image_name(11:13) == '140'
       P_angle = -15;
    end
    if  image_name(11:13) == '051'
       P_angle = 0;
    end
    if  image_name(11:13) == '050'
       P_angle = 15;
    end
    if  image_name(11:13) == '041'
       P_angle = 30;
    end
    if  image_name(11:13) == '190'
       P_angle = 45;
    end

%% delaunay Triangulation(add four corner point)
    nine_x = [five_x' 1 img_width 1 img_width]';
    nine_y = [five_y' 1 1 img_height img_height]';
    vertex_dt = delaunayTriangulation(nine_x,nine_y);
    vertex_dt1 = vertex_dt(:,1);
    vertex_dt2 = vertex_dt(:,2);
    vertex_dt3 = vertex_dt(:,3);
    nine_dtdt = [vertex_dt1';vertex_dt2';vertex_dt3']'; %vertex_dtdt n*3
    nine_xy = [nine_x' ; nine_y']';
% if print_fig == 1    
%     triplot(nine_dtdt,nine_x,nine_y);    
%     hold off
% end
    img_write_dir = strcat('D:\learning_opengl\BaselFace\02_projected_bmp\',num2str(iii),'_',image_name(1:end-4),'_p.bmp'); 
    F = getframe(gcf);
    imwrite(F.cdata,img_write_dir);
% %     delete(h);
%% Render parameters
    rp     = defrp;%set some default parameters
    rp.phi = 0;
    rp.dir_light.dir = [0;1;1];
    rp.dir_light.intens = 0.6*ones(3,1);
    rp.sbufsize=2000;
%% all 3D model project at P_angle
    rot_phi = P_angle*pi/180;
%     rot_phi = 0;
    rot_z = [cos(rot_phi) -sin(rot_phi) 0;
            sin(rot_phi) cos(rot_phi)  0;
            0            0             1];
    rot_y = [cos(rot_phi)  0   sin(rot_phi);
            0              1   0;
            -sin(rot_phi)  0   cos(rot_phi)];
    load('D:\learning_opengl\BaselFace\02_save_mat\gem_vertex.mat');
%     h = figure(3);
%     my_display_face_2d_rgb(vertex,tex_vertex,vertex_dtdt,rp);
    img = img(:)';
    pa_img_all = [];
    tic;
    for i = 1:250
        if i ~= 213
            tmp_str = strcat('D:\learning_opengl\BaselFace\02_save_mat\',img_str{i},'.mat');
            load(tmp_str);
            tmp_ge = rot_y * tmp_ge;
            [gen_img,gen_xy] = my_projection(tmp_ge,tmp_ge_tex);
            if print_fig2 == 1
                h = figure(2);
                imshow(uint8(gen_img)); hold on;
                plot(gen_xy(:,1),gen_xy(:,2),'+r');   hold on;
                triplot(nine_dtdt,gen_xy(:,1),gen_xy(:,2));   hold off;
            end
%             pause;
            pa_img = piece_affine(nine_dtdt,nine_xy,gen_img,gen_xy);
            if  print_fig2 == 1 
                figure(1);      
                subplot(1,2,2);
                imshow(uint8(pa_img));  hold off;
            end
            if print_fig2 == 1
                h = figure(3);
                my_display_face_2d(tmp_ge,tmp_ge_tex,vertex_dtdt,rp);
                hold off;
            end
%             img_write_dir{i} = strcat('D:\learning_opengl\BaselFace\02_projected_bmp\',num2str(i),'_',image_name(1:end-4),'_p.bmp');                         
%             saveas(gcf,img_write_dir{i});
            pa_img_all = [pa_img_all ; pa_img(:)'];
%             F = getframe(gcf);
%             imwrite(F.cdata,img_write_dir{i});
%             delete(F);
        end        
    end
    pa_img_all = [img;pa_img_all];
    all_dist = pdist(double(pa_img_all),'cosine');
    part_dist = all_dist(1:249);
    [dist,dist_index] = min(part_dist);
    if print_fig == 1    
        figure(1);
        subplot(1,2,2);
        imshow(reshape(pa_img_all(dist_index+1,:),[img_height,img_width]));    hold off;
    end  
    if dist_index > 213
        dist_index = dist_index + 1;
    end
    tim = toc;
    fprintf('P_angle:%f\n',P_angle);
    fprintf('create all pa_img cost time:%3.5f\n',tim);
    fprintf('img_name:%s\ndist:%d,dist_index:%d\n',image_name,dist,dist_index);
    pause;
end

