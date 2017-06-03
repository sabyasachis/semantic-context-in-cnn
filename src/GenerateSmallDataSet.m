%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   RANDOM SAMPLING FROM EACH CLASS TO REDUCE SIZE OF DATA
%   Data Analysis and Visualisation Project
%   Authors: Sabyasachi Sahoo and Vineetha Kondameedi
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear
load('data\Z_RELU6.mat')
load('data\PROJECTED_RELU6.mat')
load('data\RELU6.mat')
fda_relu6 = Z3;
pca_relu6 = SCORE3(:,1:200)';

features = [];
pcadata  = [];
fdadata  = [];
start = 1;
for i = 1 : 20
    stop  = start + 500 - 1;
    fdadata  = [fdadata fda_relu6(:,start:stop)];
    pcadata  = [pcadata pca_relu6(:,start:stop)];
    temp     = i*ones(1,500);
    features = [features temp];
    start = size(RELU6{i,1},2) + 1;
end

features = features';
fdadata = fdadata';
pcadata = pcadata';
save('fdadata.mat','fdadata');
save('pcadata.mat','pcadata');
save('features.mat','features');