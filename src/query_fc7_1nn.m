%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   EXPLORING SEMANTIC RELN B/W FC7 LAYERS USING 1NN SEARCH
%   Data Analysis and Visualisation Project
%   Authors: Sabyasachi Sahoo and Vineetha Kondameedi
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [class, obj, sim] = query_fc7_1nn(image,count,distance)

addpath C:\Users\Sabyasachi\Documents\MATLAB\PROJECT\QUERY\matconvnet\matlab
vl_setupnn;

net = load('imagenet-vgg-verydeep-16.mat');
load('net7.mat');
load('matrixRELU7.mat');
classes = importdata('classes.txt');
fprintf('Data loaded\n');

image1 = strcat('test\',image);
im  = imread(image1);
im_ = single(im) ; % note: 255 range
im_ = imresize(im_, net.normalization.imageSize(1:2)) ;
im_ = im_ - net.normalization.averageImage ;

res    = vl_simplenn(net, im_) ;
fprintf('Convolution complete\n');
relu_7 = res(36).x(:);

idx = knnsearch(matrixRELU7',relu_7','K',1,'Distance',distance);
fprintf('Match found\n');

match = matrixRELU7(:,idx);
test = net7(match);
clear net7;
testIndices = vec2ind(test);

class = classes{testIndices,1};
vector = test;

sim = cell(0);
obj = cell(0);
for i = 1 : count
    [m, id] = max(vector);
    obj = [obj; classes{id,1}];
    sim = [sim; m];
    vector(id) = 0;
end