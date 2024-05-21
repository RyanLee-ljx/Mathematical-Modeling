%% fzero  
% 用法1
x1=fzero('x^2-2',0);   % 初值，返回离初值最近的一个根
x2=fzero('x^2-2',[0 3]);   % 根区间

%用法2
x3=fzero(@myfun,2)  % myfun为所有方程function y=myfun(x) y=x.^2-2+x.^3; 调用函数句柄

fun=@(x) x.^2-2+x.^3;
x4=fzero(fun,2)

options=optimset('Display','notify')    % 选项设置，显示形式
x5=fzero(fun,2,options)
% TolX  2.2204e-16     % 默认误差

[x6,fval]=fzero(fun,2)   % fval输出
[x6,fval,exitflag]=fzero(fun,2)

