% 加载数据集
clear;
clc;
close all;
%% 数据导入
load fisheriris 

% 将数据集转换为表格形式
irisTable = table(meas, species);  % meas:自变量 species：因变量

% 分割数据集为训练集和测试集
cv = cvpartition(height(irisTable), 'HoldOut', 0.3);    % 30&划分为测试集
trainData = irisTable(training(cv), :);
testData = irisTable(test(cv), :);
X = trainData.meas;    % 训练自变量
Y = trainData.species;  % 训练因变量
X1 =  testData.meas;
Y1 = testData.species;
%% 创建决策树分类器
Tree =  fitctree(X,Y);
 
%% 查看决策树视图
view(Tree);
view(Tree,'mode','graph');
 
%% 寻找最优叶子节点数
leafs = logspace(1,2,20);  %  y = logspace(a,b,n) % 在 10 的幂 10^a 和 10^b （10 的 N 次幂）之间生成 n 个点 y
N = numel(leafs);  % numel返回leafs里元素个数
err = zeros(N,1);
for n = 1:N
    t = fitctree(X,Y,'crossval','on','MinLeafSize',leafs(n));
    err(n)=kfoldLoss(t);
end
plot(leafs,err);
xlabel('叶子节点含有的最小样本数');
ylabel('交叉验证误差');
title('叶子节点含有的最小样本数对决策树性能的影响');
index = find(err==min(err));
nn = fix(leafs(index));  
% 如何nn有多个相等，取第一个
%% 根据图像选择最优minleaf
OptimalTree = fitctree(X,Y,'MinLeafSize',nn(1));
view(OptimalTree,'mode','graph');


resubopt = resubLoss(OptimalTree) %计算预测值和真实值之间的平均平方误差（mean squared error）
lossOpt= kfoldLoss(crossval(OptimalTree));  %进行10折交叉验证，并计算每一折中预测值和真实值之间的平均平方误差

disp(['重采样误差:'... 
    num2str(resubopt)]);
 disp(['交叉验证误差:'... 
    num2str(lossOpt)]);
%% 预测分类
Tree_pre = predict(OptimalTree,X1);   
%% 精度比较：分类因变量是元胞标签时候需要这样做，一般数值只需要accuracy = sum(Tree_pre == Y1)/numel(Y1); 
m = 0;
for i = 1:numel(Y1)
    m = m + isequal(Tree_pre(i),Y1(i));
end
accuracy = m/numel(Y1);   

 disp(['总正确率:'... 
     sprintf('%2.2f%%', accuracy*100)]);


% 一般数值只需要accuracy = sum(Tree_pre == Y1)/numel(Y1); 

% %% 结果分析
% count_train_1 = length(find(Train_Label == 1));  %训练集中车辆质量不达标个数
% count_train_2 = length(find(Train_Label == 2));  %训练集中车辆质量达标个数
% count_train_3 = length(find(Train_Label == 3));  %训练集中车辆质量良好个数
% count_train_4 = length(find(Train_Label == 4));  %训练集中车辆质量优秀个数
%  
% rate_train_1 = count_train_1 / 1500;             %训练集中车辆质量不达标占的比例
% rate_train_2 = count_train_2 / 1500;             %训练集中车辆质量达标占的比例
% rate_train_3 = count_train_3 / 1500;             %训练集中车辆质量优良占的比例
% rate_train_4 = count_train_4 / 1500;             %训练集中车辆质量优秀占的比例
%  
% total_1 = length(find(data(:,7) == 1));  %总数据中车辆质量不达标个数
% total_2 = length(find(data(:,7) == 2));  %总数据中车辆质量达标个数
% total_3 = length(find(data(:,7) == 3));  %总数据中车辆质量优良个数
% total_4 = length(find(data(:,7) == 4));  %总数据中车辆质量优秀个数
%  
% count_test_1 = length(find(Test_Label == 1));  %测试集中车辆质量不达标个数
% count_test_2 = length(find(Test_Label == 2));  %测试集中车辆质量达标个数
% count_test_3 = length(find(Test_Label == 3));  %测试集中车辆质量良好个数
% count_test_4 = length(find(Test_Label == 4));  %测试集中车辆质量优秀个数
%  
% count_right_1 = length(find(Tree_pre == 1 & Test_Label == 1));  %测试集中预测车辆质量不达标正确的个数
% count_right_2 = length(find(Tree_pre == 2 & Test_Label == 2));  %测试集中预测车辆质量达标正确的个数
% count_right_3 = length(find(Tree_pre == 3 & Test_Label == 3));  %测试集中预测车辆质量优良正确的个数
% count_right_4 = length(find(Tree_pre == 4 & Test_Label == 4));  %测试集中预测车辆质量优秀正确的个数
%  
% rate_right = (count_right_1+count_right_2+count_right_3+count_right_4)/228;
%  
% %% 显示部分结果
% disp(['车辆总数：1728'...
%       '  不达标：' num2str(total_1)...
%       '  达标：' num2str(total_2)...
%       '  优良：' num2str(total_3)...
%       '  优秀：' num2str(total_4)]);
% disp(['训练集车辆数：1500'...
%       '  不达标：' num2str(count_train_1)...
%       '  达标：' num2str(count_train_2)...
%       '  优良：' num2str(count_train_3)...
%       '  优秀：' num2str(count_train_4)]);
% disp(['测试集车辆数：228'...
%       '  不达标：' num2str(count_test_1)...
%       '  达标：' num2str(count_test_2)...
%       '  优良：' num2str(count_test_3)...
%       '  优秀：' num2str(count_test_4)]);
% disp(['决策树判断结果：'...
%       '  不达标正确率：' sprintf('%2.2f%%', count_right_1/count_test_1*100)...
%       '  达标正确率：' sprintf('%2.2f%%', count_right_2/count_test_2*100)...
%       '  优良正确率：' sprintf('%2.2f%%', count_right_3/count_test_3*100)...
%       '  优秀正确率：' sprintf('%2.2f%%', count_right_4/count_test_4*100)]);
%   
% disp(['总正确率:'... 
%     sprintf('%2.2f%%', rate_right*100)]);
%   
 %% 优化前决策树的重采样误差和交叉验证误差
resubDefault = resubLoss(Tree);
lossDefault = kfoldLoss(crossval(Tree));
disp(['剪枝前决策树的重采样误差:'... 
    num2str(resubDefault)]);
 disp(['剪枝前决策树的交叉验证误差:'... 
    num2str(lossDefault)]);
 
%% 剪枝
t2 = prune(t1, 'level', levelvalue) 
t2 = purne(t1, 'nodes', nodes)
view(t2, 'Mode', 'graph')

% t1 原来树，t2剪后数‘level’ 表示按照层进行剪枝，levelvalue 表示剪掉的层数。‘nodes’ 表示按照借点剪枝，nodes 表示剪掉该结点后的所有枝。view(t2,‘Model’,‘graph’)表示以图形化方式显示 t2 决策树。

[~,~,~,bestlevel] = cvLoss(Tree,'subtrees','all','treesize','min');
cptree = prune(Tree,'Level',bestlevel);
view(cptree,'mode','graph')
 
%% 剪枝后决策树的重采样误差和交叉验证误差
resubPrune = resubLoss(cptree);
lossPrune = kfoldLoss(crossval(cptree));
disp(['剪枝后决策树的重采样误差:'... 
    num2str(resubPrune)]);
 disp(['剪枝后决策树的交叉验证误差:'... 
    num2str(resubPrune)]);

