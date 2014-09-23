

    clear;
    supervised = 1
    ishd = 0
    rand('state',0);
    load('pairlist_lfw.mat');
    load('id_lfw.mat');
    if ishd == 1,
        load('D:\learning_opengl\BaselFace\matlab\new_recogntion\TestData_symmetry_101_122.mat', 'TestData');
        
        high_dim_LBP_LFW = sqrt(single(full(TestData)));        
    else,
        load('D:\learning_opengl\BaselFace\matlab\new_recogntion\TestData_symmetry_101_122.mat', 'TestData');
        high_dim_LBP_LFW = sqrt(single(full(TestData)));         
    end;


    for pca_dim = 300;%[550:50:1000],
        pca_dim
%     load('G:\features\lbp_lfw.mat');
%     high_dim_LBP_LFW = sqrt(single(lbp_lfw));
for Fold = 1:10,
      
    TeIdx = (Fold-1)*300+1:Fold*300;
    TrIdx = 1:3000; TrIdx(TeIdx) = [];
        
    idx = pairlist_lfw.IntraPersonPair(TrIdx, 1);
    idx = [idx; pairlist_lfw.IntraPersonPair(TrIdx, 2)];
    idx = [idx; pairlist_lfw.ExtraPersonPair(TrIdx, 1)];
    idx = [idx; pairlist_lfw.ExtraPersonPair(TrIdx, 2)];
    idx = unique(idx);
    if supervised == 1,
        class_id = id_lfw(idx);
        Y = zeros(max(class_id),length(class_id));
        for i = 1:length(class_id),
                Y(class_id(i),i) = 1;
        end;
        Y_S = sum(Y,2);
        zidx = find(Y_S == 0);
        Y(zidx, :) = [];       
    end;
    label = [];
    for i = 1:size(Y,2),
        j = find(Y(:,i)==1);
        label = [label; j];  %label for LDA training
    end;
 

    

    X = high_dim_LBP_LFW(idx,:)';
    [U, ~, ~] = svd(X,0);
    U = U(:,1:pca_dim);
    X = U'*X; 
    W1 = U'*high_dim_LBP_LFW(pairlist_lfw.IntraPersonPair(TeIdx, 1),:)'; 
    W2 = U'*high_dim_LBP_LFW(pairlist_lfw.IntraPersonPair(TeIdx, 2),:)';
    B1 = U'*high_dim_LBP_LFW(pairlist_lfw.ExtraPersonPair(TeIdx, 1),:)'; 
    B2 = U'*high_dim_LBP_LFW(pairlist_lfw.ExtraPersonPair(TeIdx, 2),:)';

        
    
    %center the both training and test data
    GM = mean(X,2);
    for i = 1:size(X,2),
        X(:,i) = X(:,i)-GM;
    end;
    for i = 1:size(W1,2),
        W1(:,i) = W1(:,i)-GM;W2(:,i) = W2(:,i)-GM;B1(:,i) = B1(:,i)-GM;B2(:,i) = B2(:,i)-GM;
    end;   
    
    

    [ Sw,Sb ] = em_sw_sb( X,label, 0);
    [G_, D] = eig(inv(Sw)*Sb);
    [~, idx] = sort(diag(D), 'descend');
    G_ = G_(:,idx);


    W1_ = G_'*W1; 
    W2_ = G_'*W2; 
    B1_ = G_'*B1; 
    B2_ = G_'*B2; 
    
   p = 0;
for lamda = 10:10:300,%round(pca_dim/20):round(pca_dim/20):min(pca_dim,size(Y,1)),
    p = p+1;

     W1 = W1_(1:lamda,:);%for i = 1:size(W1,2) W1(:,i) = W1(:,i)/norm(W1(:,i)); end;
     W2 = W2_(1:lamda,:);%for i = 1:size(W2,2) W2(:,i) = W2(:,i)/norm(W2(:,i)); end;
     B1 = B1_(1:lamda,:);%for i = 1:size(B1,2) B1(:,i) = B1(:,i)/norm(B1(:,i)); end;
     B2 = B2_(1:lamda,:);%for i = 1:size(B2,2) B2(:,i) = B2(:,i)/norm(B2(:,i)); end;

    %X = X_(1:lamda,:);for i = 1:size(X,2) X(:,i) = X(:,i)/norm(X(:,i)); end;
    
     for i = 1:300,
        WScore(i) = W1(:,i)'*W2(:,i)/(norm(W1(:,i))*norm(W2(:,i)));  %compute the cosine similarity
     end;

     for i = 1:300,
        BScore(i) = B1(:,i)'*B2(:,i)/(norm(B1(:,i))*norm(B2(:,i)));
     end;  
     
     FAR = []; VR = [];
     for thres = -1:.001:1,
         FAR = [FAR; double(length(find(BScore > thres)))/300];
         VR =  [VR; double(length(find(WScore > thres)))/300];
     end;
     FRR = 1-VR;
     diff = abs(FAR-FRR);
     [tmp, idx] = min(diff);
     fprintf('%.2f ',(1-FRR(idx))*100);
     PI(Fold, p) = (1-FRR(idx))*100;
end; 

fprintf('\n');
     %close all;
     %plot(FAR, VR);
end;
mean(PI)
result = max(mean(PI))
fprintf('\n');
    end;
     
return;



