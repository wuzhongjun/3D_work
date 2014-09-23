clear;
img_dir = dir('D:\learning_opengl\MPIE\*.bmp');
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
acc = zeros(1,7);
acc_wrong = zeros(1,7);
% whole_ans = zeros(3,int32(size(img_dir,1)));
load('whole_ans.mat','whole_ans');
num = 100;
if num > 213
    num = num - 1;
end
% for i = ((num-1)*7+1):(num*7)
for i = 1:200
    fprintf('i=%d\n',i);
    std_num = str2num(img_dir(i).name(1:3));
    [dist_index,P_angle] = face_recognition(strcat('D:\learning_opengl\MPIE\',img_dir(i).name),img_str ,std_num,i);
%     pause; 
    if dist_index == std_num
        fprintf('true\n\n');
        if  img_dir(i).name(11:13) == '080'
           acc(1) = acc(1) + 1;
        end   
        if  img_dir(i).name(11:13) == '130'
           acc(2) = acc(2) + 1;
        end
        if  img_dir(i).name(11:13) == '140'
           acc(3) = acc(3) + 1;
        end
        if  img_dir(i).name(11:13) == '051'
           acc(4) = acc(4) + 1;
        end
        if  img_dir(i).name(11:13) == '050'
           acc(5) = acc(5) + 1;
        end
        if  img_dir(i).name(11:13) == '041'
           acc(6) = acc(6) + 1;
        end
        if  img_dir(i).name(11:13) == '190'
           acc(7) = acc(7) + 1;
        end
    else
        fprintf('false\n\n');
        if  img_dir(i).name(11:13) == '080'
           acc_wrong(1) = acc_wrong(1) + 1;
        end
        if  img_dir(i).name(11:13) == '130'
           acc_wrong(2) = acc_wrong(2) + 1;
        end
        if  img_dir(i).name(11:13) == '140'
           acc_wrong(3) = acc_wrong(3) + 1;
        end
        if  img_dir(i).name(11:13) == '051'
           acc_wrong(4) = acc_wrong(4) + 1;
        end
        if  img_dir(i).name(11:13) == '050'
           acc_wrong(5) = acc_wrong(5) + 1;
        end
        if  img_dir(i).name(11:13) == '041'
           acc_wrong(6) = acc_wrong(6) + 1;
        end
        if  img_dir(i).name(11:13) == '190'
           acc_wrong(7) = acc_wrong(7) + 1;
        end
    end
    whole_ans(1,i) = std_num;    
    whole_ans(2,i) = dist_index;
    whole_ans(3,i) = int32(P_angle);
%     save('whole_ans.mat','whole_ans');
end
