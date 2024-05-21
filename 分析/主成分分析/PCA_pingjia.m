clc,clear
a=readmatrix('anli10_1.txt');
%% 第一步 数据标准化
b=zscore(a); %数据标准化
%% 第二步 计算相关系数矩阵
r=corrcoef(b);  %计算相关系数矩阵
%% 第三步 计算特征值及特征向量
%下面利用相关系数矩阵进行主成分分析，vec1的列为r的特征向量，即主成分的系数
[vec1,lamda,rate]=pcacov(r) %lamda为r的特征值，rate为各个主成分的贡献率
%% 第四步 计算累积贡献率（rate为已经计算贡献率）
contr=cumsum(rate) %计算累积贡献率
f=repmat(sign(sum(vec1)),size(vec1,1),1);%构造与vec1同维数的元素为±1的矩阵
vec2=vec1.*f  %修改特征向量的正负号，使得每个特征向量的分量和为正
num=4;  %num为选取的主成分的个数
df=b*vec2(:,1:num);  %计算各个主成分的得分 即特征向量与标准化后数据之积再乘以相应贡献率
tf=df*rate(1:num)/100; %计算综合得分
[stf,ind]=sort(tf,'descend');  %把得分按照从高到低的次序排列
stf=stf';
ind=ind';
