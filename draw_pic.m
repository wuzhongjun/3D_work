clear;
r1=[50.3	69.66	87.5	94.82	89.96	68.38	54];
r2=[71.94	82.92	92.14	97.44	92.14	81.94	70];
r = [r1;r2];
b = bar(r');
grid on;
ch = get(b,'children');
legend('双眼对齐','双眼+嘴角中点对齐');
set(ch{1},'FaceVertexCData',repmat([0 0 1],[7 1]));
set(ch{2},'FaceVertexCData',repmat([1 1 1],[7 1]));
% set(ch,'FaceVertexCData',repmat([0 0 1;1 1 1],[1,7]));
% set(ch{1},'FaceVertexCData',[0 0 1;1 0 0]);
set(gca,'XTickLabel',{'-45°','-30°','-15°','0°','15°','30°','45°'});



xlabel('角度');
ylabel('平均识别率');
ylabel('平均识别率(%)');