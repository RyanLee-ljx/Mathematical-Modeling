%% fzero  
% �÷�1
x1=fzero('x^2-2',0);   % ��ֵ���������ֵ�����һ����
x2=fzero('x^2-2',[0 3]);   % ������

%�÷�2
x3=fzero(@myfun,2)  % myfunΪ���з���function y=myfun(x) y=x.^2-2+x.^3; ���ú������

fun=@(x) x.^2-2+x.^3;
x4=fzero(fun,2)

options=optimset('Display','notify')    % ѡ�����ã���ʾ��ʽ
x5=fzero(fun,2,options)
% TolX  2.2204e-16     % Ĭ�����

[x6,fval]=fzero(fun,2)   % fval���
[x6,fval,exitflag]=fzero(fun,2)

