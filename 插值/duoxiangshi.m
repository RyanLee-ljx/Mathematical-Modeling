function D=duoxiangshi(X,Y)
% XΪ�Ա������ݣ�YΪ���������
% ������Ϊ����ʽ��ֵ��ԭ��Ϊÿһ���㶼��һ�����̣�������Ԫ���ⷽ����õ�ϵ��
A=vander(X)   % ���ɷ����ɾ���
Y=Y'  
B=[A,Y]   % ������������ߴ���Ax=b��
C=rref(B)  % ��Ԫ������
D=C(:,end)   % ��ȡ����ʽϵ��
fprintf('\n  ����һ��%d�׵Ķ���ʽ���Ӹ߽׵��ͽ����У�\n',length(Y)-1);

plot(X,Y','o');
hold on 
x=X(1):0.01:X(end);
y=polyval(D,x)  %y=polyval(p,x)Ϊ���ض�Ӧ�Ա���x�ڸ���ϵ��P�Ķ���ʽ��ֵ
plot(x,y)