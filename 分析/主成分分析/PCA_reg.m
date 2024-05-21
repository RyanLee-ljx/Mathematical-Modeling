%% Q�����ɷַ���
clc,clear
a=readmatrix('data10_5.txt'); [m,n]=size(a);
x0=a(:,[1:n-1]); y0=a(:,n); 
hg1=[ones(m,1),x0]\y0;   %������ͨ��С���˷��ع�ϵ��
hg1=hg1' %�����������ʾ�ع�ϵ��,���е�1�������ǳ����������x1,...,xn����
fprintf('y=%f',hg1(1)); %��ʼ��ʾ��ͨ��С���˷��ع���
for i=2:n
    if hg1(i)>0  
       fprintf('+%f*x%d',hg1(i),i-1);
    else
       fprintf('%f*x%d',hg1(i),i-1)
    end
end
fprintf('\n')  
r=corrcoef(x0)  %�������ϵ������
%��ͼ
% ��corrplot�����������ϵ������
figure(1)
corrplot(x0, 'type' , 'Pearson' , 'testR' , 'on' );
% ��heatmap���������ع�ϵ������
figure(2)
heatmap(r, 'XLabel' , 'Variables' , 'YLabel' , 'Methods' , ...
    'XData' , {'x1' , 'x2' , 'x3' , 'x4' } , ...
    'YData' , {'x1' , 'x2' , 'x3' , 'x4' } , 'ColorbarVisible' , 'on' );
% colormap autumn %copper hot 
colormap(othercolor('OrRd5')); 
xd=zscore(x0);  %����ƾ�����б�׼������
yd=zscore(y0);  %��y0���б�׼������
[vec1,lamda,rate]=pcacov(r) %vec1Ϊr������������lamdaΪr������ֵ��rateΪ�������ɷֵĹ�����
f=repmat(sign(sum(vec1)),size(vec1,1),1); %������vec1ͬά����Ԫ��Ϊ��1�ľ���
vec2=vec1.*f %�޸����������������ţ�ʹ���������������з�����Ϊ��
contr=cumsum(rate) %�����ۻ������ʣ���i��������ʾǰi�����ɷֵĹ�����
df=xd*vec2;  %�����������ɷֵĵ÷�
num=input('��ѡ�����ɷֵĸ���:')   %ͨ���ۻ������ʽ���ʽѡ�����ɷֵĸ���
hg21=df(:,[1:num])\yd  %���ɷֱ����Ļع�ϵ��,�����������ݱ�׼�����ع鷽�̵ĳ�����Ϊ0
hg22=vec2(:,1:num)*hg21  %��׼�������Ļع鷽��ϵ��
hg23=[mean(y0)-std(y0)*mean(x0)./std(x0)*hg22, std(y0)*hg22'./std(x0)]  %����ԭʼ�����ع鷽�̵�ϵ��
fprintf('y=%f',hg23(1)); %��ʼ��ʾ���ɷֻع���
for i=2:n
    if hg23(i)>0
        fprintf('+%f*x%d',hg23(i),i-1);
    else
        fprintf('%f*x%d',hg23(i),i-1);
    end
end
fprintf('\n')
%����������ֻع������ʣ���׼��
rmse1=sqrt(sum((hg1(1)+x0*hg1(2:end)'-y0).^2)/(m-n))   %�����n������
rmse2=sqrt(sum((hg23(1)+x0*hg23(2:end)'-y0).^2)/(m-num)) %�����num������


%% R�����ɷַ���
x1 = x0';
y1 = y0';
r1=corrcoef(x1)  %�������ϵ������
xd1=zscore(x1);  %����ƾ�����б�׼������
yd1=zscore(y1);  %��y0���б�׼������
[vec2,lamda1,rate1]=pcacov(r1) %vec1Ϊr������������lamdaΪr������ֵ��rateΪ�������ɷֵĹ�����
f1=repmat(sign(sum(vec2)),size(vec2,1),1); %������vec1ͬά����Ԫ��Ϊ��1�ľ���
vec2=vec2.*f1 %�޸����������������ţ�ʹ���������������з�����Ϊ��
contr1=cumsum(rate1) %�����ۻ������ʣ���i��������ʾǰi�����ɷֵĹ�����
df1=xd1*vec2;  %�����������ɷֵĵ÷�
% ��˫��ɢ��ͼ
figure(3);
scatter(df(:,1),df(:,2),12,'b','filled');
hold on; 
scatter(df1(:,1),df1(:,2),12,'r','filled');
legend('Q-type PCA','R-type PCA'); % ͼ��
% % Ϊÿ������ӱ�ע
labels = {'x1','x2','x3','x4'}; % ����һ�������ĸ��������ĵ�Ԫ����
text(df1(:,1)-0.1,df1(:,2)-0.1,labels); % ��ע
% for i = 1:4
%     annotation('arrow',[0.5 abs(df1(i,1)-0.1)*0.1],[0.5 abs(df1(i,2)-0.1)]*0.1 
% end  % �Ӽ�ͷ���������ֶ���
hold off;














