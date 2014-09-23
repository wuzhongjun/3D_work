function [ output_args ] = GIC_FERET_Profile_Frontal_Test_CellSize( input_args )
    DIRTest= 'D:\learning_opengl\BaselFace\02_FERET_profile_frontal_resize\';
    DIRTemplate= 'D:\learning_opengl\BaselFace\02_FERET_original_frontal_resize\';

    angle = {'bi';  %-37.9
    'bh';  %-26.5 
    'bg';  %-16.3
    'bf';  %-7.1
    'ba';  %1.1
    'be';  %11.2
    'bd';  %18.9
    'bc';  %27.4    
    'bb'}; %38.9
    
    img_dir2 = dir('D:\learning_opengl\pose_frontal\*.tif');
    for i = 1 : length(img_dir2)
        img_str{i} = img_dir2(i).name;
    end
    galleryidx = 1:200; 
    
    X = [];
    gnd = [];
    for i = 1 : 200
        im = imread(sprintf('%s%s%s%s_2_frontal.bmp',DIRTemplate,img_str{i}(1:5),angle{5},img_str{i}(8:end - 4)));
        lbp = IMG2LBP(im, 4, 4);
        X = [X lbp];
        gnd = [gnd i];
    end
    load('idx.mat','idx');
    for testcase = 1:9,        
        TestData = [];
        for i =1:200,
            im = imread(sprintf('%s%s%s%s_2_frontal.bmp',DIRTest,img_str{i}(1:5),angle{testcase},img_str{i}(8:end - 4)));
            lbp = IMG2LBP(im, 4, 4);
            TestData = [TestData lbp];
%             if idx(i) ~= i
%                 im_2 = imread(sprintf('%s%s%s%s_2_resize.bmp',DIRTemplate,img_str{idx(i)}(1:5),angle{5},img_str{i}(8:end - 4)));
%                 subplot(1,3,1);
%                 imshow( im);
%                 subplot(1,3,2);
%                 imshow( im_2);
%                 im_3 = imread(sprintf('%s%s%s%s_2_resize.bmp',DIRTemplate,img_str{i}(1:5),angle{5},img_str{i}(8:end - 4)));
%                 subplot(1,3,3);
%                 imshow( im_3);
%                 pause;
%             end 
        end;

        T = pinv(X);

        Res = T*TestData;
       [~, idx] = max(Res);
       
       accuracy = length(find((idx - gnd)==0))/length(gnd);
       fprintf('%.2f%% ',100*accuracy);
    end
    
end


