%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   GENERATE DENDROGRAM PLOT FROM ANY SIMILARITY MATRIX
%   Data Analysis and Visualisation Project
%   Authors: Sabyasachi Sahoo and Vineetha Kondameedi
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear
load('data\sim_mean.mat')
classes = importdata('data\classes.txt');
mat_mean = sim_mean;

for i = 1 : 20
    mat_mean(i,i) = 0;
end

mat_mean = (mat_mean + mat_mean') ./ 2;

% Actual way of generating dendrogram
Z = [];
visited = [];
s = 21;
for i = 1 : 19
    [m1,i1] = max(mat_mean);
    [m2,i2] = max(m1);
    
    row    = (i1(i2));
    col    = (i2);
    invsim = 1 / m2;
    
    temp1   = row;
    temp2   = col;
    tempmat = (mat_mean(row,:) + mat_mean(col,:)) ./2;
    
    for j = 1 : size(visited,1)
        if visited(j,1) == row
            temp1 = visited(j,2);
        end
        if visited(j,1) == col
            temp2 = visited(j,2);
        end
    end
    
    Z = [Z ; temp1 temp2 invsim];
    
    visited = [visited; temp1 s];
    visited = [visited; temp2 s];
    s = s + 1;
    
    mat_mean(row,:) = tempmat;
    mat_mean(:,row) = tempmat';
    
    mat_mean(col,:) = 0;
    mat_mean(:,col) = 0;
    mat_mean(row,row) = 0;
    %clear('mat_mean');
end

dendrogram(Z,'Orientation','right','Labels',classes,'ColorThreshold',100);
