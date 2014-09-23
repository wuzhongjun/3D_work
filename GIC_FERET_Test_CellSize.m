function GIC_FERET_Test_CellSize(feature, region, cellsize)

DIRTest= 'D:\learning_opengl\pose\cropimg\';
DIRTemplate= 'D:\learning_opengl\pose\virtual\';
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

for testcase = 1:9,
    X = [];
    gnd = [];
    TestData = [];
    for i =1:200,
        im = imread(sprintf('%s%s%s%s_virtual.tif',DIRTemplate,img_str{i}(1:5),angle{testcase},img_str{i}(8:end - 4)));
        lbp = IMG2LBP(im, 5, 5);
        X = [X lbp];
        gnd = [gnd i];
        
        im = imread(sprintf('%s%s%s%s.tif',DIRTest,img_str{i}(1:5),angle{testcase},img_str{i}(8:end - 4)));
        lbp = IMG2LBP(im, 5, 5);
        TestData = [TestData lbp];
    end;
    
    T = pinv(X);
    
    Res = T*TestData;
   [~, idx] = max(Res);
   accuracy = length(find((idx - gnd)==0))/length(gnd);
   fprintf('%.2f%% ',100*accuracy);
end;




