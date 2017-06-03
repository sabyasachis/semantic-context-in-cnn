%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   IDEAL IMAGE CLASSIFICATION USING 1 HIDDEN LAYERED ANN
%   Data Analysis and Visualisation Project
%   Authors: Sabyasachi Sahoo and Vineetha Kondameedi
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [class, obj, sim] = query(image,count)
addpath C:\Users\Sabyasachi\Documents\MATLAB\PROJECT\QUERY\matconvnet\matlab
vl_setupnn;
net = load('imagenet-vgg-verydeep-16.mat');
load('net7.mat')
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

testY = net7(relu_7);
clear net7;
testIndices = vec2ind(testY);

input = classes{testIndices,1};
class = input;

vector = testY;
sim = cell(0);
obj = cell(0);
for i = 1 : count
    [m, id] = max(vector);
    obj = [obj; classes{id,1}];
    sim = [sim; m];
    vector(id) = 0;
end
