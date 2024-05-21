clc,clear
x0=[2.874,3.278,3.39,3.679,3.77,3.8]; %原始数据序列
n=length(x0);
a_x0=diff(x0)';  %求1次累减序列，即1阶向前差分
B=[-x0(2:end)',ones(n-1,1)]; 
u=B\a_x0  %最小二乘法拟合参数
syms x(t)
d2x=diff(x,2); dx=diff(x); %定义一阶导数，是为了下面赋初值
x=dsolve(d2x+u(1)*dx==u(2),x(0)==x0(1),dx(0)==x0(1));  %求二阶微分方程符号解
xt=vpa(x,6) %显示小数形式的符号解
yuce=subs(x,t,0:n-1); %求已知数据点1次累加序列的预测值
yuce=double(yuce) %符号数转换成数值类型，否则无法作差分运算
x0_hat=[yuce(1),diff(yuce)] %求已知数据点的预测值
epsilon=x0-x0_hat %求残差
delta=abs(epsilon./x0)  %求相对误差
%预测：
 a=4;  %预测的期数
pyuce=subs(x,t,0:n-1+a); %求已知数据点1次累加序列的预测值
pyuce=double(pyuce) %符号数转换成数值类型，否则无法作差分运算
px0_hat=[pyuce(1),diff(pyuce)]; %求已知数据点的预测值
disp('预测结果为：')
disp(px0_hat(7:end))

%作图
m=length(px0_hat);
t0=1:m;
plot(t0(1:n),x0,'*-g',t0(1:n),px0_hat(1:n),'o-b',t0(n+1:end),px0_hat(n+1:end),'o-r');
legend('原始','拟合','预测');