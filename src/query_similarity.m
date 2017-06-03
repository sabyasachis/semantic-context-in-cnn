%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   EXPLORING SEMANTIC RELN B/W CLASSES USING SIMILARITY MAT
%   Data Analysis and Visualisation Project
%   Authors: Sabyasachi Sahoo and Vineetha Kondameedi
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [OBJ, SIM] = query_similarity(input,count)

load('sim_mean7.mat')
classes = importdata('classes.txt');
matrix = sim_mean;
clear sim_mean;

for i = 1 : 20
    matrix(i,i) = 0;
end

for i = 1 : 20
    if strcmp(input,classes{i,1})
        j = i;
    end
end

vector = matrix(j,:)';
clear matrix;

SIM = cell(0);
OBJ = cell(0);
for i = 1 : count
    [m, id] = max(vector);
    OBJ = [OBJ; classes{id,1}];
    SIM = [SIM; m];
    vector(id) = 0;
end