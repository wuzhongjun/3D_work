clear;
img_dir = dir('D:\learning_opengl\MPIE\croppedimg2\*.bmp');
new_num = 250;
for i = 1 : new_num
     if i ~= 213
     img_str{i} = strcat(num2str(i,'%03d'),'_01_01_051_07');%to add more frontal face,change this cell
     end
end
 for i = 1 : new_num
     if i ~= 213
     img_str_all{i} = strcat(num2str(i,'%03d'),'_01_01_051_07.bmp');%to add more frontal face,change this cell
     end
 end
 whole_ans_raw = zeros(3,int32(size(img_dir,1)));
 for i = 1 :size(img_dir,1)
% for i = 3:7:size(img_dir,1) 
    fprintf('i=%d\n',i);
    std_num = str2num(img_dir(i).name(1:3));
    [dist_index,P_angle] = face_recognition_raw(strcat('D:\learning_opengl\MPIE\croppedimg2\',img_dir(i).name),img_str ,std_num,i);
%      pause; 
    whole_ans_raw(1,i) = std_num;    
    whole_ans_raw(2,i) = dist_index;
    whole_ans_raw(3,i) = int32(P_angle);
 end
rec_rate = zeros(1,7);
rec_rate2 = zeros(1,7);
for i = 1:7
    rec_rate(i) = size(find(whole_ans_raw(1,[i:7:1743])==whole_ans_raw(2,[i:7:1743])),2)/249;
end
rec_rate2(1)=rec_rate(4);
rec_rate2(2)=rec_rate(5);
rec_rate2(3)=rec_rate(6);
rec_rate2(4)=rec_rate(3);
rec_rate2(5)=rec_rate(2);
rec_rate2(6)=rec_rate(1);
rec_rate2(7)=rec_rate(7);