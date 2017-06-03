%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   GENERATE DENDROGRAM FROM AGGLOMERATIVE CLUSTERING
%   Data Analysis and Visualisation Project
%   Authors: Sabyasachi Sahoo and Vineetha Kondameedi
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear
tic
load('data\PROJECTED_RELU6.mat');
load('data\RELU6.mat');
classes = importdata('data\classes.txt');
toc
data = SCORE3(:,1:200);
clear SCORE3;

centroid = [];
start = 1;
for i = 1 : 20
    stop = start + size(RELU6{i,1},2) - 1;
    
    matrix = data( start:stop, :);
    c = mean(matrix);
    
    centroid = [centroid; c];
    start = stop + 1;
end
toc
Y  = pdist(centroid);
S = squareform(Y);
Z = linkage(S);
%Z = linkage(centroid);

toc
dendrogram(Z,'Orientation','right','Labels',classes);