%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   PLOTTING DENDROGRAM FROM ORIGINAL CENTROIDS OF EACH CLASS
%   Data Analysis and Visualisation Project
%   Authors: Sabyasachi Sahoo and Vineetha Kondameedi
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear
tic
%% Load Data
fprintf('Loading data\n');
load('data\PROJECTED_RELU6.mat');
load('data\RELU6.mat');
load('data\featureRELU6.mat');
classes = importdata('data\classes.txt');
data = SCORE3;

% User defined Parameters
p = 500;        % No. of principal components considered
k = 20;         % No. of clusters to be formed

toc
%% Clustering algorithm
fprintf('Clustering Data\n');
centroid = [];
start = 1;
for i = 1 : 20
    stop = start + size(RELU6{i,1},2) - 1;
    
    matrix = data( start:stop, :);
    c = mean(matrix);
    
    centroid = [centroid; c];
    start = stop + 1;
end
% orgCentroids = centroid;
% save('OriginalCentroids.mat','orgCentroids')
idx  = featureRELU6';

toc
%% Purity Analysis
fprintf('Purity Analysis\n');

% Form Purity matrix
PMat = zeros(k,20);
feat = featureRELU6';
for i = 1 : size(idx,1)
    row =  idx(i);
    col = feat(i);
    PMat( row, col) = PMat( row, col) + 1;
end
[m1, ~] = max(PMat,[],2);
total1  = sum(PMat,2);
pure1   = m1 ./ total1;
purity  = mean(pure1);

% Normalise Purity matrix
newPMat = [];
total   = sum(PMat);
for i = 1 : size(PMat,1)
    new = PMat(i,:) ./ total;
    newPMat = [newPMat; new];
end
[m2, ~] = max(newPMat,[],2);
total2  = sum(newPMat,2);
pure2   = m2 ./ total2;
normalised_purity = mean(pure2);

toc
%% Mapping clusters to original labels
fprintf('Mapping clusters to original label\n');

map = cell(k,1);
[maxm, id] = max(newPMat,[],2);
% Form 1st coloumn of clusters formed
for i = 1 : k
    map{i,1} = i;
end

% Form 2nd coloumn of original clusters
for i = 1 : k
    %%%%%%%%%%%% ENTER YOUR CODE HERE %%%%%%%%%%%%%%
    map{i,2} = id(i);
end

% Form 3rd coloumn of labels of original clusters
for i = 1 : k
    j = map{i,2};
    map{i,3} = classes{j,1};
end

toc
%% Form matrix for dendrogram
fprintf('Forming matrix for dendrogram');
Y = pdist(centroid);
S = squareform(Y);
Z = linkage(S);

toc
%% Plot Dendrogram
fprintf('Plotting dendrogram\n');
dendrogram(Z);
toc

%% Print results
purity
normalised_purity
map
