function D=duoxiangshi(X,Y)
% X为自变量数据，Y为因变量数据
% 本代码为多项式插值，原理为每一个点都是一个方程，利用消元法解方程组得到系数
A=vander(X)   % 生成范德蒙矩阵
Y=Y'  
B=[A,Y]   % 构成增广矩阵（线代里Ax=b）
C=rref(B)  % 消元法化简
D=C(:,end)   % 提取多项式系数
fprintf('\n  这是一个%d阶的多项式，从高阶到低阶排列！\n',length(Y)-1);

plot(X,Y','o');
hold on 
x=X(1):0.01:X(end);
y=polyval(D,x)  %y=polyval(p,x)为返回对应自变量x在给定系数P的多项式的值
plot(x,y)