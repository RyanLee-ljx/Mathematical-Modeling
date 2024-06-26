function H=fen_hermite(X,Y,YY)
% FEN_HERMITE 插值
% X为数据点X坐标
% Y为数据点Y坐标
% YY为导数值，可以用多项式插值得到表达式，然后利用diff求得导数再做修改
syms x
m=length(X);
for i=1:m-1
    N=newton(X(i:i+1),Y(i:i+1));
    N1=diff(N);
    w=prod(x-X(i:i+1));
    A=zeros(1,2);
    for j=1:2
        W=diff(w);
        A(j)=(YY(i+j-1)-subs(N1,x,X(i+j-1)))/subs(W,x,X(i+j-1));
    end
    A=newton(X(i:i+1),A);   
    H(i)=expand(N+A*w);   % 每一段的表达式
    x1(:,i)=X(i):0.1:X(i+1);   % 插值x
    Y1(:,i)=subs(H(i),x,x1(:,i));   % 对应x的插值
end
plot(X,Y,'o',x1(:),Y1(:))
