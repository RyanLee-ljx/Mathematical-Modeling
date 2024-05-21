% 加载鸢尾花数据集
load fisheriris
% 将数据分为训练集和测试集
rng(1); % 为了重现性
cvp = cvpartition(species,'Holdout',0.2);   %创建一个随机的保留验证分区，将species向量中的数据分为两部分：训练集和测试集。其中20%为测试集，80%为训练集
XTrain = meas(cvp.training,:);
YTrain = species(cvp.training);
XTest = meas(cvp.test,:);
YTest = species(cvp.test);
% 使用默认的SVM二分类器和一对一编码矩阵来训练ECOC模型
Mdl = fitcecoc(XTrain,YTrain);

% knn
Mdl = fitcecoc(X,Y,'Learners','knn');

% tree
Mdl = fitcecoc(X,Y,'Learners','knn');

% 创建一个k近邻模板，指定距离度量为欧氏距离、近邻数为5、权重函数为距离反比
t = templateKNN('Distance','euclidean','NumNeighbors',5,'DistanceWeight','inverse');
% 使用k近邻模板训练ECOC模型
Mdl = fitcecoc(X,Y,'Learners',t);

% 创建一个决策树模板，指定分裂准则为基尼系数，剪枝方法为代价复杂度剪枝
t = templateTree('SplitCriterion','gdi','Prune','on');
% 使用决策树模板训练ECOC模型
Mdl = fitcecoc(X,Y,'Learners',t);

% 使用训练好的模型来对测试集进行预测
YPred = predict(Mdl,XTest);


