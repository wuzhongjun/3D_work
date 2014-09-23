function [ img , five_xy ] = my_projection( vertex, tex, disp)
%MY_PROJECTION Summary of this function goes here
%   Detailed explanation goes here
%     load('D:\learning_opengl\BaselFace\02_save_mat\gem_vertex.mat');

if disp == 1
    global vertex_dtdt;
    width = 501;
    rp     = defrp;
%     tex([10505,7644,12500,5159,3863]) = repmat([255],[1,5]);

%     h = figure(10);
%     my_display_face_2d(vertex,tex,vertex_dtdt,rp);                             
%     F = getframe(gcf);
%     imwrite(F.cdata,'p.bmp');
    
    
    vertex = vertex./500;
    mexf([width,width],vertex_dtdt',vertex(1,:),vertex(2,:),vertex(3,:),[tex;tex;tex],'p.bmp',0);
    
    img = imread('p.bmp');
    img = img(:,:,1);
    
%     vertex(1,:) = vertex(1,:) / 100000 * (width - 1)/2 + (width + 1) / 2; 
%     vertex(2,:) = width + 1 - (vertex(2,:) / 100000 * (width - 1)/2 + (width + 1) / 2); 
    
    vertex(1,:) = vertex(1,:) + (width + 1 )/2 ;
    vertex(2,:) = width + 1 - ( vertex(2,:) + (width + 1)/2 );
    
    
%     five_xy = uint32(vertex([1,2],[10505,7644,12500,5159,3863]))';
%     
%    2-13109,3354,14159
    five_xy = (vertex([1,2],[5034,7644,12500,5159,3863]))';
%%
elseif disp == 0
    max_x = max(vertex(1,:));
    min_x = min(vertex(1,:));
    max_y = max(vertex(2,:));
    min_y = min(vertex(2,:));
    height = 100;
    width = uint8((max_x - min_x)*height/(max_y - min_y));
    vertex(1,:) = (vertex(1,:) - min_x) .* double(width - 1)  ./ (max_x - min_x) + 1;
    vertex(2,:) = height - ((vertex(2,:) - min_y) .* double(height - 1) ./ (max_y - min_y) );
%     max_x = max(vertex(1,:));
%     min_x = min(vertex(1,:));
%     max_y = max(vertex(2,:));
%     min_y = min(vertex(2,:));
    img = zeros(height,width);
    depth = zeros(height,width);
    start = zeros(1,width);
    endend = zeros(1,width);
    start = repmat([height],1,width);
    endend = repmat([1],1,width);
    for i = 1 : size(vertex,2)
        tmp_x = uint32(vertex(1,i));
        tmp_y = uint32(vertex(2,i));
        tmp_z = vertex(3,i);
        if tmp_z > depth(tmp_y,tmp_x)
            img(tmp_y,tmp_x) = tex(i);
            depth(tmp_y,tmp_x) = tmp_z;
            if tmp_y < start(tmp_x) 
                start(tmp_x) = tmp_y;
            end
            if tmp_y > endend(tmp_x) 
                endend(tmp_x) = tmp_y;
            end
        end
    end
    img_tmp = img;
    cnt = 0;
    for i = 1:width
        for j = (start(i)+1) : (endend(i)-1)
                step = 0;
                while img_tmp(j,i) == 0
                    cnt = cnt + 1;
                    step = step + 1;
                    cal_sum = 0;
                    num = 0;
                    if i >= (1 + step) && img(j,i - step) ~= 0
                        num = num + 1;  cal_sum = cal_sum + img(j,i - step);
                    end
                    if i <= (width - step) && img(j,i + step) ~= 0
                        num = num + 1;  cal_sum = cal_sum + img(j,i + step);
                    end
                    if j >= (1 + step) && img(j - step,i) ~= 0
                        num = num + 1;  cal_sum = cal_sum + img(j - step,i);
                    end
                    if j <= (height - step) && img(j + step,i) ~= 0
                        num = num + 1;  cal_sum = cal_sum + img(j + step,i);
                    end
                    if num ~= 0 
                    img_tmp(j,i) = uint32(cal_sum / num);
                    end
                end
        end
    end
    five_xy = uint32(vertex([1,2],[10505,7644,12500,5159,3863]))';
%     nine_xy = [five_xy; 1 1; width 1; 1 height; width height];
    img = img_tmp;
end
%%    
%     h = figure(10);
%     subplot(1,2,1);imshow(uint8(img));
% %     h = figure(11);
%     subplot(1,2,2);imshow(uint8(img_tmp));hold on
% %     fprintf('cnt:%d\n',cnt);
% %17078    
%     plot(nine_xy(:,1),nine_xy(:,2),'+r');
%     hold off
%     pause;
    
end

