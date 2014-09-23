function [ output_args ] = GIC_FERET_Half_Profile_Frontal_Test_CellSize( input_args )
    DIRTest= 'D:\learning_opengl\BaselFace\02_FERET_half_profile_frontal_resize\';
    DIRTemplate= 'D:\learning_opengl\BaselFace\02_FERET_half_original_frontal_resize\';

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
    num = 2;
    X = [];
    gnd = [];
    for i = 1 : 200
        for cnt = 1 : 2
            im = imread(sprintf('%s%s%s%s_2_frontal_%s.bmp',DIRTemplate,img_str{i}(1:5),angle{5},img_str{i}(8:end - 4),num2str(cnt)));
            lbp = IMG2LBP(im, 3, 3);
            X = [X lbp];            
        end
        gnd = [gnd i];
    end
    
    for testcase = 1 : 9        
        TestData = [];        
   
        for i =1:200,
            im = imread(sprintf('%s%s%s%s_2_frontal.bmp',DIRTest,img_str{i}(1:5),angle{testcase},img_str{i}(8:end - 4)));
            lbp = IMG2LBP(im, 3, 3);
            TestData = [TestData lbp];
        end;

        T = pinv(X);

        Res = T*TestData;
%         height = size( Res, 1);
%         width = size( Res, 2);
%         Res = reshape( Res, [num height*width/num]);
%         Res = sum( Res);
%         Res = reshape( Res, [height/num width]);
       [~, idx] = max(Res);
       idx = floor((idx - 1) / 2) + 1;
       accuracy = length(find((idx - gnd)==0))/length(gnd);
       fprintf('%.2f%% ',100*accuracy);
    end
end


