function [ pa_img ] = piece_affine( nine_dtdt,nine_xy,gen_img,gen_xy )
%PIECE_AFFINE Summary of this function goes here
%   Detailed explanation goes here
    im_width = max(nine_xy(:,1));
    im_height = max(nine_xy(:,2));
    nine_x = nine_xy(:,1);
    nine_y = nine_xy(:,2);
    gen_x = double(gen_xy(:,1));
    gen_y = double(gen_xy(:,2));
    gen_width = max(gen_x);
    gen_height = max(gen_y);    
    im_temp = zeros(im_height,im_width);
    for x = 1:im_width
        for y = 1:im_height
            flag = 0;
            for ii = 1:size(nine_dtdt,1)
                index1 = nine_dtdt(ii,1);
                index2 = nine_dtdt(ii,2);
                index3 = nine_dtdt(ii,3);
                x1 = nine_x(index1);
                x2 = nine_x(index2);
                x3 = nine_x(index3);
                y1 = nine_y(index1);
                y2 = nine_y(index2);
                y3 = nine_y(index3);
                beta = (y*x3 - x1*y - x3*y1 - x*y3 + x1*y3 + x*y1)/(-x2*y3 + x2*y1 + x1*y3 + x3*y2 - x3*y1 - x1*y2);
                gama = (x*y2 - x*y1 - x1*y2 -x2*y + x2*y1 + x1*y)/(-x2*y3 + x2*y1 + x1*y3 + x3*y2 - x3*y1 - x1*y2);
                alfa = 1 - beta - gama;
                if beta >= 0 & gama >= 0 & (beta + gama) <= 1 
                    flag = 1; 
                    break;
                end
            end
            if flag == 1
                xt = alfa * gen_x(index1) + beta * gen_x(index2) + gama * gen_x(index3);
                yt = alfa * gen_y(index1) + beta * gen_y(index2) + gama * gen_y(index3);
                if xt > gen_width 
                    xt = gen_width;
                end
                if xt < 1
                    xt = 1;
                end
                if yt > gen_height
                    yt = gen_height;
                end
                if yt < 1
                    yt = 1;
                end
        %         fprintf('x:%d,y:%d,a:%f,b:%f,gama:%f,\nin1:%d,in2:%d,in3:%d,xt:%f,yt:%f\n',x,y,alfa,beta,gama,index1,index2,index3,xt,yt);
%                 im_temp(y,x) = gen_img(int32(yt),int32(xt)); 
% xt 
% yt
                im_temp(y,x) = interp2(gen_img, double(xt), double(yt), 'bilinear');

           end
        end
    end
    pa_img = im_temp;
end

