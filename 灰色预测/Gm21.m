clc,clear
x0=[41,49,61,78,96,104]; %ԭʼ����
n=length(x0); 
x1=cumsum(x0)  %����1���ۼ�����
a_x0=diff(x0)' %����1���ۼ�����
z=0.5*(x1(2:end)+x1(1:end-1))'; %�����ֵ��������
B=[-x0(2:end)',-z,ones(n-1,1)]; 
u=B\a_x0   %��С���˷���ϲ���
syms x(t)
x=dsolve(diff(x,2)+u(1)*diff(x)+u(2)*x==u(3),x(0)==x1(1),x(5)==x1(6)); %����Ž�
xt=vpa(x,6) %��ʾС����ʽ�ķ��Ž�,��x1���ۼӹ�һ�εģ�
yuce=subs(x,t,0:n-1); %����֪���ݵ�1���ۼ����е�Ԥ��ֵ
yuce=double(yuce) %������ת������ֵ���ͣ������޷����������
x0_hat=[yuce(1),diff(yuce)]; %����֪���ݵ��Ԥ��ֵ
x0_hat=round(x0_hat) %��������ȡ����
epsilon=x0-x0_hat    %��в�
delta=abs(epsilon./x0)  %��������
cancha = sum(delta);
disp('�в�=')
disp(num2str(cancha))
%Ԥ�⣺
 a=4;  %Ԥ�������
pyuce=subs(x,t,0:n-1+a); %����֪���ݵ�1���ۼ����е�Ԥ��ֵ
pyuce=double(pyuce) %������ת������ֵ���ͣ������޷����������
px0_hat=[pyuce(1),diff(pyuce)]; %����֪���ݵ��Ԥ��ֵ
disp('Ԥ����Ϊ��')
disp(px0_hat(7:end))

%��ͼ
m=length(px0_hat);
t0=1:m;
plot(t0(1:n),x0,'*-g',t0(1:n),px0_hat(1:n),'o-b',t0(n+1:end),px0_hat(n+1:end),'o-r');
legend('ԭʼ','���','Ԥ��');





