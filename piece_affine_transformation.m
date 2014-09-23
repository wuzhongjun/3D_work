%  clear
%   close all
%   kkk = 1;
nar_mode = 1;
mode = 0; % 0 for stasm auto landmark localization , 1 for manual landmark localization
img_str = {'002_test_frontal','002_test_l_15'};
img_str_all = {'002_test_frontal.png','002_test_l_15.png'};
xy_dir = ' D:\learning_opengl\BaselFace\02_xy_ordinate\';
pa_dir = 'D:\learning_opengl\BaselFace\02_pieceaffine\';
pa_dir2 = ' D:\learning_opengl\BaselFace\02_pieceaffine\';
% im1 = imread('D:\learning_opengl\BaselFace\02_test_all\001\001_test_l_15.png');
tic;
if nar_mode == 0
    for i = 1:2
        im{i} = imread([pa_dir img_str_all{i}]);
        im_height{i} = size(im{i},1);
        im_width{i} = size(im{i},2);
    end
else 
    i = 1;
    new_xy{i} = int32(ans_xy);
    new_xy{i} = double(new_xy{i});
    new_x{i} = new_xy{i}(:,1);
    new_y{i} = new_xy{i}(:,2);
    xy_len{i} = size(new_x{i},1);    
    [max_x{i},max_x_index] = max(new_x{i});
    max_x_y{i} = new_y{i}(max_x_index);
    [min_x{i},min_x_index] = min(new_x{i});
    min_x_y{i} = new_y{i}(min_x_index);
    [max_y{i},max_y_index] = max(new_y{i});
    max_y_x{i} = new_x{i}(max_y_index);
    [min_y{i},min_y_index] = min(new_y{i});
    min_y_x{i} = new_x{i}(min_y_index);
    im_height{i} = int32(max_y{i}) - int32(min_y{i}) + 1;
    im_width{i} = int32(max_x{i}) - int32(min_x{i}) + 1;
    % create image
    im{1} = zeros(im_height{i},im_width{i},3);
    new_xy{i} = new_xy{i} - repmat([min_x{i}-1 min_y{i}-1],size(new_xy{i},1),1);
    new_x{i} = new_xy{i}(:,1);
    new_y{i} = new_xy{i}(:,2);
    new_y{i} = double(im_height{i}) + 1 - new_y{i};
    [max_x{i},max_x_index] = max(new_x{i});
    max_x_y{i} = new_y{i}(max_x_index);
    [min_x{i},min_x_index] = min(new_x{i});
    min_x_y{i} = new_y{i}(min_x_index);
    [max_y{i},max_y_index] = max(new_y{i});
    max_y_x{i} = new_x{i}(max_y_index);
    [min_y{i},min_y_index] = min(new_y{i});
    min_y_x{i} = new_x{i}(min_y_index);
%     new_x{i} = double(new_x{i});
%     new_y{i} = double(new_y{i});
    for i = 2
        im{i} = imread([pa_dir img_str_all{i}]);
        im_height{i} = size(im{i},1);
        im_width{i} = size(im{i},2);
    end
