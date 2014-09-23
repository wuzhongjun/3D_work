function [ out_image] = five_points_to_frontal( in_image_name, five_xy )
%FIVE_POINTS_TO_FRONTAL Summary of this function goes here
%   Detailed explanation goes here
    load('../02_save_mat/gem_vertex.mat');
    disp_img = 0;
    outDir4 = 'D:\learning_opengl\BaselFace\02_generated_ply4\';
%     global vertex_dtdt;
    xiexian = find(in_image_name == '\');
    out_image_name = in_image_name(xiexian(end) + 1:end);
    if  out_image_name(11:13) == '080'
           P_angle = -45;
        end
        if  out_image_name(11:13) == '130'
           P_angle = -30;
        end
        if  out_image_name(11:13) == '140'
           P_angle = -15;
        end
        if  out_image_name(11:13) == '051'
           P_angle = 0;
        end
        if  out_image_name(11:13) == '050'
           P_angle = 15;
        end
        if  out_image_name(11:13) == '041'        
           P_angle = 30;
        end
        if  out_image_name(11:13) == '190'
           P_angle = 45;
        end
    five_xy = reshape(five_xy,10,1);
    in_image = imread(in_image_name);
    if disp_img == 1
        h = figure(1);
        subplot(1,2,1);
        imshow(in_image);
    end
    im_height = size(in_image,1);
    im_width = size(in_image,2);
    five_x = five_xy(1:2:end);
    five_y = five_xy(2:2:end);
    eye_dist_2d = abs(five_x(1) - five_x(2));
    tmplt_pts=[1 1;1 im_height; im_width 1;im_width im_height]'; 
    five_xy = double(five_xy);
    lx = five_xy(1);
    ly = five_xy(2);
    rx = five_xy(3);
    ry = five_xy(4);
    nx = five_xy(5);
    ny = five_xy(6);
    mlx = five_xy(7);
    mly = five_xy(8);
    mrx = five_xy(9);
    mry = five_xy(10);
    
    tic;
    for cnt = 2
%         load(['../02_save_mat/gem_vertex_sym' '.mat']); 
%         tmp_ge = vertex;
%         tmp_ge_tex = tex_vertex;
        load(['../02_save_mat4/gem_vertex_' num2str(cnt) '.mat']);
        new_gem_tex = zeros(3,size(tmp_ge_tex,2));
        five_gem{cnt} = tmp_ge(:,[5034,7644,12500,5159,3863])';
               
%         five_gem{cnt} = tmp_ge(:,[10506,14171,12500,8262,16759])';
%         load(['../02_save_mat4/gem_vertex_' num2str(cnt) '.mat']);
%         new_gem_tex = zeros(3,size(tmp_ge_tex,2));
%         five_gem{cnt} = tmp_ge(:,[5034,7644,12500,5159,3863])';
        five_gem{cnt}(1, 1) = -five_gem{cnt}(2, 1);
        five_gem{cnt}(1, 2) = five_gem{cnt}(2, 2);
% %         five_gem{cnt}(2, 3) = five_gem{cnt}(1, 3);
        five_gem{cnt}(5, 1) = -five_gem{cnt}(4, 1);
        five_gem{cnt}(5, 2) = five_gem{cnt}(4, 2);
        all_gem{cnt} = tmp_ge';
        eye_dist_3d = abs(five_gem{cnt}(1,1) - five_gem{cnt}(2,1));
        scale = eye_dist_3d / eye_dist_2d;
        five_gem{cnt} = five_gem{cnt} ./ scale;
        all_gem{cnt} = all_gem{cnt} ./ scale;
        re_five_gem{cnt} = zeros(size(five_gem{cnt},1)*2,8);
        re_five_gem{cnt}(1:2:size(re_five_gem{cnt},1),:) = [five_gem{cnt} repmat([1 0 0 0 0],size(five_gem{cnt},1),1)];
        re_five_gem{cnt}(2:2:size(re_five_gem{cnt},1),:) = [repmat([0 0 0 0],size(five_gem{cnt},1),1) five_gem{cnt} repmat([1],size(five_gem{cnt},1),1)];
        re_all_gem{cnt} = zeros(size(all_gem{cnt},1)*2,8);
        re_all_gem{cnt}(1:2:size(re_all_gem{cnt},1),:) = [all_gem{cnt} repmat([1 0 0 0 0],size(all_gem{cnt},1),1)];
        re_all_gem{cnt}(2:2:size(re_all_gem{cnt},1),:) = [repmat([0 0 0 0],size(all_gem{cnt},1),1) all_gem{cnt} repmat([1],size(all_gem{cnt},1),1)];
        P{cnt} = pinv(re_five_gem{cnt}) * five_xy;
        P_angle_z{cnt} = atan(-P{cnt}(5)/P{cnt}(6))*180/pi;
        P_angle_x{cnt} = asin(-P{cnt}(7))*180/pi;     
        P_angle_y{cnt} = asin(-P{cnt}(3)/P{cnt}(6)*cos(P_angle_z{cnt}*pi/180))*180/pi;
        
        re_2d{cnt} = re_five_gem{cnt} * P{cnt}; 
        r{cnt} = five_xy - re_2d{cnt};
        all_gem_2d{cnt} = re_all_gem{cnt} * P{cnt};
    end
%     for cnt = 1 : 6
%         norm_r(cnt) = norm(r{cnt});        
%     end
%     [~,cnt] = min(norm_r);
    fprintf('cnt:%d\np_angle_y:%f\np_angle_x:%f\np_angle_z:%f\n',cnt,P_angle_y{cnt},P_angle_x{cnt},P_angle_z{cnt});
    
        ref_point=[re_2d{cnt}(1) re_2d{cnt}(2); re_2d{cnt}(3) re_2d{cnt}(4); (re_2d{cnt}(7)+re_2d{cnt}(9))/2 (re_2d{cnt}(8)+re_2d{cnt}(10))/2];
        pa_img = affi_change(in_image, tmplt_pts, ref_point,lx,ly,rx,ry,(mlx+mrx)/2,(mly+mry)/2);   
%% try left eye, nose, left mouth
%         if P_angle ~= 0
%             if P_angle_y{cnt} > 0
%                 ref_point=[re_2d{cnt}(1) re_2d{cnt}(2); re_2d{cnt}(5) re_2d{cnt}(6); re_2d{cnt}(7) re_2d{cnt}(8)];
%                 pa_img = affi_change(in_image, tmplt_pts, ref_point,lx,ly,nx,ny,mlx,mly);   
%             else
%                 ref_point=[re_2d{cnt}(3) re_2d{cnt}(4); re_2d{cnt}(5) re_2d{cnt}(6); re_2d{cnt}(9) re_2d{cnt}(10)];
%                 pa_img = affi_change(in_image, tmplt_pts, ref_point,rx,ry,nx,ny,mrx,mry);   
%             end
%         else
%             ref_point=[re_2d{cnt}(1) re_2d{cnt}(2); re_2d{cnt}(3) re_2d{cnt}(4); (re_2d{cnt}(7)+re_2d{cnt}(9))/2 (re_2d{cnt}(8)+re_2d{cnt}(10))/2];
%             pa_img = affi_change(in_image, tmplt_pts, ref_point,lx,ly,rx,ry,(mlx+mrx)/2,(mly+mry)/2);   
%         end
%%
        if disp_img == 1
            h = figure(1);
            subplot(1,2,2);
            imshow(pa_img);
            hold off;
        end
        for i = 1:size(new_gem_tex,2)
%             new_gem_tex(i) = interp2(pa_img,all_gem_2d{cnt}((i - 1)*2+1),all_gem_2d{cnt}(2*i),'bilinear');
%             if i ~= [5034,7644,12500,5159,3863]
                new_gem_tex(1,i) = pa_img(uint32(all_gem_2d{cnt}(2*i)),uint32(all_gem_2d{cnt}((i - 1)*2+1)));
                new_gem_tex(2,i) = pa_img(uint32(all_gem_2d{cnt}(2*i)),uint32(all_gem_2d{cnt}((i - 1)*2+1)));
                new_gem_tex(3,i) = pa_img(uint32(all_gem_2d{cnt}(2*i)),uint32(all_gem_2d{cnt}((i - 1)*2+1)));
%             else
%                 new_gem_tex(1,i) = 255;
%                 new_gem_tex(2,i) = 0;
%                 new_gem_tex(3,i) = 0;
%             end
        end
        
%         tmptmp_str{i} = strcat('five_points_to_frontal_',num2str(cnt),'.ply');
%         plywrite(fullfile(outDir4,tmptmp_str{i}), tmp_ge, repmat(new_gem_tex,3,1), vertex_dtdt); 
        window_width = 501;
        tmp_ge = double(tmp_ge)./400;
        cur_img_dir = ['D:\learning_opengl\BaselFace\02_profile_frontal\' out_image_name(1:end-4) '_' num2str(cnt) '_frontal.bmp'];
        mexf([window_width,window_width],vertex_dtdt',tmp_ge(1,:),tmp_ge(2,:),tmp_ge(3,:),[new_gem_tex],cur_img_dir,0);        
%         mexf([width,width],vertex_dtdt',vertex(1,:),vertex(2,:),vertex(3,:),[tex;tex;tex],'p.bmp',0);
        cur_img = imread(cur_img_dir);        
        cur_img = cur_img(:,:,1);
%         if abs(P_angle_y{cnt}) > 10 
        if P_angle ~= 0
            if P_angle_y{cnt} > 0 
                for i = ((window_width - 1) / 2 + 1) : window_width                    
                    cur_img(:,i) = cur_img(:,window_width + 1 - i);                    
                end
            elseif P_angle_y{cnt} < 0
                for i = 1 : ((window_width - 1) / 2 + 1)
                    cur_img(:,i) = cur_img(:,window_width + 1 - i);                    
                end
            end
        end
           
        cur_img_dir = ['D:\learning_opengl\BaselFace\02_profile_frontal\' out_image_name(1:end-4) '_' num2str(cnt) '_frontal.bmp'];
        imwrite(cur_img,cur_img_dir);
        cnt = 2;
        resize_img = imresize(cur_img,0.3,'bilinear');
        resize_img_dir = ['D:\learning_opengl\BaselFace\02_profile_frontal_resize\' out_image_name(1:end-4) '_' num2str(cnt) '_resize.bmp'];
        imwrite(resize_img,resize_img_dir);  
    tim = toc;
    fprintf('use time:%3.5f\n',tim);        
%     pause;
             
end

% load('..\02_save_mat\sparse_vertex.mat');
% xyz_3d = [vertex_x vertex_y vertex_z];
% five_gem = xyz_3d([39 40 53 60 66],:);
% eye_dist_3d = abs(five_gem(1,1) - five_gem(2,1));
% scale = eye_dist_3d / eye_dist_2d;
% five_gem = five_gem ./ scale;
% re_five_gem = zeros(size(five_gem,1)*2,8);
% re_five_gem(1:2:size(re_five_gem,1),:) = [five_gem repmat([1 0 0 0 0],size(five_gem,1),1)];
% re_five_gem(2:2:size(re_five_gem,1),:) = [repmat([0 0 0 0],size(five_gem,1),1) five_gem repmat([1],size(five_gem,1),1)];
% P = pinv(re_five_gem) * five_xy;
% P_angle_z = atan(-P(5)/P(6))*180/pi;
% P_angle_x = asin(-P(7))*180/pi;     
% angle1 = asin(-P(3)/P(6)*cos(P_angle_z*pi/180))*180/pi;
% 
% if isreal(angle1) 
%     P_angle = angle1;
% end

% 
% if isreal(angle1) 
%     P_angle = angle1;
% end