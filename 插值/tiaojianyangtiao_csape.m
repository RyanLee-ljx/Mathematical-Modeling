%% csape
x=linspace(0,2*pi,15);
y=sin(x);
plot(x,y,'o')
hold on

%% complete  给定一阶导数值
p=csape(x,y,'complete',[2,2]);
x1=linspace(0,2*pi,150);
y1=ppval(p,x1);
plot(x1,y1,'b','linewidth',1.5)

%% second    给定二阶导数值
p=csape(x,y,'second',[2,3]);
x1=linspace(0,2*pi,150);
y1=ppval(p,x1);
plot(x1,y1,'b','linewidth',1.5)

%% periodic   周期
p=csape(x,y,'periodic');
x1=linspace(0,2*pi,150);
y1=ppval(p,x1);
plot(x1,y1,'b','linewidth',1.5)

%% not-a-knot  非扭结
% p=csape(x,y,'not-a-knot');
% x1=linspace(0,2*pi,150);
% y1=ppval(p,x1);
% plot(x1,y1,'b','linewidth',1.5)

%% variational    指定二阶导数为0
% p=csape(x,y,'variational');
% x1=linspace(0,2*pi,150);
% y1=ppval(p,x1);
% plot(x1,y1,'b','linewidth',1.5)
