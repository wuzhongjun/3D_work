function [ Sw,Sb ] = em_sw_sb( X,label,num_iters )
%================================================================
% em_sw_sb.m ����EM�㷨���������ķֲ�����
% ���룺X����������ÿһ��Ϊһ������
% ����� Sw,Sb
%================================================================

DIM_X=size(X,1);%����ά��
NUM_X=size(X,2);%��������

NUM_class=max(label);
Hw=(zeros(DIM_X,NUM_X));%����Э�������
Sb=(zeros(DIM_X,DIM_X));%���Э�������
ui=zeros(DIM_X,NUM_class);%ÿһ���������ֵ
Ni=zeros(1,NUM_class);%ÿһ���������
delta=X-X;
for i_class=1:NUM_class
    index=find(label==i_class);
    ui(:,i_class)=mean(X(:,index),2);
    Ni(i_class)=numel(index);
    if length(index) > 1,
        for j = 1:length(index),
            Hw(:,index(j)) = X(:,index(j))-ui(:,i_class);
        end;
    end;
end
 S = sum(Hw); idx = find(abs(S) < 0.000001); Hw(:,idx) = [];
 Sw = Hw*Hw';
 
u=mean(X,2);
for i_class=1:NUM_class
    Sb=Sb+Ni(i_class)*(ui(:,i_class)-u)*(ui(:,i_class)-u)';
end


% start EM
for circle=1:num_iters,
    fprintf('.');
    F=inv(Sw);
    for i_class=1:NUM_class
        index=find(label == i_class);
        m = length(index);
    
        G=-inv((m+1)*Sb+Sw)*Sb*inv(Sw); 

        ui(:,i_class)=Sb*(F+(m+1)*G)*sum(X(:,index),2);

        S = Sw*G*sum(X(:,index),2);
        for j = 1:length(index),
            delta(:,index(j))=Sw*X(:,index(j))+ S;
        end;
    end
  
    Sb=cov(ui');
    Sw=cov(delta');
end

end

