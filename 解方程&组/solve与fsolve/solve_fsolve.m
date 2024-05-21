%% solve函数
 % 基本用法：S = solve(eqn,var,Name,true); eqn 为方程，var为求解变量，Name是选项
 syms a b c d x;
 eqn1 = a*x^3+b*x^2+c*x+d;
 eqn2 = a*x^2+b*x+c;
 S1 = solve(eqn1,x);
 S2 = solve(eqn2,x);

 % 求周期
 syms x;
 eqn3 = sin(x)*cos(x) ;
 [res3,pa,cond] = solve(eqn3,x,'ReturnConditions',true);   % res3返回的解  ,pa 是k的值 ，cond是k的条件
 assume(cond); % assume 用于限制解出的x范围
 interval = [res3<2*pi,res3>0]; % res3是结果
 s = solve(interval,pa);  % 求出k的范围
 v = subs(res3,pa,s);   % 用s得到的带范围的k替换原来的k，得到最后带范围的结果
 
 % 求方程组
 syms u v;
 eqn4 = [u^2+v^2==5;u+v==3];
 vars = [u v];
 S4 = solve(eqn4,vars);
 S4.u;
 S4.v;
 
 %% fsolve 函数
 global x3;
 x3 = 1;
 % 基本用法：x = fsolve(fun,x0,options); fun为函数句柄或函数.m文件
 fun = @root2d;
 x0 = [0,0]; % 初值
 % 1
 [x1,fval] = fsolve(fun,x0);
 % 2 
 [x2,fval] = fsolve('root2d',x0);
 % 使用另一种方法来改变方程中某个参数值进行求解
 k = 1;
 for c = -2:1:2   % 循环改变某个参数值，将所有解记录在x4中
     fun = @(x)paramfun(x,c);
     [x4(k,:),fval] = fsolve(fun,x0);
     k = k+1;
 end
 
 % option : Algorithm在 'trust-region-dogleg'（默认值）、'trust-region' 和 'levenberg-marquardt' 之间进行选择。
 
 % 3 
 x5 = fsolve(@(x)sin(x.*x),x0);
 options = optimoptions('fsolve','Algorithm','trust-region');
 
 
 
 
 