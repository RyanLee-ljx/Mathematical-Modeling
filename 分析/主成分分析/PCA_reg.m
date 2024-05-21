%% Q型主成分分析
clc,clear
a=readmatrix('data10_5.txt'); [m,n]=size(a);
x0=a(:,[1:n-1]); y0=a(:,n); 
hg1=[ones(m,1),x0]\y0;   %计算普通最小二乘法回归系数
hg1=hg1' %变成行向量显示回归系数,其中第1个分量是常数项，其它按x1,...,xn排序
fprintf('y=%f',hg1(1)); %开始显示普通最小二乘法回归结果
for i=2:n
    if hg1(i)>0  
       fprintf('+%f*x%d',hg1(i),i-1);
    else
       fprintf('%f*x%d',hg1(i),i-1)
    end
end
fprintf('\n')  
r=corrcoef(x0)  %计算相关系数矩阵
%绘图
% 用corrplot函数画出相关系数矩阵
figure(1)
corrplot(x0, 'type' , 'Pearson' , 'testR' , 'on' );
% 用heatmap函数画出回归系数矩阵
figure(2)
heatmap(r, 'XLabel' , 'Variables' , 'YLabel' , 'Methods' , ...
    'XData' , {'x1' , 'x2' , 'x3' , 'x4' } , ...
    'YData' , {'x1' , 'x2' , 'x3' , 'x4' } , 'ColorbarVisible' , 'on' );
% colormap autumn %copper hot 
colormap(othercolor('OrRd5')); 
xd=zscore(x0);  %对设计矩阵进行标准化处理
yd=zscore(y0);  %对y0进行标准化处理
[vec1,lamda,rate]=pcacov(r) %vec1为r的特征向量，lamda为r的特征值，rate为各个主成分的贡献率
f=repmat(sign(sum(vec1)),size(vec1,1),1); %构造与vec1同维数的元素为±1的矩阵
vec2=vec1.*f %修改特征向量的正负号，使得特征向量的所有分量和为正
contr=cumsum(rate) %计算累积贡献率，第i个分量表示前i个主成分的贡献率
df=xd*vec2;  %计算所有主成分的得分
num=input('请选项主成分的个数:')   %通过累积贡献率交互式选择主成分的个数
hg21=df(:,[1:num])\yd  %主成分变量的回归系数,这里由于数据标准化，回归方程的常数项为0
hg22=vec2(:,1:num)*hg21  %标准化变量的回归方程系数
hg23=[mean(y0)-std(y0)*mean(x0)./std(x0)*hg22, std(y0)*hg22'./std(x0)]  %计算原始变量回归方程的系数
fprintf('y=%f',hg23(1)); %开始显示主成分回归结果
for i=2:n
    if hg23(i)>0
        fprintf('+%f*x%d',hg23(i),i-1);
    else
        fprintf('%f*x%d',hg23(i),i-1);
    end
end
fprintf('\n')
%下面计算两种回归分析的剩余标准差
rmse1=sqrt(sum((hg1(1)+x0*hg1(2:end)'-y0).^2)/(m-n))   %拟合了n个参数
rmse2=sqrt(sum((hg23(1)+x0*hg23(2:end)'-y0).^2)/(m-num)) %拟合了num个参数


%% R型主成分分析
x1 = x0';
y1 = y0';
r1=corrcoef(x1)  %计算相关系数矩阵
xd1=zscore(x1);  %对设计矩阵进行标准化处理
yd1=zscore(y1);  %对y0进行标准化处理
[vec2,lamda1,rate1]=pcacov(r1) %vec1为r的特征向量，lamda为r的特征值，rate为各个主成分的贡献率
f1=repmat(sign(sum(vec2)),size(vec2,1),1); %构造与vec1同维数的元素为±1的矩阵
vec2=vec2.*f1 %修改特征向量的正负号，使得特征向量的所有分量和为正
contr1=cumsum(rate1) %计算累积贡献率，第i个分量表示前i个主成分的贡献率
df1=xd1*vec2;  %计算所有主成分的得分
% 画双重散点图
figure(3);
scatter(df(:,1),df(:,2),12,'b','filled');
hold on; 
scatter(df1(:,1),df1(:,2),12,'r','filled');
legend('Q-type PCA','R-type PCA'); % 图例
% % 为每个点添加标注
labels = {'x1','x2','x3','x4'}; % 创建一个包含四个变量名的单元数组
text(df1(:,1)-0.1,df1(:,2)-0.1,labels); % 标注
% for i = 1:4
%     annotation('arrow',[0.5 abs(df1(i,1)-0.1)*0.1],[0.5 abs(df1(i,2)-0.1)]*0.1 
% end  % 加箭头，但建议手动加
hold off;














