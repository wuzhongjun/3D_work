function [ dist_index , P_angle] = face_recognition_v3( image_name_all , img_str, std_num,iii)
%FACE_RECOGNITION_V2 Summary of this function goes here
%   Detailed explanation goes here
%% load the image
    global vertex_dtdt;
    
    print_fig = 0;
    print_fig2 = 0 ;
    create = 2;%0 stable angle, read stacked data/1 stable angle, create data/2 not create any data, predict angle
               %3 do not save any data
    lunkuo = 3;
    disp_mode = 1;
    xy_dir = ' D:\learning_opengl\BaselFace\02_xy_ordinate\';
    xiexian = find(image_name_all == '\');
    image_name = image_name_all(xiexian(end) + 1:end);
    img = imread(image_name_all);
    img_height = size(img,1);
    img_width = size(img,2);
    depth = 2;
    if print_fig == 1 
        figure(1)
        subplot(1,3,1);
        imshow(reshape(img,[img_height,img_width]));   hold on;
%         rectangle('position',[1,1,64,74]); hold on;
        plot([15  50 32.5],[20 20 60],'+r');  hold off;
        subplot(1,3,2);
        subplot(1,3,3);
    end
    
    P_angle = 0;
    P_angle_z = 0;
    P_angle_x = 0;
    dist_index = 0;
    if lunkuo ==1
        gen_img_whole_l1_v3 = [];
    elseif lunkuo == 2
        gen_img_whole_l2_v3 = [];
    elseif lunkuo == 3
        gen_img_whole_l3_v3 = [];
    end
%% caculate the projected angle
    if  image_name(11:13) == '080'
        if create == 0
            if lunkuo ==1
                load('gen_img_whole_l1_1_v3');
            elseif lunkuo == 2
                load('gen_img_whole_l2_1_v3');
            elseif lunkuo == 3
                load('gen_img_whole_l3_1_v3');
            end            
        end
       P_angle = -45;
    end
    if  image_name(11:13) == '130'
        if create == 0
            if lunkuo ==1
                load('gen_img_whole_l1_2_v3');
            elseif lunkuo == 2
                load('gen_img_whole_l2_2_v3');
            elseif lunkuo == 3
                load('gen_img_whole_l3_2_v3');
            end            
        end
       P_angle = -30;
    end
    if  image_name(11:13) == '140'
        if create == 0
            if lunkuo ==1
                load('gen_img_whole_l1_3_v3');
            elseif lunkuo == 2
                load('gen_img_whole_l2_3_v3');
            elseif lunkuo == 3
                load('gen_img_whole_l3_3_v3');
            end            
        end
       P_angle = -15;
    end
    if  image_name(11:13) == '051'
        if create == 0
            if lunkuo ==1
                load('gen_img_whole_l1_4_v3');
            elseif lunkuo == 2
                load('gen_img_whole_l2_4_v3');
            elseif lunkuo == 3
                load('gen_img_whole_l3_4_v3');
            end            
        end
       P_angle = 0;
    end
    if  image_name(11:13) == '050'
        if create == 0
            if lunkuo ==1
                load('gen_img_whole_l1_5_v3');
            elseif lunkuo == 2
                load('gen_img_whole_l2_5_v3');
            elseif lunkuo == 3
                load('gen_img_whole_l3_5_v3');
            end            
        end
       P_angle = 15;
    end
    if  image_name(11:13) == '041'
        if create == 0
            if lunkuo ==1
                load('gen_img_whole_l1_6_v3');
            elseif lunkuo == 2
                load('gen_img_whole_l2_6_v3');
            elseif lunkuo == 3
                load('gen_img_whole_l3_6_v3');
            end            
        end
       P_angle = 30;
    end
    if  image_name(11:13) == '190'
        if create == 0
            if lunkuo ==1
                load('gen_img_whole_l1_7_v3');
            elseif lunkuo == 2
                load('gen_img_whole_l2_7_v3');
            elseif lunkuo == 3
                load('gen_img_whole_l3_7_v3');    
            end            
        end
       P_angle = 45;
    end
    fprintf('real_angle:%f\n',P_angle);
    %% load five landmark
if create == 2
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
    fclose(fp);
    eye_dist_2d = abs(five_x(1) - five_x(2));
%% caculate the projected angle
%     load('..\02_save_mat\sparse_vertex.mat');
%     xyz_3d = [vertex_x vertex_y vertex_z];
%     
%     five_gem = xyz_3d([39 40 53 60 66],:);
    load(['../02_save_mat4/gem_vertex_' num2str(depth) '.mat']);
    five_gem = tmp_ge(:,[5034,7644,12500,5159,3863])';
%     five_gem(2,1) = -five_gem(1,1);
%     five_gem(2,[2 3]) = five_gem(1,[2 3]);
%     five_gem(5,1) = -five_gem(4,1);
%     five_gem(5,[2 3]) = five_gem(4,[2 3]);
%     five_gem(3,1) = 0;
    eye_dist_3d = abs(five_gem(1,1) - five_gem(2,1));
    scale = eye_dist_3d / eye_dist_2d;
    five_gem = five_gem ./ scale;
    re_five_gem = zeros(size(five_gem,1)*2,8);
    re_five_gem(1:2:size(re_five_gem,1),:) = [five_gem repmat([1 0 0 0 0],size(five_gem,1),1)];
    re_five_gem(2:2:size(re_five_gem,1),:) = [repmat([0 0 0 0],size(five_gem,1),1) five_gem repmat([1],size(five_gem,1),1)];
    P = pinv(re_five_gem) * five_xy;
    P_angle_z = atan(-P(5)/P(6))*180/pi;
    P_angle_x = asin(-P(7))*180/pi;     
    angle1 = asin(-P(3)/P(6)*cos(P_angle_z*pi/180))*180/pi;

    if isreal(angle1) 
        P_angle = angle1;
    end
    fprintf('angle_z:%f,angle_x:%f\n',P_angle_z,P_angle_x);
end
%% Render parameters
    rp     = defrp;%set some default parameters
%% all 3D model project at P_angle
    rot_phi = P_angle*pi/180;
    rot_phi_z = P_angle_z*pi/180;
    rot_phi_x = P_angle_x*pi/180;
%     rot_phi = 0;
    rot_x = [1            0             0;
             0   cos(rot_phi_x)  sin(rot_phi_x);
             0  -sin(rot_phi_x)  cos(rot_phi_x) ];
    rot_z = [cos(rot_phi_z) sin(rot_phi_z) 0;
            -sin(rot_phi_z) cos(rot_phi_z)  0;
            0            0             1];
    rot_y = [cos(rot_phi)  0   sin(rot_phi);
            0              1   0;
            -sin(rot_phi)  0   cos(rot_phi)];
%     load('D:\learning_opengl\BaselFace\02_save_mat\gem_vertex.mat');
%     h = figure(3);
%     my_display_face_2d_rgb(vertex,tex_vertex,vertex_dtdt,rp);
    img = img(:)';
    pa_img_all = [];
    tmplt_pts=[1 1;1 75; 65 1;65 75]';
    ref_point=[15 20; 50 20; 32.5 60];
    tic;
    load('D:\learning_opengl\BaselFace\02_save_mat\gem_vertex.mat');
if create ~= 0 
    for i = 1:250
        if i ~= 213
            if lunkuo == 1
                tmp_str = strcat('D:\learning_opengl\BaselFace\02_save_mat\',img_str{i},'.mat');
            elseif lunkuo == 2
                tmp_str = strcat('D:\learning_opengl\BaselFace\02_save_mat2\',img_str{i},'.mat');
            elseif lunkuo == 3
                tmp_str = strcat('D:\learning_opengl\BaselFace\02_save_mat3\',img_str{i},'.mat');    
            end
            load(tmp_str);
%             tmp_ge = rot_y * tmp_ge;
            tmp_ge = rot_y  * tmp_ge;
            [gen_img,gen_xy] = my_projection(tmp_ge,tmp_ge_tex,disp_mode);
%             pause;          
            zero_index2 = find(gen_img == 0);
            gen_img(zero_index2) = repmat([140],size(zero_index2,1),size(zero_index2,2));
            if print_fig2 == 1 && i == std_num
                h = figure(2);
                imshow(uint8(gen_img)); hold on;
                plot([gen_xy(:,1)],[gen_xy(:,2)],'+r');   hold off;
            end
            
            gen_xy = double(gen_xy);
            lx = gen_xy(1,1);
            ly = gen_xy(1,2);
            rx = gen_xy(2,1);
            ry = gen_xy(2,2);
            mlx = gen_xy(4,1);
            mly = gen_xy(4,2);
            mrx = gen_xy(5,1);
            mry = gen_xy(5,2);


            pa_img = affi_change(gen_img, tmplt_pts, ref_point,lx,ly,rx,ry,(mlx+mrx)/2,(mly+mry)/2);                     
            if lunkuo == 1
                gen_img_whole_l1_v3 = [gen_img_whole_l1_v3;pa_img(:)'];
            elseif lunkuo == 2
                gen_img_whole_l2_v3 = [gen_img_whole_l2_v3;pa_img(:)'];
            elseif lunkuo == 3
                gen_img_whole_l3_v3 = [gen_img_whole_l3_v3;pa_img(:)'];    
            end 
            %replace zeros with img's texture
%             zero_index = find(pa_img == 0);
% %             pa_img(zero_index) = img(zero_index);
%             pa_img(zero_index) = repmat([140],size(zero_index,1),size(zero_index,2));
            if  print_fig2 == 1 %&& i == std_num
                figure(1);      
               subplot(1,3,2);
                imshow(uint8(pa_img));  hold on;
                plot([15  50 32.5],[20 20 60],'+r');  hold off;
            end
%             if print_fig2 == 1
%                 h = figure(3);
%                 my_display_face_2d(tmp_ge,tmp_ge_tex,vertex_dtdt,rp);
%                 hold off;
%             end
%             img_write_dir{i} = strcat('D:\learning_opengl\BaselFace\02_projected_bmp\',num2str(i),'_',image_name(1:end-4),'_p.bmp');                         
%             saveas(gcf,img_write_dir{i});
            pa_img_all = [pa_img_all ; pa_img(:)'];
%             F = getframe(gcf);
%             imwrite(F.cdata,img_write_dir{i});
%             delete(F);
%              pause;
        end        
    end
    if create == 1
        if  image_name(11:13) == '080'
            if lunkuo ==1
                save('gen_img_whole_l1_1_v3','gen_img_whole_l1_v3');
            elseif lunkuo == 2
                save('gen_img_whole_l2_1_v3','gen_img_whole_l2_v3');
            elseif lunkuo == 3
                save('gen_img_whole_l3_1_v3','gen_img_whole_l3_v3');    
            end            
        end
        if  image_name(11:13) == '130'       
            if lunkuo ==1
                save('gen_img_whole_l1_2_v3','gen_img_whole_l1_v3');
            elseif lunkuo == 2
                save('gen_img_whole_l2_2_v3','gen_img_whole_l2_v3');
            elseif lunkuo == 3
                save('gen_img_whole_l3_2_v3','gen_img_whole_l3_v3');                    
            end               
        end
        if  image_name(11:13) == '140'
            if lunkuo ==1
                save('gen_img_whole_l1_3_v3','gen_img_whole_l1_v3');
            elseif lunkuo == 2
                save('gen_img_whole_l2_3_v3','gen_img_whole_l2_v3');
            elseif lunkuo == 3
                save('gen_img_whole_l3_3_v3','gen_img_whole_l3_v3');                   
            end           
        end
        if  image_name(11:13) == '051'
            if lunkuo ==1
                save('gen_img_whole_l1_4_v3','gen_img_whole_l1_v3');
            elseif lunkuo == 2
                save('gen_img_whole_l2_4_v3','gen_img_whole_l2_v3');
            elseif lunkuo == 3
                save('gen_img_whole_l3_4_v3','gen_img_whole_l3_v3');    
            end
        end
        if  image_name(11:13) == '050'
            if lunkuo ==1
                save('gen_img_whole_l1_5_v3','gen_img_whole_l1_v3');
            elseif lunkuo == 2
                save('gen_img_whole_l2_5_v3','gen_img_whole_l2_v3');
            elseif lunkuo == 3
                save('gen_img_whole_l3_5_v3','gen_img_whole_l3_v3');    
            end
        end
        if  image_name(11:13) == '041'
            if lunkuo ==1
                save('gen_img_whole_l1_6_v3','gen_img_whole_l1_v3');
            elseif lunkuo == 2
                save('gen_img_whole_l2_6_v3','gen_img_whole_l2_v3');
            elseif lunkuo == 3
                save('gen_img_whole_l3_6_v3','gen_img_whole_l3_v3');    
            end
        end
        if  image_name(11:13) == '190'
            if lunkuo ==1
                save('gen_img_whole_l1_7_v3','gen_img_whole_l1_v3');
            elseif lunkuo == 2
                save('gen_img_whole_l2_7_v3','gen_img_whole_l2_v3');
            elseif lunkuo == 3
                save('gen_img_whole_l3_7_v3','gen_img_whole_l3_v3');    
            end
        end
    end
    pa_img_all = [img;pa_img_all];
else
%     for i = 1:249
%             if lunkuo == 1
% %                 pa_img = gen_img_whole_l1(i,:);
%                 zero_index = find(pa_img == 0);
% %             pa_img(zero_index) = img(zero_index);
%                 pa_img(zero_index) = repmat([140],size(zero_index,1),size(zero_index,2));
%                 gen_img_whole_l1(i,:) = pa_img;
%             elseif lunkuo == 2
%                 pa_img = gen_img_whole_l2(i,:);
%                 zero_index = find(pa_img == 0);
% %             pa_img(zero_index) = img(zero_index);
%                 pa_img(zero_index) = repmat([140],size(zero_index,1),size(zero_index,2));
%                 gen_img_whole_l2(i,:) = pa_img;
%             end          
%     end
    if lunkuo == 1
        zero_index = find(gen_img_whole_l1_v3 == 0);
        gen_img_whole_l1_v3(zero_index) = repmat([140],size(zero_index,1),size(zero_index,2));
        pa_img_all = [img;gen_img_whole_l1_v3];
    elseif lunkuo == 2
        zero_index = find(gen_img_whole_l2_v3 == 0);
        gen_img_whole_l2_v3(zero_index) = repmat([140],size(zero_index,1),size(zero_index,2));
        pa_img_all = [img;gen_img_whole_l2_v3];
    elseif lunkuo == 3
        zero_index = find(gen_img_whole_l3_v3 == 0);
        gen_img_whole_l3_v3(zero_index) = repmat([140],size(zero_index,1),size(zero_index,2));
        pa_img_all = [img;gen_img_whole_l3_v3];    
    end
end

    all_dist = pdist(double(pa_img_all),'cosine');
    part_dist = all_dist(1:249);
    [dist,dist_index] = min(part_dist);
    if std_num > 213
        std_num = std_num - 1;
    end        
    
% for i = 1:249   
%     imwrite(reshape(pa_img_all(i+1,:),[img_height,img_width]),['D:\learning_opengl\MPIE\virtual\' num2str(i,'%03d') image_name(4:end-4) '_virtual.bmp']);
% end
    if print_fig == 1    
%             h = figure(1);
%             subplot(1,3,1);
%             imshow(reshape(img,[img_height,img_width]));   hold on;
%     %         rectangle('position',[1,1,64,74]); hold on;
%             plot([15  50],[20 20],'+r');  hold off;
            figure(1);
            subplot(1,3,2);
            imshow(reshape(pa_img_all(dist_index+1,:),[img_height,img_width])); hold on;
            plot([15  50 32.5],[20 20 60],'+r');  hold off;
            subplot(1,3,3);
            imshow(reshape(pa_img_all(std_num+1,:),[img_height,img_width])); hold on;
            plot([15  50 32.5],[20 20 60],'+r');   hold off;
        end  
    if dist_index ~= std_num
       
%         img_write_dir = strcat('D:\learning_opengl\BaselFace\02_projected_bmp\0528\',num2str(iii),'_',num2str(dist_index),'_',image_name(1:end-4),'.bmp');                         
%         F = getframe(gcf);
%         imwrite(F.cdata,img_write_dir);
        fprintf('false\n');
%         pause;
    else
        fprintf('true\n');
    end
    
    tim = toc;
    fprintf('P_angle:%f\n',P_angle);
    fprintf('create all pa_img cost time:%3.5f\n',tim);
    fprintf('img_name:%s\ndist:%d,dist_index:%d\n',image_name,dist,dist_index);
    fprintf('dist_yuan:%d\n\n',part_dist(std_num));
    if dist_index > 212
        dist_index = dist_index + 1;
    end
%     pause;
end

