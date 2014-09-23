function [ dist_index , P_angle] = face_recognition_m_depth_FERET( image_name_all , img_str, std_num, estimate_angle, iii)
%FACE_RECOGNITION_V2 Summary of this function goes here
%   Detailed explanation goes here
%% load the image
    global vertex_dtdt;
    disp_mode = 1;
    print_fig = 1;
%     create = 2;%0 stable angle, read stacked data/1 stable angle, create data/2 not create any data, predict angle
               %3 do not save any data
%     lunkuo = 4;%1 eye position generate 3d model /2 face outline generate 3d model/3 manual landmark localization/4 multi depth
    
    xiexian = find(image_name_all == '\');
    image_name = image_name_all(xiexian(end) + 1:end);
    img = imread(image_name_all);
    img_height = size(img,1);
    img_width = size(img,2);
    
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
%% caculate the projected angle
    %% load five landmark
if estimate_angle == 1
    [five_x, five_y, ~] = textread(['D:\learning_opengl\pose\' image_name(1:end - 4) '_5loc.txt'],'%f %f %f');
    tmp = ([five_x five_y]');
    five_xy = tmp(:);
    eye_dist_2d = abs(five_x(1) - five_x(2));
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
    fprintf('angle_z:%f,angle_x:%f\n',P_angle_z,P_angle_x);
else
    if image_name(6:7) == 'ba'
        P_angle = 1.1;
    elseif image_name(6:7) == 'bb'
        P_angle = 38.9;
    elseif image_name(6:7) == 'bc'
        P_angle = 27.4;
    elseif image_name(6:7) == 'bd'
        P_angle = 18.9;
    elseif image_name(6:7) == 'be'
        P_angle = 11.2;
    elseif image_name(6:7) == 'bf'
        P_angle = -7.1;
    elseif image_name(6:7) == 'bg'
        P_angle = -16.3;
    elseif image_name(6:7) == 'bh'
        P_angle = -26.5;
    elseif image_name(6:7) == 'bi'
        P_angle = -37.9;
    end
    P_angle = P_angle - 1.1;
end
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
    load('D:\learning_opengl\BaselFace\02_save_mat\gem_vertex.mat');
    tic;

    for i = 1:200
            tmp_str = strcat('D:\learning_opengl\BaselFace\02_FERET_save_mat\',img_str{i}(1:end - 4),'.mat');
            load(tmp_str);
%             tmp_ge = rot_y * tmp_ge;
            tmp_ge = rot_y  * tmp_ge;
            [gen_img,gen_xy] = my_projection(tmp_ge,tmp_ge_tex,disp_mode);
%             pause;          
            zero_index2 = find(gen_img == 0);
            gen_img(zero_index2) = repmat([120],size(zero_index2,1),size(zero_index2,2));
            
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

            %replace zeros with img's texture
%             zero_index = find(pa_img == 0);
% %             pa_img(zero_index) = img(zero_index);
%             pa_img(zero_index) = repmat([140],size(zero_index,1),size(zero_index,2));
            pa_img_all = [pa_img_all ; pa_img(:)'];
%              pause;       
    end
    pa_img_all = [img;pa_img_all];
    all_dist = pdist(double(pa_img_all),'cosine');
    part_dist = all_dist(1:200);
%     [dist,dist_index] = min(part_dist);
    [s_part_dist s_index] = sort(part_dist,2,'ascend');
    s_index = s_index(1:20);
    pa_img_all2 = [];
%      for i = s_index 
    for i = 1 : 200
            for cnt = -1
                tmp_str = strcat('D:\learning_opengl\BaselFace\02_FERET_save_mat2\',img_str{i}(1 : end - 4),'_',num2str(cnt),'.mat');
                load(tmp_str);
                tmp_ge = rot_y  * tmp_ge;
                [gen_img,gen_xy] = my_projection(tmp_ge,tmp_ge_tex,disp_mode);

                zero_index2 = find(gen_img == 0);
                gen_img(zero_index2) = repmat([120],size(zero_index2,1),size(zero_index2,2));
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
                %replace zeros with img's texture
                zero_index = find(pa_img == 0);
    %             pa_img(zero_index) = img(zero_index);
                pa_img(zero_index) = repmat([120],size(zero_index,1),size(zero_index,2));
                
                imwrite( pa_img, ['D:\learning_opengl\pose\virtual_m_depth_noestimate\' img_str{i}(1:5) image_name(6:7) img_str{i}(8:end - 4) '_virtual_' num2str(cnt) '.tif']);
                
                pa_img_all2 = [pa_img_all2 ; pa_img(:)'];
    %             F = getframe(gcf);
    %             imwrite(F.cdata,img_write_dir{i});
    %             delete(F);
    %  pause;
            end        
     end
     pa_img_all2 = [img;pa_img_all2];
     all_dist2 = pdist(double(pa_img_all2),'cosine');
     part_dist2 = all_dist2(1:6*20);
     [dist,dist_index] = min(part_dist2);   
     m_depth = mod(dist_index,6);
     dist_index2 = dist_index;
     dist_index = s_index(floor((dist_index-1) / 6) + 1) *6;      
    
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
            imshow(reshape(pa_img_all2(dist_index2+1,:),[img_height,img_width])); hold on;
            plot([15  50 32.5],[20 20 60],'+r');  hold off;
            subplot(1,3,3);
%             if create ~= 2
%                 imshow(reshape(pa_img_all((std_num-1)*6+2,:),[img_height,img_width])); hold on;
%             else
                imshow(reshape(pa_img_all(std_num + 1,:),[img_height,img_width])); hold on;
%             end
            plot([15  50 32.5],[20 20 60],'+r');   hold off;
        end  
    if dist_index > (std_num * 6) | dist_index < (std_num * 6 - 6)
       
        img_write_dir = strcat('D:\learning_opengl\BaselFace\02_feret_wrong_image_m_depth\',num2str(std_num),'_',num2str(floor((dist_index-1) / 6) + 1),'_',image_name(1:end-4),'.bmp');                         
        F = getframe(gcf);
        imwrite(F.cdata,img_write_dir);
        fprintf('false\n');
%         pause;
    else
        fprintf('true\n');
    end
     tim = toc;
     dist_index = floor((dist_index-1) / 6) + 1;
%     if create ~= 2
%         fprintf('M_depth:%d\n',(mod((dist_index - 1),6) + 1));
%         
%        
%         fprintf('P_angle:%f\n',P_angle);
%         fprintf('create all pa_img cost time:%3.5f\n',tim);
%         fprintf('img_name:%s\ndist:%d,dist_index:%d\n',image_name,dist,dist_index);
%         fprintf('dist_yuan:%d\n\n',part_dist((std_num-1)*6+2));
%     else
        fprintf('M_depth:%d\n',m_depth);
        fprintf('P_angle:%f\n',P_angle);
        fprintf('cost time:%3.5f\n',tim);
        fprintf('dist:%d\ndist_yuan:%d\n\n',dist,part_dist(std_num));
%     end
%     pause;
end



