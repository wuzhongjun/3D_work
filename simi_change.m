function [Iwxp]=simi_change(pic, tmplt_pts, ref_point,lx,ly,rx,ry)
%tmplt_pts:ͼ��߿��Ķ����� eg: tmplt_pts=[1 1;1 150; 120 1;120
%150]';���Ҫ����ͼ�����Ҫ��������Ҫ
%ref_point:4*1,˫������λ�ã�[lx,ly ,rx,ry];
% lx,ly,rx,ry�����꣬Ҳ��������


  %  ss=1;
  
    a=[ref_point(1) -ref_point(2) 1 0;
       ref_point(3) -ref_point(4) 1 0;
       ref_point(2) ref_point(1) 0 1;
       ref_point(4) ref_point(3) 0 1 ];
    b=[lx; rx ; ly ;ry];
    %warp��Ϊ����Ҫ���Ʊ任
    warp_p=a\b;
    
    Iwxp=warp_s(double(pic),warp_p,tmplt_pts);

    
    

    