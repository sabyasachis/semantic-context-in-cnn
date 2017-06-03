%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   CLASSIFY RELU6 &/OR RELU7 4096xN VECTORS
%   Data Analysis and Visualisation Project
%   Authors: Sabyasachi Sahoo and Vineetha Kondameedi
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear
%% Why Neural Networks?
% Neural networks are very good at pattern recognition problems.  A neural
% network with enough elements (called neurons) can classify any data with
% arbitrary accuracy. They are particularly well suited for complex
% decision boundary problems over many variables. Therefore neural networks
% are a good candidate for solving the wine classification problem.
%
% The thirteeen neighborhood attributes will act as inputs to a neural
% network, and the respective target for each will be a 3-element class
% vector with a 1 in the position of the associated winery, #1, #2 or #3.
%
% The network will be designed by using the attributes of neighborhoods
% to train the network to produce the correct target classes.
%
%% Preparing the Data
% Data for classification problems are set up for a neural network by
% organizing the data into two matrices, the input matrix X and the target
% matrix T.

tic
load('data\matrixRELU6.mat');
load('data\RELU6.mat')
x = matrixRELU6;
t = zeros(21,40138);
start = 1;
for i = 1 : 20
    stride = size(RELU6{i,1},2);
    stop   = start - 1 + stride;
    for j = start : stop
        t(i,j) = 1;
    end
    start = stop + 1;
end
clear RELU6
clear matrixRELU6

%% Pattern Recognition with a Neural Network
% The next step is to create a neural network that will learn to classify
% the wines.
%
% Since the neural network starts with random initial weights, the results
% of this example will differ slightly every time it is run. The random seed
% can be set to avoid this randomness. However this is not necessary.

temp = rand(1);
setdemorandstream(temp)
%setdemorandstream(391418381)

%%
% Two-layer (i.e. one-hidden-layer) feed forward neural networks can learn
% any input-output relationship given enough neurons in the hidden layer.
% Layers which are not output layers are called hidden layers.
%
% The input and output have sizes of 0 because the network has not yet
% been configured to match our input and target data.  This will happen
% when the network is trained.

neuroncount = 25;
net = patternnet(neuroncount);
view(net)

%%
% Now the network is ready to be trained. The samples are automatically
% divided into training, validation and test sets. The training set is
% used to teach the network. Training continues as long as the network
% continues improving on the validation set. The test set provides a
% completely independent measure of network accuracy.
%
% The NN Training Tool shows the network being trained and the algorithms
% used to train it.  It also displays the training state during training
% and the criteria which stopped training will be highlighted in green.
%
% The buttons at the bottom  open useful plots which can be opened during
% and after training.  Links next to the algorithm names and plot buttons
% open documentation on those subjects.

net.trainParam.max_fail = 200;
net.trainParam.min_grad = 1e-8;
net.trainParam.time = 7 * 3600;
[net,tr] = train(net,x,t);
nntraintool

%%
% To see how the network's performance improved during training, either
% click the "Performance" button in the training tool, or call PLOTPERFORM.
%
% Performance is measured in terms of mean squared error, and shown in
% log scale.  It rapidly decreased as the network was trained.
%
% Performance is shown for each of the training, validation and test sets.
% The version of the network that did best on the validation set is
% was after training.
hold on
plotperform(tr)

%% Testing the Neural Network
% The mean squared error of the trained neural network can now be measured
% with respect to the testing samples. This will give us a sense of how
% well the network will do when applied to data from the real world.
%
% The network outputs will be in the range 0 to 1, so we can use *vec2ind*
% function to get the class indices as the position of the highest element
% in each output vector.

%testX = x(:,tr.testInd);
%testT = t(:,tr.testInd);

%testY = net(testX);
testY = net(x);
toc
testT = t;
testIndices = vec2ind(testY);

%%
% Another measure of how well the neural network has fit the data is the
% confusion plot.  Here the confusion matrix is plotted across all samples.
%
% The confusion matrix shows the percentages of correct and incorrect
% classifications.  Correct classifications are the green squares on the
% matrices diagonal.  Incorrect classifications form the red squares.
%
% If the network has learned to classify properly, the percentages in the
% red squares should be very small, indicating few misclassifications.
%
% If this is not the case then further training, or training a network
% with more hidden neurons, would be advisable.

plotconfusion(testT,testY)

%%
% Here are the overall percentages of correct and incorrect classification.

[c,cm] = confusion(testT,testY);

fprintf('Percentage Correct Classification   : %f%%\n', 100*(1-c));
fprintf('Percentage Incorrect Classification : %f%%\n', 100*c);

%%
% A third measure of how well the neural network has fit data is the
% receiver operating characteristic plot.  This shows how the false
% positive and true positive rates relate as the thresholding of outputs
% is varied from 0 to 1.
%
% The farther left and up the line is, the fewer false positives need to
% be accepted in order to get a high true positive rate.  The best
% classifiers will have a line going from the bottom left corner, to the
% top left corner, to the top right corner, or close to that.

% plotroc(testT,testY)

%%
% This example illustrated how to design a neural network that classifies
% wines into three wineries from each wine's characteristics.
%
% Explore other examples and the documentation for more insight into neural
% networks and their applications. 

% displayEndOfDemoMessage(mfilename)

% % Elapsed time is 2228.574858 seconds.
% % Percentage Correct Classification   : 90.886442%
% % Percentage Incorrect Classification : 9.113558%