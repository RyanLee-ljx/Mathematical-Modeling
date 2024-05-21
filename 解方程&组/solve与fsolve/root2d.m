function F = root2d(x)
global x3;   % 定义全局变量x3，可以直接向x3传递值
F(1) = exp(-exp(-(x(1)+x(2)))) - x(2)*(1+x(1)^2)+x3;
F(2) = x(1)*cos(x(2)) + x(2)*sin(x(1)) - 0.5+x3;

