function [ dist_index , P_angle] = face_recognition_raw( image_name_all , img_str, std_num,iii)
%FACE_RECOGNITION_V2 Summary of this function goes here
%   Detailed explanation goes here
%% load the image
    print_fig = 0;
    print_fig2 = 0;
    create = 2;%0 stable angle, read stacked data/1 stable angle, create data/2 not create any data, predict angle  
    lunkuo = 3;
    xy_dir = ' D:\learning_opengl\BaselFace\02_xy_ordinate\';
    xiexian = find(image_name_all == '\');
    image_name = image_name_all(xiexian(end) + 1:end);
    img = imread(image_name_all);
    img_height = size(img,1);
    img_width = size(img,2);
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
%% caculate the projected angle
   
 
%     h = figure(3);
%     my_display_face_2d_rgb(vertex,tex_vertex,vertex_dtdt,rp);
    img = img(:)';
    pa_img_all2 = [];
% %     tmplt_pts=[1 1;1 75; 65 1;65 75]';
% %     ref_point=[15 20 50 20];
% %     img_dir = dir('D:\learning_opengl\MPIE\croppedimg\*.bmp');
%     for i = 1 : 250
%      if i ~= 213
%      img_str_all{i} = strcat(num2str(i,'%03d'),'_01_01_051_07.bmp');%to add more frontal face,change this cell
%      end
%  end
%     for i = 1:250
%         if i ~= 213
%             pa_img = imread(strcat('D:\learning_opengl\MPIE\croppedimg2\',img_str_all{i}));
%             
% 
%             %replace zeros with img's texture
% %             if print_fig2 == 1
% %                 h = figure(3);
% %                 my_display_face_2d(tmp_ge,tmp_ge_tex,vertex_dtdt,rp);
% %                 hold off;
% %             end
% %             img_write_dir{i} = strcat('D:\learning_opengl\BaselFace\02_projected_bmp\',num2str(i),'_',image_name(1:end-4),'_p.bmp');                         
% %             saveas(gcf,img_write_dir{i});
%             pa_img_all2 = [pa_img_all2 ; pa_img(:)'];
% %             F = getframe(gcf);
% %             imwrite(F.cdata,img_write_dir{i});
% %             delete(F);
%         end        
%     end
   load('pa_img_all2.mat','pa_img_all2');
    pa_img_all2 = [img;pa_img_all2];
    
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
    

    all_dist = pdist(double(pa_img_all2),'cosine');
    part_dist = all_dist(1:249);
    [dist,dist_index] = min(part_dist);
    if std_num > 213
        std_num = std_num - 1;
    end
    
    
    if dist_index ~= std_num

%         img_write_dir = strcat('D:\learning_opengl\BaselFace\02_projected_bmp\0518\',num2str(iii),'_',num2str(dist_index),'_',image_name(1:end-4),'.bmp');                         
%         F = getframe(gcf);
%         imwrite(F.cdata,img_write_dir);
        fprintf('false\n');
    else
        fprintf('true\n');
    end
    
    fprintf('img_name:%s\ndist:%d,dist_index:%d\n',image_name,dist,dist_index);
    fprintf('dist_yuan:%d\n\n',part_dist(std_num));
    if dist_index > 212
        dist_index = dist_index + 1;
    end
%      pause;
end



