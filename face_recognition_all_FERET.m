clear;
img_dir = dir('D:\learning_opengl\pose\cropimg\*.tif');
img_dir2 = dir('D:\learning_opengl\pose_frontal\*.tif');
for i = 1 : length(img_dir2)
    img_str{i} = img_dir2(i).name;
end
new_num = 200;
estimate = 0;
% whole_ans_FERET_noestimate = zeros(3,int32(size(img_dir,1)));
if estimate == 0
    load('whole_ans_FERET_noestimate.mat','whole_ans_FERET_noestimate');
else
    load('whole_ans_FERET.mat','whole_ans_FERET');
end
aaa = 1;
% for i = 17 : length(img_dir)
for i = ((aaa - 1) * 9 + 1) : (aaa * 9)
    fprintf('i=%d\n',i);
    std_num = floor((i - 1)/9) + 1;
    [dist_index,P_angle] = face_recognition_FERET(['D:\learning_opengl\pose\cropimg\' img_dir(i).name],img_str,std_num,estimate);
if estimate == 0
    whole_ans_FERET_noestimate(1,i) = std_num;    
    whole_ans_FERET_noestimate(2,i) = dist_index;
    whole_ans_FERET_noestimate(3,i) = int32(P_angle);
    save('whole_ans_FERET_noestimate.mat','whole_ans_FERET_noestimate');
else
    whole_ans_FERET(1,i) = std_num;    
    whole_ans_FERET(2,i) = dist_index;
    whole_ans_FERET(3,i) = int32(P_angle);
    save('whole_ans_FERET.mat','whole_ans_FERET');
end
    pause;
end
rec_rate = zeros(1,9);
rec_rate2 = zeros(1,9);
if estimate == 0
    for i = 1:9
        rec_rate(i) = size(find(whole_ans_FERET_noestimate(1,[i:9:1800])==whole_ans_FERET_noestimate(2,[i:9:1800])),2)/200;
    end
else
    for i = 1:9
        rec_rate(i) = size(find(whole_ans_FERET(1,[i:9:1800])==whole_ans_FERET(2,[i:9:1800])),2)/200;
    end
end
rec_rate2(1)=rec_rate(9);
rec_rate2(2)=rec_rate(8);
rec_rate2(3)=rec_rate(7);
rec_rate2(4)=rec_rate(6);
rec_rate2(5)=rec_rate(1);
rec_rate2(6)=rec_rate(5);
rec_rate2(7)=rec_rate(4);
rec_rate2(8)=rec_rate(3);
rec_rate2(9)=rec_rate(2);