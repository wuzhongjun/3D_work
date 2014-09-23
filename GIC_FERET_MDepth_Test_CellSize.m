function GIC_FERET_MDepth_Test_CellSize(feature, region, cellsize)

DIRTest= 'D:\learning_opengl\pose\cropimg\';
DIRTemplate= 'D:\learning_opengl\pose\virtual_m_depth_noestimate\';
img_dir2 = dir('D:\learning_opengl\pose_frontal\*.tif');
for i = 1 : length(img_dir2)
    img_str{i} = img_dir2(i).name;
end

angle = {'bi';  %-37.9
'bh';  %-26.5 
'bg';  %-16.3
'bf';  %-7.1
'ba';  %1.1
'be';  %11.2
'bd';  %18.9
'bc';  %27.4    
'bb'}; %38.9

galleryidx = 1:200; 
% img_str(35) = [];
% img_str(4) = [];
load( 'idx.mat','idx');
num = 7;
for testcase = 1:9,
    X = [];
    gnd = [];
    TestData = [];
    for i =1:200,
        for cnt = 0 : 6
            im_3 = imread(sprintf('%s%s%s%s_virtual_%s.tif',DIRTemplate,img_str{i}(1:5),angle{testcase},img_str{i}(8:end - 4),num2str(cnt)));
            lbp = IMG2LBP(im_3, 5, 5);
            X = [X lbp];
        end       
        gnd = [gnd i];
        im_1 = imread(sprintf('%s%s%s%s.tif',DIRTest,img_str{i}(1:5),angle{testcase},img_str{i}(8:end - 4)));
        lbp = IMG2LBP(im_1, 5, 5);
        TestData = [TestData lbp];
%         if idx(i) ~= i
%             im_2 = imread(sprintf('%s%s%s%s_virtual_%s.tif',DIRTemplate,img_str{idx(i)}(1:5),angle{testcase},img_str{i}(8:end - 4),num2str(cnt)));
%             subplot(1,3,1);
%             imshow( im_1);
%             subplot(1,3,2);
%             imshow( im_2);
%             subplot(1,3,3);
%             imshow( im_3);
%             pause;
%         end 
    end;
    
    T = pinv(X);
    
    Res = T*TestData;
    height = size( Res, 1);
    width = size( Res, 2);
    Res = reshape( Res, [num height*width/num]);
    Res = sum( Res);
    Res = reshape( Res, [height/num width]);
   [~, idx] = max(Res);
%    idx = floor((idx - 1) / 6) + 1;
   accuracy = length(find((idx - gnd)==0))/length(gnd);
   fprintf('%.2f%% ',100*accuracy);
end;




