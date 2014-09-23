des_dir = 'D:\learning_opengl\pose_frontal\';
or_dir = 'D:\learning_opengl\pose\';
pic_dir1 = dir(['D:\learning_opengl\pose\' '*a*.tif']);
pic_dir2 = dir(['D:\learning_opengl\pose\' '*k*.tif']);
for i = 1:length(pic_dir1)
    copyfile(strcat(or_dir,pic_dir1(i).name),des_dir);
end
% for i = 1:length(pic_dir2)
%     movefile(strcat(or_dir,pic_dir2(i).name),des_dir);
% end

% or_dir = 'D:\learning_opengl\MPIE\';
% pic_dir = dir(strcat(or_dir,'*_01_01_051_07.bmp'));
% for i = 1:length(pic_dir)
%     copyfile(strcat(or_dir,pic_dir(i).name),'D:\learning_opengl\BaselFace\02_frontal_face\');
% end
% or_dir = 'D:\learning_opengl\BaselFace\02_projected_jpg\';
% p_dir = dir(strcat(or_dir,'*p.jpg'));
% for i = 1:length(p_dir)
%     delete(strcat(or_dir,p_dir(i).name));
% end
% %%
% des_dir = 'D:\learning_opengl\BaselFace\02_test_all\';
% or_dir = 'D:\learning_opengl\BaselFace\02_test_';
% cam = {'frontal','l_15','l_30','l_45','l_60','l_75','l_90','r_15','r_30','r_45','r_60','r_75','r_90'};
% for i = 214:250
%     tmp_str = num2str(i,'%03d'); % 001
%      mkdir(des_dir,tmp_str);% create a new directory,'D:\learning_opengl\BaselFace\02_test_all\001'
%     dir1 = strcat(des_dir,tmp_str); %'D:\learning_opengl\BaselFace\02_test_all\001'
%     for j = 1:size(cam,2)
%         n_dir = strcat(or_dir,cam{j},'\');%'D:\learning_opengl\BaselFace\02_test_frontal\'
%         nn_dir = dir(strcat(n_dir,tmp_str,'*'));
%         copyfile(strcat(n_dir,nn_dir(1).name),dir1);
% %         fprintf(nn_dir(1).name);
% %         fprintf('\n');
%     end
% end

% %%
% des_dir = 'D:\learning_opengl\BaselFace\02_test_l_60\';%
% for i = 1:212
%    or_dir1 = 'D:\learning_opengl\session01\multiview\';
%    or_dir2 = '\01\09_0\';%
%    or_dir3 = '_01_01_090_07.png';%
%    tmp_str = num2str(i,'%03d');
%    or_dir = strcat(or_dir1,tmp_str,or_dir2,tmp_str,or_dir3);
%    copyfile(or_dir,strcat(des_dir,tmp_str,'_test_l_60.png'));
% end
% 
% des_dir = 'D:\learning_opengl\BaselFace\02_test_l_60\';%
% for i = 214:250
%    or_dir1 = 'D:\learning_opengl\session01\multiview\';
%    or_dir2 = '\01\09_0\';%
%    or_dir3 = '_01_01_090_07.png';%
%    tmp_str = num2str(i,'%03d');
%    or_dir = strcat(or_dir1,tmp_str,or_dir2,tmp_str,or_dir3);
%    copyfile(or_dir,strcat(des_dir,tmp_str,'_test_l_60.png'));
% end
% %%
% des_dir = 'D:\learning_opengl\BaselFace\02_test_l_75\';%
% for i = 1:212
%    or_dir1 = 'D:\learning_opengl\session01\multiview\';
%    or_dir2 = '\01\12_0\';%
%    or_dir3 = '_01_01_120_07.png';%
%    tmp_str = num2str(i,'%03d');
%    or_dir = strcat(or_dir1,tmp_str,or_dir2,tmp_str,or_dir3);
%    copyfile(or_dir,strcat(des_dir,tmp_str,'_test_l_75.png'));
% end
% 
% des_dir = 'D:\learning_opengl\BaselFace\02_test_l_75\';%
% for i = 214:250
%    or_dir1 = 'D:\learning_opengl\session01\multiview\';
%    or_dir2 = '\01\12_0\';%
%    or_dir3 = '_01_01_120_07.png';%
%    tmp_str = num2str(i,'%03d');
%    or_dir = strcat(or_dir1,tmp_str,or_dir2,tmp_str,or_dir3);
%    copyfile(or_dir,strcat(des_dir,tmp_str,'_test_l_75.png'));
% end
% %%
% des_dir = 'D:\learning_opengl\BaselFace\02_test_l_90\';%
% for i = 1:212
%    or_dir1 = 'D:\learning_opengl\session01\multiview\';
%    or_dir2 = '\01\11_0\';%
%    or_dir3 = '_01_01_110_07.png';%
%    tmp_str = num2str(i,'%03d');
%    or_dir = strcat(or_dir1,tmp_str,or_dir2,tmp_str,or_dir3);
%    copyfile(or_dir,strcat(des_dir,tmp_str,'_test_l_90.png'));
% end
% 
% des_dir = 'D:\learning_opengl\BaselFace\02_test_l_90\';%
% for i = 214:250
%    or_dir1 = 'D:\learning_opengl\session01\multiview\';
%    or_dir2 = '\01\11_0\';%
%    or_dir3 = '_01_01_110_07.png';%
%    tmp_str = num2str(i,'%03d');
%    or_dir = strcat(or_dir1,tmp_str,or_dir2,tmp_str,or_dir3);
%    copyfile(or_dir,strcat(des_dir,tmp_str,'_test_l_90.png'));
% end
% %%
% des_dir = 'D:\learning_opengl\BaselFace\02_test_r_15\';%
% for i = 1:212
%    or_dir1 = 'D:\learning_opengl\session01\multiview\';
%    or_dir2 = '\01\05_0\';%
%    or_dir3 = '_01_01_050_07.png';%
%    tmp_str = num2str(i,'%03d');
%    or_dir = strcat(or_dir1,tmp_str,or_dir2,tmp_str,or_dir3);
%    copyfile(or_dir,strcat(des_dir,tmp_str,'_test_r_15.png'));
% end
% 
% des_dir = 'D:\learning_opengl\BaselFace\02_test_r_15\';%
% for i = 214:250
%    or_dir1 = 'D:\learning_opengl\session01\multiview\';
%    or_dir2 = '\01\05_0\';%
%    or_dir3 = '_01_01_050_07.png';%
%    tmp_str = num2str(i,'%03d');
%    or_dir = strcat(or_dir1,tmp_str,or_dir2,tmp_str,or_dir3);
%    copyfile(or_dir,strcat(des_dir,tmp_str,'_test_r_15.png'));
% end
% %%
% des_dir = 'D:\learning_opengl\BaselFace\02_test_r_30\';%
% for i = 1:212
%    or_dir1 = 'D:\learning_opengl\session01\multiview\';
%    or_dir2 = '\01\04_1\';%
%    or_dir3 = '_01_01_041_07.png';%
%    tmp_str = num2str(i,'%03d');
%    or_dir = strcat(or_dir1,tmp_str,or_dir2,tmp_str,or_dir3);
%    copyfile(or_dir,strcat(des_dir,tmp_str,'_test_r_30.png'));
% end
% 
% des_dir = 'D:\learning_opengl\BaselFace\02_test_r_30\';%
% for i = 214:250
%    or_dir1 = 'D:\learning_opengl\session01\multiview\';
%    or_dir2 = '\01\04_1\';%
%    or_dir3 = '_01_01_041_07.png';%
%    tmp_str = num2str(i,'%03d');
%    or_dir = strcat(or_dir1,tmp_str,or_dir2,tmp_str,or_dir3);
%    copyfile(or_dir,strcat(des_dir,tmp_str,'_test_r_30.png'));
% end
% 
% %%
% des_dir = 'D:\learning_opengl\BaselFace\02_test_r_45\';%
% for i = 1:212
%    or_dir1 = 'D:\learning_opengl\session01\multiview\';
%    or_dir2 = '\01\19_0\';%
%    or_dir3 = '_01_01_190_07.png';%
%    tmp_str = num2str(i,'%03d');
%    or_dir = strcat(or_dir1,tmp_str,or_dir2,tmp_str,or_dir3);
%    copyfile(or_dir,strcat(des_dir,tmp_str,'_test_r_45.png'));
% end
% 
% des_dir = 'D:\learning_opengl\BaselFace\02_test_r_45\';%
% for i = 214:250
%    or_dir1 = 'D:\learning_opengl\session01\multiview\';
%    or_dir2 = '\01\19_0\';%
%    or_dir3 = '_01_01_190_07.png';%
%    tmp_str = num2str(i,'%03d');
%    or_dir = strcat(or_dir1,tmp_str,or_dir2,tmp_str,or_dir3);
%    copyfile(or_dir,strcat(des_dir,tmp_str,'_test_r_45.png'));
% end
% 
% %%
% des_dir = 'D:\learning_opengl\BaselFace\02_test_r_60\';%
% for i = 1:212
%    or_dir1 = 'D:\learning_opengl\session01\multiview\';
%    or_dir2 = '\01\20_0\';%
%    or_dir3 = '_01_01_200_07.png';%
%    tmp_str = num2str(i,'%03d');
%    or_dir = strcat(or_dir1,tmp_str,or_dir2,tmp_str,or_dir3);
%    copyfile(or_dir,strcat(des_dir,tmp_str,'_test_r_60.png'));
% end
% 
% des_dir = 'D:\learning_opengl\BaselFace\02_test_r_60\';%
% for i = 214:250
%    or_dir1 = 'D:\learning_opengl\session01\multiview\';
%    or_dir2 = '\01\20_0\';%
%    or_dir3 = '_01_01_200_07.png';%
%    tmp_str = num2str(i,'%03d');
%    or_dir = strcat(or_dir1,tmp_str,or_dir2,tmp_str,or_dir3);
%    copyfile(or_dir,strcat(des_dir,tmp_str,'_test_r_60.png'));
% end
% 
% %%
% des_dir = 'D:\learning_opengl\BaselFace\02_test_r_75\';%
% for i = 1:212
%    or_dir1 = 'D:\learning_opengl\session01\multiview\';
%    or_dir2 = '\01\01_0\';%
%    or_dir3 = '_01_01_010_07.png';%
%    tmp_str = num2str(i,'%03d');
%    or_dir = strcat(or_dir1,tmp_str,or_dir2,tmp_str,or_dir3);
%    copyfile(or_dir,strcat(des_dir,tmp_str,'_test_r_75.png'));
% end
% 
% des_dir = 'D:\learning_opengl\BaselFace\02_test_r_75\';%
% for i = 214:250
%    or_dir1 = 'D:\learning_opengl\session01\multiview\';
%    or_dir2 = '\01\01_0\';%
%    or_dir3 = '_01_01_010_07.png';%
%    tmp_str = num2str(i,'%03d');
%    or_dir = strcat(or_dir1,tmp_str,or_dir2,tmp_str,or_dir3);
%    copyfile(or_dir,strcat(des_dir,tmp_str,'_test_r_75.png'));
% end
% 
% %%
% des_dir = 'D:\learning_opengl\BaselFace\02_test_r_90\';%
% for i = 1:212
%    or_dir1 = 'D:\learning_opengl\session01\multiview\';
%    or_dir2 = '\01\24_0\';%
%    or_dir3 = '_01_01_240_07.png';%
%    tmp_str = num2str(i,'%03d');
%    or_dir = strcat(or_dir1,tmp_str,or_dir2,tmp_str,or_dir3);
%    copyfile(or_dir,strcat(des_dir,tmp_str,'_test_r_90.png'));
% end
% 
% des_dir = 'D:\learning_opengl\BaselFace\02_test_r_90\';%
% for i = 214:250
%    or_dir1 = 'D:\learning_opengl\session01\multiview\';
%    or_dir2 = '\01\24_0\';%
%    or_dir3 = '_01_01_240_07.png';%
%    tmp_str = num2str(i,'%03d');
%    or_dir = strcat(or_dir1,tmp_str,or_dir2,tmp_str,or_dir3);
%    copyfile(or_dir,strcat(des_dir,tmp_str,'_test_r_90.png'));
% end