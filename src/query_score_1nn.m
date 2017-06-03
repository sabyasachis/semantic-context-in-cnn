%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   EXPLORING SEMANTIC RELN B/W SCORES USING 1NN SEARCH
%   Data Analysis and Visualisation Project
%   Authors: Sabyasachi Sahoo and Vineetha Kondameedi
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [class, obj, sim] = query_score_1nn(image,count,distance)

addpath C:\Users\Sabyasachi\Documents\MATLAB\PROJECT\QUERY\matconvnet\matlab
vl_setupnn;

net = load('imagenet-vgg-verydeep-16.mat');
load('net7.mat');
load('testY7.mat');
classes = importdata('classes.txt');
fprintf('Data loaded\n');

image1 = strcat('test\',image);
im  = imread(image1);
im_ = single(im) ; % note: 255 range
im_ = imresize(im_, net.normalization.imageSize(1:2)) ;
im_ = im_ - net.normalization.averageImage ;

res    = vl_simplenn(net, im_) ;
clear net;
fprintf('Convolution complete\n');

relu_7 = res(36).x(:);
test = net7(relu_7);
clear net7;

idx = knnsearch(testY7',test','K',1,'Distance',distance);

vector = testY7(:,idx);
testIndices = vec2ind(vector);
class = classes{testIndices,1};
clear testY7;

sim = cell(0);
obj = cell(0);
for i = 1 : count
    [m, id] = max(vector);
    obj = [obj; classes{id,1}];
    sim = [sim; m];
    vector(id) = 0;
end