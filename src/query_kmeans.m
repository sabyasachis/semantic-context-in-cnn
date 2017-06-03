%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   EXPLORING SEMANTIC RELN B/W FC6 LAYERS USING kMEANS
%   Data Analysis and Visualisation Project
%   Authors: Sabyasachi Sahoo and Vineetha Kondameedi
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [objects] = query_kmeans(image,distance)

addpath C:\Users\Sabyasachi\Documents\MATLAB\PROJECT\QUERY\matconvnet\matlab
vl_setupnn;

net = load('imagenet-vgg-verydeep-16.mat');
load('centroid_k64.mat');
class = importdata('classes.txt');
load('COEFF_RELU6.mat');
load('clusterKM_64.mat');
fprintf('Data loaded\n');

image1 = strcat('test\',image);
im  = imread(image1);
im_ = single(im) ; % note: 255 range
im_ = imresize(im_, net.normalization.imageSize(1:2)) ;
im_ = im_ - net.normalization.averageImage ;

res    = vl_simplenn(net, im_) ;
fprintf('Convolution complete\n');
relu_6 = res(34).x(:);
relu_6 = relu_6'*COEFF3;
%relu_6 = relu_6';

[idx, D] = knnsearch(centroid,relu_6(1,1:64),'K',size(centroid,1),'Distance',distance);
fprintf('Clustering complete\n');
idx';
objects = cell(0);
i = 1;
flag = 1;
while (i <size(centroid,1) && flag)
    center = clusterKM_64{idx(i),22};
    if (size((center),2))
        fprintf(' the object falls into cluster having following objects\n');
        for j = 1 : size(center,2)
            objects  =  [ objects; class{center(j),1}];
        end
        flag = 0;
    else
        i = i+1;
        %fprintf('falls into cluster with no previous objects');
    end
end




