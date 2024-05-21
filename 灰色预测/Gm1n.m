


%应用部分，原理见下，此处为预测三期，下面注释为普遍部分，但程序似乎有BUG，需要手动输入预测的参量到x20,x30中

clc, clear, format long g
x0=[4383	7625	10500	11316	17818
83	131	180	195	306
146	212	233	259	404];
[m,n]=size(x0); x1_d=cumsum(x0,2)
x11=x1_d(1,:)
z11=0.5*(x11(1:end-1)+x11(2:end))
b=[-z11',x1_d(2,2:end)',x1_d(3,2:end)']
y=x0(1,2:end)', u=b\y
syms x1(t) x2 x3 a b2 b3 x10
x1=dsolve(diff(x1)+a*x1==b2*x2+b3*x3,x1(0)==x10);
x1=subs(x1,{a,b2,b3,x10},{u(1),u(2),u(3),x0(1,1)});
x1_s1=vpa(x1,9), x1_s2=vpa(simplify(x1),9) %显示时间响应式
x1_s3=vpa(expand(x1),9) %展开显示时间响应式 
x20=[x0(2,:),400 500 600]; x30=[x0(3,:),500 600 700];   %A:[400 500 600]为预测参量X1，B:[500 600 700]为预测参量X2 都应为行向量
x21=cumsum(x20); x31=cumsum(x30);
x1=subs(x1,{t,x2,x3},{[0:n+2],x21,x31}); %计算预测值的符号值  ,此处n加的数为 预测期数-1
x1=double(x1); %把符号值转化为double类型值
x10hat=[x1(1),diff(x1)] %还原到原始数据
epsilon=x0(1,:)-x10hat(1:end-3); %计算残差 ，此处end减去的数字为预测期数
delta=abs(epsilon./x0(1,:)) %计算相对误差
xhat=x10hat(end-2:end), format   %预测值  此处end减去的数为预测期数-1
%x10hat 为模型预测的所有与测量
plot(1:1:5,x0(1,:),'o-r',1:1:5,x10hat(1:5),'>-b',6:1:8,xhat,'*-k');
legend('原始值','拟合值','预测值');










%% 原理部分（参数注释）
% clc, clear, format long g
% x0=[4383	7625	10500	11316	17818
% 83	131	180	195	306
% 146	212	233	259	404];
% [m,n]=size(x0); x1_d=cumsum(x0,2)
% x11=x1_d(1,:)
% z11=0.5*(x11(1:end-1)+x11(2:end))
% b=[-z11',x1_d(2,2:end)',x1_d(3,2:end)']
% y=x0(1,2:end)', u=b\y
% syms x1(t) x2 x3 a b2 b3 x10
% x1=dsolve(diff(x1)+a*x1==b2*x2+b3*x3,x1(0)==x10);
% x1=subs(x1,{a,b2,b3,x10},{u(1),u(2),u(3),x0(1,1)});
% x1_s1=vpa(x1,9), x1_s2=vpa(simplify(x1),9) %显示时间响应式
% x1_s3=vpa(expand(x1),9) %展开显示时间响应式
% A=[400 500]; B=[500 600];  
% x20=[x0(2,:),A]; x30=[x0(3,:),B];   %A为预测参量X1，B为预测参量X2 都应为行向量
% m = size(A,2);    %提取列数
% t = m-1;
% x21=cumsum(x20); x31=cumsum(x30);
% x1=subs(x1,{t,x2,x3},{[0:n+t],x21,x31}); %计算预测值的符号值
% x1=double(x1); %把符号值转化为double类型值
% x10hat=[x1(1),diff(x1)] %还原到原始数据
% epsilon=x0(1,:)-x10hat(1:end-m); %计算残差
% delta=abs(epsilon./x0(1,:)) %计算相对误差
% xhat=x10hat(end-t:end), format   %预测值


