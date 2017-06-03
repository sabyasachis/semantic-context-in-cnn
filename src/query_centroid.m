%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   EXPLORING SEMANTIC RELN B/W FC7 LAYERS W.R.T. CENTROIDS
%   Data Analysis and Visualisation Project
%   Authors: Sabyasachi Sahoo and Vineetha Kondameedi
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [class, obj, sim] = query_centroid(image,count,distance)

addpath C:\Users\Sabyasachi\Documents\MATLAB\PROJECT\QUERY\matconvnet\matlab
vl_setupnn;

net = load('imagenet-vgg-verydeep-16.mat');
load('OriginalCentroids.mat');
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

[idx, D] = knnsearch(centroid,relu_7','K',size(centroid,1),'Distance',distance);
fprintf('Clustering complete\n');

sim = cell(0);
obj = cell(0);
for i = 1 : count
    obj = [obj; classes{idx(i),1}];
    sim = [sim; D(idx(i))];
end
class = obj{1};