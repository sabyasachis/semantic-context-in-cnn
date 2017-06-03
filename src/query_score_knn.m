%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   EXPLORING SEMANTIC RELN B/W SCORES USING kNN SEARCH
%   Data Analysis and Visualisation Project
%   Authors: Sabyasachi Sahoo and Vineetha Kondameedi
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [class, obj, sim] = query_score_knn(image,count,distance)

addpath C:\Users\Sabyasachi\Documents\MATLAB\PROJECT\QUERY\matconvnet\matlab
vl_setupnn;

net = load('imagenet-vgg-verydeep-16.mat');
load('net7.mat');
load('testY7.mat');
load('featureRELU7.mat')
classes = importdata('classes.txt');
fprintf('Data loaded\n');

image2 = strcat('test\',image);
im  = imread(image2);
im_ = single(im) ; % note: 255 range
im_ = imresize(im_, net.normalization.imageSize(1:2)) ;
im_ = im_ - net.normalization.averageImage ;

res    = vl_simplenn(net, im_) ;
clear net;
fprintf('Convolution complete\n');

relu_7 = res(36).x(:);
test = net7(relu_7);
clear net7;

[idx, D] = knnsearch(testY7',test','K',size(testY7,2),'Distance',distance);

check = zeros(20,1);
i = 1;
flag = 1;
sim = cell(0);
obj = cell(0);
imageId = cell(0);
while i <= size(idx,2) && flag
    
    temp = featureRELU7(idx(i));
    if check(temp) == 0
        check(temp) = 1;
        obj         = [obj; classes{temp,1}];
        sim         = [sim; (1e-4)/D(i)];
        imageId     = [imageId; idx(i)];
    end
    
    total = sum(check);
    if total >= count;
        flag = 0;
    end
    i = i + 1;
end
class = obj{1};
fprintf('Match found\n');