function GIC_MPIE_Test_CellSize(feature, region, cellsize)

DIRTest= 'D:\learning_opengl\MPIE\croppedimg2\';
DIRTemplate= 'D:\learning_opengl\MPIE\virtual\';

angle = {'_01_01_080_07';  %-45
'_01_01_130_07';  %-30 
'_01_01_140_07';  %-15
'_01_01_051_07';  %0
'_01_01_050_07';  %15
'_01_01_041_07';  %30
'_01_01_190_07'; }; %45

galleryidx = 1:250; galleryidx(213) = [];

for testcase = 1:7,
    X = [];
    gnd = [];
    TestData = [];
    for i =1:249,
        im = imread(sprintf('%s%03d%s_virtual.bmp',DIRTemplate,i,angle{testcase}));
        lbp = IMG2LBP(im, 5, 5);
        X = [X lbp];
        gnd = [gnd i];
        
        im = imread(sprintf('%s%03d%s.bmp',DIRTest,galleryidx(i),angle{testcase}));
        lbp = IMG2LBP(im, 5, 5);
        TestData = [TestData lbp];
    end;
    
    T = pinv(X);
    
    Res = T*TestData;
   [~, idx] = max(Res);
   accuracy = length(find((idx - gnd)==0))/length(gnd);
   fprintf('%.2f%% ',100*accuracy);
end;


