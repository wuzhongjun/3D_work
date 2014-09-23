clear;
img_dir = dir('D:\learning_opengl\pose\cropimg\*.tif');
img_dir2 = dir('D:\learning_opengl\pose_frontal\*.tif');
new_num = 200;
for i = 1 : length(img_dir2)
    img_str{i} = img_dir2(i).name;
end
% whole_ans_m_FERET = zeros(3,int32(size(img_dir,1)));
load('whole_ans_m_FERET.mat','whole_ans_m_FERET');
num = 1;
estimate = 0;
for i = 1 : 9
% for i = 4 : length( img_dir)
        fprintf('i=%d\n',i);
        std_num = floor((i - 1)/9) + 1;
        [dist_index,P_angle] = face_recognition_m_depth_FERET(['D:\learning_opengl\pose\cropimg\' img_dir(i).name],img_str ,std_num, estimate, i);
    %     pause; 
%         whole_ans_m_FERET(1,i) = std_num;    
%         whole_ans_m_FERET(2,i) = dist_index;
%         whole_ans_m_FERET(3,i) = int32(P_angle);
%         save('whole_ans_m_FERET.mat','whole_ans_m_FERET');
%         pause;
end
% load('whole_ans_v0511.mat','whole_ans_v2');
rec_rate = zeros(1,7);
rec_rate2 = zeros(1,7);
for i = 1:7
    rec_rate(i) = size(find(whole_ans_m_FERET(1,[i:9:1800])==whole_ans_m_FERET(2,[i:9:1800])),2)/200;
end
rec_rate2(1)=rec_rate(4);
rec_rate2(2)=rec_rate(5);
rec_rate2(3)=rec_rate(6);
rec_rate2(4)=rec_rate(3);
rec_rate2(5)=rec_rate(2);
rec_rate2(6)=rec_rate(1);
rec_rate2(7)=rec_rate(7);

