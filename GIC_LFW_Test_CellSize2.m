function [ output_args ] = GIC_LFW_Test_CellSize2( input_args )
%GIC_LFW_TEST_CELLSIZE Summary of this function goes here
%   Detailed explanation goes here
    DIRTest = 'D:\learning_opengl\BaselFace\02_LFW_profile_frontal_resize\';
    fid = fopen( '..\imagelist_lfw.txt', 'r');
    num = fscanf( fid, '%d', [1 1]);
    TestData = [];
    for i = 0 : num - 1
        fprintf( 'i = %d\n', i);
        index = fscanf( fid, '%d', [1 1]);
        name = fscanf( fid, '%s', [1 1]);
        xiexian = find( name == '\');
        im = imread(sprintf('%s%s_2_resize.bmp', DIRTest, name(xiexian+1:end-4)));
        lbp = IMG2LBP(im, 6, 5);
        TestData = [TestData lbp];
    end
    TestData = TestData';
    save( 'sym_TestData_151_151-6_5.mat', 'TestData','-v7.3');
    fclose( fid);
end

