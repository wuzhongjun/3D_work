clear;
tmplt_pts=[1 1;1 75; 65 1;65 75]';
ref_point=[15 20; 50 20; 32.5 60];
img_dir = dir('D:\learning_opengl\pose\*.tif');
for i = 1 : length(img_dir)
    img = imread(['D:\learning_opengl\pose\' img_dir(i).name]);
    [xx, yy, ~] = textread(['D:\learning_opengl\pose\' img_dir(i).name(1:end - 4) '_5loc.txt'],'%f %f %f');
    cropimg = affi_change(img,tmplt_pts,ref_point,xx(1),yy(1),xx(2),yy(2),(xx(4)+xx(5))/2,(yy(4)+yy(5))/2);
    imwrite(cropimg,['D:\learning_opengl\pose\cropimg\' img_dir(i).name]);
end
% [imgname,lx,ly,rx,ry]=textread('eyecoords.txt','%s %d %d %d %d');
% tmplt_pts=[1 1;1 75; 65 1;65 75]';
% ref_point=[15 20 50 20];
% for i = 1:length(imgname),
%     img = imread([imgname{i},'.bmp']);
%     cropimg = simi_change(img, tmplt_pts, ref_point,lx(i),ly(i),rx(i),ry(i));
%     imwrite(cropimg/255,['croppedimg\', imgname{i}, '.bmp']);
% end;


% [imgname,lx,ly,rx,ry,~,~,mlx,mly,mrx,mry]=textread('eyecoords.txt','%s %d %d %d %d %d %d %d %d %d %d');
% tmplt_pts=[1 1;1 75; 65 1;65 75]';
% ref_point=[15 20; 50 20; 32.5 60];
% for i = 1:length(imgname),
%     img = imread([imgname{i},'.bmp']);
%     cropimg = affi_change(img, tmplt_pts, ref_point,lx(i)+1,ly(i)+1,rx(i)+1,ry(i)+1,(mlx(i)+mrx(i))/2+1,(mly(i)+mry(i))/2+1);
%     imwrite(cropimg,['croppedimg2\', imgname{i}, '.bmp']);
% end;