end
im_temp = im{1};
% im2 = imread('D:\learning_opengl\BaselFace\02_test_all\002\002_test_r_15.png');
% im2 = imread('D:\learning_opengl\BaselFace\02_frontal_face\wu.jpg');
% im_frontal = imread('D:\learning_opengl\BaselFace\02_frontal_face\001_01.jpg');
for i = 1:2
    if i == 2 && mode == 1
        tmp_str = ['D:\learning_opengl\BaselFace\02_xy_ordinate\' img_str{i} '.xlsx'];
        new_xy{i} = xlsread(tmp_str,'A1:B77');
        new_x{i} = new_xy{i}(:,1);
        new_y{i} = new_xy{i}(:,2);
    elseif nar_mode == 0 | (i == 2 & mode == 0)
            exe_str{i} = strcat('D:\learning_opengl\stasm4.1.0\vc10\minimal.exe',pa_dir2,img_str_all{i},xy_dir,img_str{i},'.txt'); 
        %          exe_str = exe_str{1};
            system(exe_str{i});
            tmp_str = ['D:\learning_opengl\BaselFace\02_xy_ordinate\' img_str{i} '.txt'];
            [new_x{i} new_y{i}] = textread(tmp_str,'%d %d');
            new_xy{i} = [new_x{i} new_y{i}];
            new_y{i} = im_height{i} + 1 - new_y{i};
     end   
    if  nar_mode == 0 | i == 2
    xy_len{i} = size(new_x{i},1);    
    [max_x{i},max_x_index] = max(new_x{i});
    max_x_y{i} = new_y{i}(max_x_index);
    [min_x{i},min_x_index] = min(new_x{i});
    min_x_y{i} = new_y{i}(min_x_index);
    [max_y{i},max_y_index] = max(new_y{i});
    max_y_x{i} = new_x{i}(max_y_index);
    [min_y{i},min_y_index] = min(new_y{i});
    min_y_x{i} = new_x{i}(min_y_index);
    end
end
if nar_mode == 0
    figure(kkk)
    kkk = kkk + 1;
    imshow(im{1});
    hold on
    plot(new_x{1}, new_y{1},'+w');
    hold on
end
% for i = 1:3
%     im_temp(new_x{1},new_y{1},i) = im2(new_x{2},new_y{2},i);
% end
if nar_mode == 0
    for i = 1:2
        vertex_dt{i} = delaunayTriangulation(new_x{i},new_y{i});
        new_xy_dtdt{i} = vertex_dt{i}(:,:);        
        dt_len{i} = size(new_xy_dtdt{i},1);
    end
else
    new_xy_dtdt{1} = vertex_dtdt;
    dt_len{1} = size(new_xy_dtdt{1},1);
end
figure(kkk); % figure 3
kkk = kkk + 1;
triplot(new_xy_dtdt{1},new_x{1}, -new_y{1});

figure(kkk) % figure 4
kkk = kkk + 1;
imshow(im{2});
hold on
plot(new_x{2}, new_y{2},'+w');
hold on
% triplot(new_xy_dtdt{1},new_x{2}, new_y{2});

k = 1;
 for x = min_x{1} : max_x{1}%im_width
     for y = min_y{1} : max_y{1} %im_height
% for x = 200
%     for y = 0
        flag = 0;
       for ii = 1:dt_len{1}      
            index1 = new_xy_dtdt{1}(ii,1);
            index2 = new_xy_dtdt{1}(ii,2);
            index3 = new_xy_dtdt{1}(ii,3);
            x1 = new_x{k}(index1);
            x2 = new_x{k}(index2);
            x3 = new_x{k}(index3);
            y1 = new_y{k}(index1);
            y2 = new_y{k}(index2);
            y3 = new_y{k}(index3);
%             x1 = new_x{k}(index1);
%             x2 = new_x{k}(index2);
%             x3 = new_x{k}(index3);
%             y1 = new_y{k}(index1);
%             y2 = new_y{k}(index2);
%             y3 = new_y{k}(index3);
            beta = (y*x3 - x1*y - x3*y1 - x*y3 + x1*y3 + x*y1)/(-x2*y3 + x2*y1 + x1*y3 + x3*y2 - x3*y1 - x1*y2);
            gama = (x*y2 - x*y1 - x1*y2 -x2*y + x2*y1 + x1*y)/(-x2*y3 + x2*y1 + x1*y3 + x3*y2 - x3*y1 - x1*y2);
            alfa = 1 - beta - gama;
            if beta >= 0 & gama >= 0 & (beta + gama) <= 1 
                flag = 1; 
                break;
            end
       end
       if flag == 2
            new_xy_add = [x y;new_xy{k}];
            xy_dist = pdist(new_xy_add);
            xy_dist = xy_dist(1,1:xy_len{k});
            [value index1] = min(xy_dist);
            xy_dist(index1) = sqrt(im_width{1}^2 + im_height{1}^2);
            [value index2] = min(xy_dist);
            xy_dist(index2) = sqrt(im_width{1}^2 + im_height{1}^2);
            [value index3] = min(xy_dist);
       end
       if flag == 1
            xt = alfa * new_x{2}(index1) + beta * new_x{2}(index2) + gama * new_x{2}(index3);
            yt = alfa * new_y{2}(index1) + beta * new_y{2}(index2) + gama * new_y{2}(index3);
            if xt > im_width{2} 
                xt = im_width{2};
            end
            if xt < 1
                xt = 1;
            end
            if yt > im_height{2}
                yt = im_height{2};
            end
            if yt < 1
                yt = 1;
            end
    %         fprintf('x:%d,y:%d,a:%f,b:%f,gama:%f,\nin1:%d,in2:%d,in3:%d,xt:%f,yt:%f\n',x,y,alfa,beta,gama,index1,index2,index3,xt,yt);
            for i = 1:3
%                 im_temp(y,x,i) = im{2}(int32(yt),int32(xt),i); 
                 im_temp(y,x,i) = interp2(im{2}(:,:,i),xt,yt,'bilinear');
            end
       end
       if flag == 0
           if x < min_y_x{1} & y < min_x_y{1}
               x1 = min_x{1};
               x2 = min_x{1};
               x3 = min_y_x{1};
               y1 = min_y{1};
               y2 = min_x_y{1};
               y3 = min_y{1};
               beta = (y*x3 - x1*y - x3*y1 - x*y3 + x1*y3 + x*y1)/(-x2*y3 + x2*y1 + x1*y3 + x3*y2 - x3*y1 - x1*y2);
               gama = (x*y2 - x*y1 - x1*y2 -x2*y + x2*y1 + x1*y)/(-x2*y3 + x2*y1 + x1*y3 + x3*y2 - x3*y1 - x1*y2);
               alfa = 1 - beta - gama;
               xt = alfa * min_x{2} + beta * min_x{2} + gama * min_y_x{2};
               yt = alfa * min_y{2} + beta * min_x_y{2} + gama * min_y{2}; 
           elseif x > min_y_x{1} & y < max_x_y{1}
               x1 = max_x{1};
               x2 = max_x{1};
               x3 = min_y_x{1};
               y1 = min_y{1};
               y2 = max_x_y{1};
               y3 = min_y{1};
               beta = (y*x3 - x1*y - x3*y1 - x*y3 + x1*y3 + x*y1)/(-x2*y3 + x2*y1 + x1*y3 + x3*y2 - x3*y1 - x1*y2);
               gama = (x*y2 - x*y1 - x1*y2 -x2*y + x2*y1 + x1*y)/(-x2*y3 + x2*y1 + x1*y3 + x3*y2 - x3*y1 - x1*y2);
               alfa = 1 - beta - gama;
               xt = alfa * max_x{2} + beta * max_x{2} + gama * min_y_x{2};
               yt = alfa * min_y{2} + beta * max_x_y{2} + gama * min_y{2}; 
           elseif x < max_y_x{1} & y > min_x_y{1}
               x1 = min_x{1};
               x2 = min_x{1};
               x3 = max_y_x{1};
               y1 = max_y{1};
               y2 = min_x_y{1};
               y3 = max_y{1};
               beta = (y*x3 - x1*y - x3*y1 - x*y3 + x1*y3 + x*y1)/(-x2*y3 + x2*y1 + x1*y3 + x3*y2 - x3*y1 - x1*y2);
               gama = (x*y2 - x*y1 - x1*y2 -x2*y + x2*y1 + x1*y)/(-x2*y3 + x2*y1 + x1*y3 + x3*y2 - x3*y1 - x1*y2);
               alfa = 1 - beta - gama;
               xt = alfa * min_x{2} + beta * min_x{2} + gama * max_y_x{2};
               yt = alfa * max_y{2} + beta * min_x_y{2} + gama * max_y{2}; 
           elseif x > max_y_x{1} & y > max_x_y{1}
               x1 = max_x{1};
               x2 = max_x{1};
               x3 = max_y_x{1};
               y1 = max_y{1};
               y2 = max_x_y{1};
               y3 = max_y{1};
               beta = (y*x3 - x1*y - x3*y1 - x*y3 + x1*y3 + x*y1)/(-x2*y3 + x2*y1 + x1*y3 + x3*y2 - x3*y1 - x1*y2);
               gama = (x*y2 - x*y1 - x1*y2 -x2*y + x2*y1 + x1*y)/(-x2*y3 + x2*y1 + x1*y3 + x3*y2 - x3*y1 - x1*y2);
               alfa = 1 - beta - gama;
               xt = alfa * max_x{2} + beta * max_x{2} + gama * max_y_x{2};
               yt = alfa * max_y{2} + beta * max_x_y{2} + gama * max_y{2}; 
           end
           if xt > im_width{2} 
                xt = im_width{2};
            end
            if xt < 1
                xt = 1;
            end
            if yt > im_height{2}
                yt = im_height{2};
            end
            if yt < 1
                yt = 1;
            end
    %         fprintf('x:%d,y:%d,a:%f,b:%f,gama:%f,\nin1:%d,in2:%d,in3:%d,xt:%f,yt:%f\n',x,y,alfa,beta,gama,index1,index2,index3,xt,yt);
            for i = 1:3
%                 im_temp(y,x,i) = im{2}(int32(yt),int32(xt),i); 
                im_temp(y,x,i) = interp2(im{2}(:,:,i),xt,yt,'bilinear');
            end
       end
    end
end
figure(kkk) % figure 5
kkk = kkk + 1;
imshow(uint8(im_temp))
tim = toc;
fprintf('%3.5f\n',tim);
     

% new_xy_add = [x y;new_xy{k}];
% xy_dist = pdist(new_xy_add);
% xy_dist = xy_dist(1,1:xy_len{k});
% [value index1] = min(xy_dist);
% xy_dist(index1) = sqrt(im_width^2 + im_height^2);
% [value index2] = min(xy_dist);
% xy_dist(index2) = sqrt(im_width^2 + im_height^2);
% [value index3] = min(xy_dist);
