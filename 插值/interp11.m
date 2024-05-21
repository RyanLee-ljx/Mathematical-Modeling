%以2018年1月18号南京市秦淮区的天气温度为例  被插值函数为单变量函数，故为1维插值
figure(1)
tem=[2 2 0 2 2 2 2 3 5 7 9 10 11 12 12 11 10 9 7 7 6 6 5 5];
time=1:24;
plot(time,tem,'o')
hold on

% 第一种用法
xq=1:0.5:24;
vq=interp1(time,tem,xq);  % xq为插值点
plot(xq,vq)

% 第二种
% linear  连续
% nearest 临近点插值
% next
% previous
% pchip 保形分段三次插值（埃尔米塔分段三次插值）
% spline  三次样条插值

% 线性
figure(2)
subplot(2,3,1)
xq=1:0.5:24;
vq=interp1(time,tem,xq,'linear');
plot(xq,vq,'*')
title('linear')

% 临近点
subplot(2,3,2)
xq=1:0.5:24;
vq=interp1(time,tem,xq,'nearest');
plot(xq,vq,'*')
title('nearest')

% next
subplot(2,3,3)
xq=1:0.5:24;
vq=interp1(time,tem,xq,'next');
plot(xq,vq,'*')
title('next')


% previous
subplot(2,3,4)
xq=1:0.5:24;
vq=interp1(time,tem,xq,'previous');
plot(xq,vq,'*')
title('previous')

% pchip
subplot(2,3,5)
xq=1:0.5:24;
vq=interp1(time,tem,xq,'pchip');
plot(xq,vq,'*')
title('pchip')

% spline
subplot(2,3,6)
xq=1:0.5:24;
vq=interp1(time,tem,xq,'spline');
plot(xq,vq,'*')
title('spline')


% 返回表达式
x=0:0.5:2*pi;
y=sin(x);
p=interp1(x,y,'spline','pp');    % pp返回多项式，p是一个结构体，p.coefs是每一段的系数
poly2sym(p.coefs(2,:))  % 返回第二段插值表达式 
yy=ppval(p,linspace(0,2*pi,101))    % 有了p的表达式，带入插值点进行插值
plot(x,y,'o',linspace(0,2*pi,101),yy)

% 外推，可以用于进行未知数据预测
x=0:0.5:2*pi;   
y=sin(x);
xi=-1:0.2:7;  % 外推-1导0以及2pi到7部分
p1=interp1(x,y,xi,'spline')   % 三次样条插值结果
p2=interp1(x,y,xi,'linear','extrap')   % 线性插值结果
plot(x,y,'or',xi,p1,'*b',xi,p2,'.k')




