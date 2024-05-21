%% interp2
x=linspace(-5,5,5);
y=linspace(-5,5,5);
[X,Y]=meshgrid(x,y);  % 快速生成网络，相当于生成一个5*5的二维网络
% 以后生成二维网络就用meshgrid，x，y分别为二维网络的范围
Z=X.^2+Y.^2;
% 默认线性插值
% x1=linspace(-5,5,100);
% y1=linspace(-5,5,100);
% [XX,YY]=meshgrid(x1,y1);

% ZZ=interp2(X,Y,Z,XX,YY);
% 
% mesh(X,Y,Z,'linestyle',':')
% hold on
% mesh(XX,YY,ZZ,'linestyle','-','edgecolor','r')

%% nearest  
% ZZ=interp2(X,Y,Z,XX,YY,'nearest');
% 
% mesh(X,Y,Z,'linestyle',':')
% hold on
% mesh(XX,YY,ZZ,'linestyle','-','edgecolor','r')

%% cubic
% ZZ=interp2(X,Y,Z,XX,YY,'cubic');
% 
% mesh(X,Y,Z,'linestyle',':')
% hold on
% mesh(XX,YY,ZZ,'linestyle','-','edgecolor','r')

%% spline  三次样条插值可以外推
x1=linspace(-6,6,100);
y1=linspace(-6,6,100);
[XX,YY]=meshgrid(x1,y1);
ZZ=interp2(X,Y,Z,XX,YY,'linear',5);

mesh(X,Y,Z,'linestyle',':')
hold on
mesh(XX,YY,ZZ,'linestyle','-','edgecolor','r')

ZZ=interp2(Z,2);
mesh(ZZ)


