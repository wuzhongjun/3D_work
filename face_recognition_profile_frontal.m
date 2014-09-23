function [ dist_index ,P_angle] = face_recognition_profile_frontal( image_name_all , img_str, std_num,iii)
%FACE_RECOGNITION_V2 Summary of this function goes here
%   Detailed explanation goes here
%% load the image
    create_matrix = 0;
    dist_index = 0;
    P_angle = 0;
    if create_matrix == 1
        pa_img_all = [];
        for i = 1:250
            if i ~= 213
                pa_img = imread(['D:\learning_opengl\BaselFace\02_profile_frontal_resize2\' num2str(i,'%03d'),'_01_01_051_07_2_resize2.bmp']);
                pa_img = pa_img(:)';
                pa_img_all = [pa_img_all;pa_img];
            end
        end
        save('pa_img_all_profile2','pa_img_all');
    else
        disp_img = 1;

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
        if disp_img == 1
            h = figure(1);
            subplot(1,3,1);
            imshow(img);
        end
        img = img(:)';
        load('pa_img_all_profile2','pa_img_all');
        pa_img_all = [img;pa_img_all];
        all_dist = pdist(double(pa_img_all),'cosine');
        part_dist = all_dist(1:249);
        [dist,dist_index] = min(part_dist);
        if std_num > 213
            std_num = std_num - 1;
        end   
        if disp_img == 1
            figure(1);
            subplot(1,3,2);
            imshow(reshape(pa_img_all(dist_index+1,:),[img_height,img_width])); hold off;
            subplot(1,3,3);
            imshow(reshape(pa_img_all(std_num+1,:),[img_height,img_width])); hold off;
        end


    % for i = 1:249   
    %     imwrite(reshape(pa_img_all(i+1,:),[img_height,img_width]),['D:\learning_opengl\MPIE\virtual\' num2str(i,'%03d') image_name(4:end-4) '_virtual.bmp']);
    % end
        if dist_index ~= std_num

    %         img_write_dir = strcat('D:\learning_opengl\BaselFace\02_projected_bmp\0528\',num2str(iii),'_',num2str(dist_index),'_',image_name(1:end-4),'.bmp');                         
    %         F = getframe(gcf);
    %         imwrite(F.cdata,img_write_dir);
            fprintf('false\n');
    %         pause;
        else
            fprintf('true\n');
        end
        fprintf('P_angle:%d\n',P_angle);
        fprintf('img_name:%s\ndist:%d,dist_index:%d\n',image_name,dist,dist_index);
        fprintf('dist_yuan:%d\n\n',part_dist(std_num));
        if dist_index > 212
            dist_index = dist_index + 1;
        end
    end
%     pause;
end

