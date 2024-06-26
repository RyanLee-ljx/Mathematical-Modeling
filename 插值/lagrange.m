function L=lagrange(X,Y)

if length(X)~=length(Y)
    error('维数不相同');
end

m=length(X);
for i=1:m
    L1(i)=Y(i)*ji(X,i);
end

L=sym2poly(expand(sum(L1)))  %符号转多项式 L为系数
x=X(1):0.1:X(end);
y=polyval(L,x);   % 利用polyval进行插值

plot(x,y)
hold on
plot(X,Y,'o')


function D=ji(X,n)
syms x
% 写法1
% switch n
%     case 1
%         B=x-X(2:end);
%         C=X(1)-X(2:end);
%     case length(X)
%         B=x-X(1:n-1);
%         C=X(n)-X(1:n-1);
%     otherwise
%         B=x-X([1:n-1,n+1:end]);
%         C=X(n)-X([1:n-1,n+1:end]);
% end

% 写法2
Xn=X(n);
X(n)=[];
B=x-X;
C=Xn-X;
D=prod(B)/prod(C);






