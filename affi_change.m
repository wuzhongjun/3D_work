function [Iwxp]=affi_change(pic, tmplt_pts, ref_point,lx,ly,rx,ry,mx,my)
%tmplt_pts:ͼ��߿��Ķ����� eg: tmplt_pts=[1 1;1 150; 120 1;120
%150]';���Ҫ����ͼ�����Ҫ��������Ҫ


    
affm=maketform('affine', [lx ly;rx ry;mx my],ref_point);%ͶӰ�任�ṹ
Iwxp=imtransform(pic,affm,'XData',[tmplt_pts(1,1) tmplt_pts(1,4)],'YData',[tmplt_pts(2,1) tmplt_pts(2,4)],'FillValues',120);