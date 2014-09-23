function [Iwxp]=affi_change(pic, tmplt_pts, ref_point,lx,ly,rx,ry,mx,my)
%tmplt_pts:图像边框四段坐标 eg: tmplt_pts=[1 1;1 150; 120 1;120
%150]';如果要生成图像就需要，否则不需要


    
affm=maketform('affine', [lx ly;rx ry;mx my],ref_point);%投影变换结构
Iwxp=imtransform(pic,affm,'XData',[tmplt_pts(1,1) tmplt_pts(1,4)],'YData',[tmplt_pts(2,1) tmplt_pts(2,4)],'FillValues',120);