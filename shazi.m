clear;
img_dir = dir('D:\learning_opengl\BaselFace\02_FERET_half_profile_frontal\*.bmp');
for i = 1:length( img_dir)
    im = imread( ['D:\learning_opengl\BaselFace\02_FERET_half_profile_frontal\' img_dir(i).name]);
%     imshow(im);
   
%     im2 = imcrop( im, [17 5 67 81]);
%     im2 = imcrop( im, [85 26 334 399]);

    im2 = im;
    im2 = imresize( im2, 0.3, 'bilinear');
%         imshow( im2);
%     im2 = imcrop( im2, [26 8 99 119]);
    imwrite( im2, ['D:\learning_opengl\BaselFace\02_FERET_half_profile_frontal_resize\' img_dir(i).name(1:end-4) '.bmp']);
%      pause;
end
% clear;
% load('../02_save_mat/gem_vertex.mat');
% outDir4 = 'D:\learning_opengl\BaselFace\02_generated_ply4\';
% img_str = 'gem_vertex';
% z_scale = [1.1 1 0.9 0.8 0.7 0.6];
% tmp_ge_z = vertex(3,:);
% z1 = tmp_ge_z(16172);
% ge_tex = tex_vertex;
% ge([1 2],:) = vertex([1 2],:);
% for cnt = 1:6
%     ge(3,:) = (tmp_ge_z - z1)*z_scale(cnt) + z1;
%     tmptmp_str = strcat(img_str,'_',num2str(cnt),'.ply');
%     plywrite(fullfile(outDir4,tmptmp_str), ge, ge_tex, vertex_dtdt); 
%     tmptmp_str = strcat('D:\learning_opengl\BaselFace\02_save_mat4\',img_str,'_',num2str(cnt),'.mat');
%     tmp_ge = ge;
%     tmp_ge_tex = ge_tex;
% %     tmp_new_xy = new_xy;
%     save(tmptmp_str,'tmp_ge','tmp_ge_tex');
% end



% clear;
% m=100;
% n=4000;
% c=50;
% aaa = m*n*c;
% l=10;
% y1=zeros(m,n,c);
% Y=rand(m,n,c);
% I=rand(m,n,c);
% u=rand(m,l)*0.001;
% s=rand(n,l)*0.001;
% t=rand(c,l)*0.001;
% cnt_p = 0;
% cnt_p2 = 0;
% % y2=zeros(aaa,l);
% % u_m_ln = repmat(u,[1,n]);
% % u_ln_m = reshape(u_m_ln',[l,m*n]);
% % u_mn_l = u_ln_m';
% tic;
% % t_nc_l = reshape(repmat(t,[1,n])',[l,c*n])';
% % s_nc_l = repmat(s,[c 1]);
% % ts_nc_l = t_nc_l .* s_nc_l;
% % ts_mnc_l = reshape(repmat(ts_nc_l,[1,m])',[l,m*n*c])';
% % u_mnc_l = repmat(u,[n*c 1]);
% % ust_mnc_l_sum = sum(u_mnc_l .* ts_mnc_l,2);
% % ust_mnc_l_sum = reshape(ust_mnc_l_sum,[m n c]);
% tim = toc;
% % y2 = reshape(sum(repmat(u,[n*c 1]).*reshape(repmat(reshape(repmat(t,[1,n])',[l,c*n])'.*repmat(s,[c 1]),[1,m])',[l,m*n*c])',2),[m n c]);
% % cnt_p2 = sum(sum(sum((Y-y2).*(Y-y2))));
% % y_arvg2 = sum(I.*Y,3)./sum(I,3);
% fprintf('cost time:%f  \n',tim);
% tic;
% % for i=1:m
% %         for j=1:n
% %             for k=1:c
% %                 %if I(i,j,k)==1
% %                 y1(i,j,k)=sum(u(i,:).*s(j,:).*t(k,:));
% %                  cnt_p=cnt_p+(Y(i,j,k)-y1(i,j,k))*(Y(i,j,k)-y1(i,j,k));
% %                 %end
% %             end
% %         end
% % end
% %  for i=1:m
% %         for j=1:n
% %             y_arvg(i,j)=sum( I(i,j,1:c).*Y(i,j,1:c) )/sum(I(i,j,:));
% %         end
% %     end
% tim = toc;
% fprintf('cost time:%f  \n',tim);
% 
% 
% 
% % a = zeros(3,4,5);
% % for i = 1:3
% %     for j = 1:4
% %         for k = 1:5
% %             a(i,j,k) = i + j + k;
% %         end
% %     end
% % end
% % 
% % % sum(a(1,1,:))
% % size(a,1)
% % flag = 0;
% % x = 1;
% % y = 1;
% % x1 = 0;
% % y1 = 0;
% % x2 = 4;
% % y2 = 0;
% % x3 = 4;
% % y3 = 3;
% % beta = (y*x3 - x1*y - x3*y1 - x*y3 + x1*y3 + x*y1)/(-x2*y3 + x2*y1 + x1*y3 + x3*y2 - x3*y1 - x1*y2);
% % gama = (x*y2 - x*y1 - x1*y2 -x2*y + x2*y1 + x1*y)/(-x2*y3 + x2*y1 + x1*y3 + x3*y2 - x3*y1 - x1*y2);
% % alfa = 1 - beta - gama;
% % if beta >= 0 & gama >= 0 & (beta + gama) <= 1 
% %     flag = 1;
% % end
% % alfa 
% % beta
% % gama
% % flag