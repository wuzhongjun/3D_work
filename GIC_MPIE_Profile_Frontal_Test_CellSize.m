function [ output_args ] = GIC_MPIE_Profile_Frontal_Test_CellSize( input_args )
    DIRTest= 'D:\learning_opengl\BaselFace\02_profile_frontal_resize\';
    DIRTemplate= 'D:\learning_opengl\BaselFace\02_profile_frontal_resize\';

    angle = {'_01_01_080_07';  %-45
    '_01_01_130_07';  %-30 
    '_01_01_140_07';  %-15
    '_01_01_051_07';  %0
    '_01_01_050_07';  %15
    '_01_01_041_07';  %30
    '_01_01_190_07'; }; %45

    galleryidx = 1:250; galleryidx(213) = [];
    
    X = [];
    gnd = [];
    for i = 1 : 249
        im = imread(sprintf('%s%03d%s_2_resize.bmp',DIRTemplate,galleryidx(i),angle{4}));
        lbp = IMG2LBP(im, 5, 5);
        X = [X lbp];
        gnd = [gnd i];
    end
    
    for testcase = 1:7,        
        TestData = [];
        for i =1:249,
            im = imread(sprintf('%s%03d%s_2_resize.bmp',DIRTest,galleryidx(i),angle{testcase}));
            lbp = IMG2LBP(im, 5, 5);
            TestData = [TestData lbp];
        end;

        T = pinv(X);

        Res = T*TestData;
       [~, idx] = max(Res);
       accuracy = length(find((idx - gnd)==0))/length(gnd);
       fprintf('%.2f%% ',100*accuracy);
    end
end


