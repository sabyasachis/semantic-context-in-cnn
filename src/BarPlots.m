%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   BAR PLOTS FOR kMEANS CLUSTERING
%   Data Analysis and Visualisation Project
%   Authors: Sabyasachi Sahoo and Vineetha Kondameedi
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear
load('data\PROJECTED_RELU6.mat');
load('data\featureRELU6.mat');
classes = importdata('data\classes.txt');

k = 20;
PMat = zeros(k,20);
[idx, centroid] = kmeans(SCORE3(:,1:500),20);

Y = pdist(centroid);
S = squareform(Y);
Z = linkage(S);
%dendrogram(Z);
feat  = featureRELU6'; 
for i = 1 : size(idx,1)
         row =  idx(i);
         col   = feat(i);
         PMat( row, col) = PMat( row, col) +1;
end

[m,  index]    =  max(PMat);
total = sum(PMat,2);
pure = m'./total;
purity = mean(pure)
bar(PMat(1,:));
 
%  [temp1,temp2] = max(PMat);
%  for i = 1 : k
%      
%  end