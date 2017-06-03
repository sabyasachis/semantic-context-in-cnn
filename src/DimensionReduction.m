%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   DOING PCA AND FDA DIMENSIONALITY REDUCTION ON DATA
%   Data Analysis and Visualisation Project
%   Authors: Sabyasachi Sahoo and Vineetha Kondameedi
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear all
clc
tic
r = 19;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
load('data\temp\matrixFC6');
load('data\temp\featureFC6');
fprintf('Good\n');

% PCA
[COEFF1, SCORE1, LATENT1, ~, EXPLAINED1, ~] = pca( matrixFC6');
fprintf('PCA for FC6 done!\n');

%LDA
[Z1 , W1 ] =  FDA( matrixFC6, featureFC6', r);
fprintf('FDA for FC6 done!\n\n');

save('COEFF_FC6.mat','COEFF1');
save('PROJECTED_FC6.mat','SCORE1');
save('EIGENVALUE_FC6.mat','LATENT1');
save('EXPLAINED_FC6.mat','EXPLAINED1');
save('Z_FC6.mat','Z1');
save('W_FC6.mat','W1');

clear matrixFC6
clear featureFC6
clear COEFF1
clear SCORE1
clear LATENT1
clear EXPLAINED1
clear Z1
clear W1

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
load('data\temp\matrixFC7');
load('data\temp\featureFC7');
fprintf('Good\n');

% PCA
[COEFF2, SCORE2, LATENT2, ~, EXPLAINED2, ~] = pca( matrixFC7');
fprintf('PCA for FC7 done!\n');

%LDA
[Z2 , W2 ] =  FDA( matrixFC7, featureFC7', r);
fprintf('FDA for FC7 done!\n\n');

save('COEFF_FC7.mat','COEFF2');
save('PROJECTED_FC7.mat','SCORE2');
save('EIGENVALUE_FC7.mat','LATENT2');
save('EXPLAINED_FC7.mat','EXPLAINED2');
save('Z_FC7.mat','Z2');
save('W_FC7.mat','W2');

clear matrixFC7
clear featureFC7
clear COEFF2
clear SCORE2
clear LATENT2
clear EXPLAINED2
clear Z2
clear W2

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
load('data\matrixRELU6');
load('data\featureRELU6');
fprintf('Good\n');

% PCA
[COEFF3, SCORE3, LATENT3, ~, EXPLAINED3, ~] = pca( matrixRELU6');
fprintf('PCA for RELU6 done!\n');

%LDA
[Z3 , W3 ] =  FDA( matrixRELU6, featureRELU6', r);
fprintf('PCA for RELU6 done!\n\n');

save('COEFF_RELU6.mat','COEFF3');
save('PROJECTED_RELU6.mat','SCORE3');
save('EIGENVALUE_RELU6.mat','LATENT3');
save('EXPLAINED_RELU6.mat','EXPLAINED3');
save('Z_RELU6.mat','Z3');
save('W_RELU6.mat','W3');

clear matrixRELU6
clear featureRELU6
clear COEFF3
clear SCORE3
clear LATENT3
clear EXPLAINED3
clear Z3
clear W3

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
load('data\matrixRELU7');
load('data\featureRELU7');
fprintf('Good\n');

% PCA
[COEFF4, SCORE4, LATENT4, ~, EXPLAINED4, ~] = pca( matrixRELU7');
fprintf('PCA for RELU7 done!\n');

%LDA
[Z4 , W4 ] =  FDA( matrixRELU7, featureRELU7', r);
fprintf('PCA for RELU7 done!\n\n');

save('COEFF_RELU7.mat','COEFF4');
save('PROJECTED_RELU7.mat','SCORE4');
save('EIGENVALUE_RELU7.mat','LATENT4');
save('EXPLAINED_RELU7.mat','EXPLAINED4');
save('Z_RELU7.mat','Z4');
save('W_RELU7.mat','W4');

clear matrixRELU7
clear featureRELU7
clear COEFF4
clear SCORE4
clear LATENT4
clear EXPLAINED4
clear Z4
clear W4

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
fprintf('Data Read complete\n\n');
toc
