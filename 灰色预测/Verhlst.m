clc,clear
x0=[4.93   2.33   3.87   4.35   6.63   7.15   5.37   6.39   7.81   8.35];
x1=cumsum(x0);  %求1次累加序列
n=length(x0);
z=0.5*(x1(2:n)+x1(1:n-1));   %求x1的均值生成序列
B=[-z',z'.^2];
Y=x0(2:end)';
u=B\Y     %估计参数a,b的值
syms x(t)
x=dsolve(diff(x)+u(1)*x==u(2)*x^2,x(0)==x0(1));  %求符号解
xt=vpa(x,6) %显示小数形式的符号解
yuce=subs(x,t,[0:n-1]); %求已知数据点1次累加序列的预测值
yuce=double(yuce) %符号数转换成数值类型，否则无法作差分运算
x0_hat=[yuce(1),diff(yuce)] %求已知数据点的预测值
epsilon=x0-x0_hat    %求残差
cancha=sum(epsilon);
disp(['残差=',num2str(cancha)]);
delta=abs(epsilon./x0)  %求相对误差
relative=sum(delta);
disp(['相对残差=',num2str(relative)]);

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

