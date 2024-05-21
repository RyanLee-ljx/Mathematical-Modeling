%��2018��1��18���Ͼ����ػ����������¶�Ϊ��  ����ֵ����Ϊ��������������Ϊ1ά��ֵ
figure(1)
tem=[2 2 0 2 2 2 2 3 5 7 9 10 11 12 12 11 10 9 7 7 6 6 5 5];
time=1:24;
plot(time,tem,'o')
hold on

% ��һ���÷�
xq=1:0.5:24;
vq=interp1(time,tem,xq);  % xqΪ��ֵ��
plot(xq,vq)

% �ڶ���
% linear  ����
% nearest �ٽ����ֵ
% next
% previous
% pchip ���ηֶ����β�ֵ�����������ֶ����β�ֵ��
% spline  ����������ֵ

% ����
figure(2)
subplot(2,3,1)
xq=1:0.5:24;
vq=interp1(time,tem,xq,'linear');
plot(xq,vq,'*')
title('linear')

% �ٽ���
subplot(2,3,2)
xq=1:0.5:24;
vq=interp1(time,tem,xq,'nearest');
plot(xq,vq,'*')
title('nearest')

% next
subplot(2,3,3)
xq=1:0.5:24;
vq=interp1(time,tem,xq,'next');
plot(xq,vq,'*')
title('next')


% previous
subplot(2,3,4)
xq=1:0.5:24;
vq=interp1(time,tem,xq,'previous');
plot(xq,vq,'*')
title('previous')

% pchip
subplot(2,3,5)
xq=1:0.5:24;
vq=interp1(time,tem,xq,'pchip');
plot(xq,vq,'*')
title('pchip')

% spline
subplot(2,3,6)
xq=1:0.5:24;
vq=interp1(time,tem,xq,'spline');
plot(xq,vq,'*')
title('spline')


% ���ر��ʽ
x=0:0.5:2*pi;
y=sin(x);
p=interp1(x,y,'spline','pp');    % pp���ض���ʽ��p��һ���ṹ�壬p.coefs��ÿһ�ε�ϵ��
poly2sym(p.coefs(2,:))  % ���صڶ��β�ֵ���ʽ 
yy=ppval(p,linspace(0,2*pi,101))    % ����p�ı��ʽ�������ֵ����в�ֵ
plot(x,y,'o',linspace(0,2*pi,101),yy)

% ���ƣ��������ڽ���δ֪����Ԥ��
x=0:0.5:2*pi;   
y=sin(x);
xi=-1:0.2:7;  % ����-1��0�Լ�2pi��7����
p1=interp1(x,y,xi,'spline')   % ����������ֵ���
p2=interp1(x,y,xi,'linear','extrap')   % ���Բ�ֵ���
plot(x,y,'or',xi,p1,'*b',xi,p2,'.k')




