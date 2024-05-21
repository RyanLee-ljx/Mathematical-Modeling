clc,clear
x0=[41,49,61,78,96,104]; %原始序列
n=length(x0); 
x1=cumsum(x0)  %计算1次累加序列
a_x0=diff(x0)' %计算1次累减序列
z=0.5*(x1(2:end)+x1(1:end-1))'; %计算均值生成序列
B=[-x0(2:end)',-z,ones(n-1,1)]; 
u=B\a_x0   %最小二乘法拟合参数
syms x(t)
x=dsolve(diff(x,2)+u(1)*diff(x)+u(2)*x==u(3),x(0)==x1(1),x(5)==x1(6)); %求符号解
xt=vpa(x,6) %显示小数形式的符号解,即x1（累加过一次的）
yuce=subs(x,t,0:n-1); %求已知数据点1次累加序列的预测值
yuce=double(yuce) %符号数转换成数值类型，否则无法作差分运算
x0_hat=[yuce(1),diff(yuce)]; %求已知数据点的预测值
x0_hat=round(x0_hat) %四舍五入取整数
epsilon=x0-x0_hat    %求残差
delta=abs(epsilon./x0)  %求相对误差
cancha = sum(delta);
disp('残差=')
disp(num2str(cancha))
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





