clc, clear
a=readmatrix('data9_1.txt');
b=a'; c=b(:,[1:27]); x=b(:,[28:end]); %提取已分类和待分类的数据
[d,ps]=mapstd(c); %已分类数据的标准化
mu=ps.xmean, sigma=ps.xstd  %显示已知数据的均值和标准差
xx=mapstd('apply',x,ps); %待分类数据的标准化
group=[ones(20,1); 2*ones(7,1)]; %已知样本点的类别标号
s=fitcsvm(d',group,'Standardize',true, 'KernelScale','auto','KernelFunction','linear') %训练支持向量机分类器.  %核函数设置：'KernelFunction','linear'.....
sv_index=find(s.IsSupportVector)  %返回支持向量的标号
beta=s.Alpha  %返回分类函数的权系数
bb=s.Bias  %返回分类函数的常数项
check=predict(s,d')  %验证已知样本点
err_rate=1-sum(group==check)/length(group) %计算已知样本点的错判率
solution=predict(s,xx') %对待判样本点进行分类
% 交叉验证，10折
CVSVMModel = crossval(s);
classLoss = kfoldLoss(CVSVMModel)

%% 使用交叉验证
clc, clear
a=readmatrix('data9_1.txt');
b=a'; c=b(:,[1:27]); x=b(:,[28:end]); %提取已分类和待分类的数据
[d,ps]=mapstd(c); %已分类数据的标准化
mu=ps.xmean, sigma=ps.xstd  %显示已知数据的均值和标准差
xx=mapstd('apply',x,ps); %待分类数据的标准化
group=[ones(20,1); 2*ones(7,1)]; %已知样本点的类别标号
s=fitcsvm(d',group,'CrossVal','on') %训练支持向量机分类器
s1=s.Trained{1} %提取第一个交叉验证分区的分类器
check=predict(s1,d')  %验证已知样本点

