function [Iwxp]=simi_change(pic, tmplt_pts, ref_point,lx,ly,rx,ry)
%tmplt_pts:图像边框四段坐标 eg: tmplt_pts=[1 1;1 150; 120 1;120
%150]';如果要生成图像就需要，否则不需要
%ref_point:4*1,双眼坐标位置，[lx,ly ,rx,ry];
% lx,ly,rx,ry：坐标，也可以输入


  %  ss=1;
  
    a=[ref_point(1) -ref_point(2) 1 0;
       ref_point(3) -ref_point(4) 1 0;
       ref_point(2) ref_point(1) 0 1;
       ref_point(4) ref_point(3) 0 1 ];
    b=[lx; rx ; ly ;ry];
    %warp即为所需要的似变换
    warp_p=a\b;
    
    Iwxp=warp_s(double(pic),warp_p,tmplt_pts);

    
    

    