%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   GENERATE SIMILARITY MATRIX FROM "CLASSIFIER" data
%   Data Analysis and Visualisation Project
%   Authors: Sabyasachi Sahoo and Vineetha Kondameedi
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear
tic
load('data\classifier-results.mat');
load('data\RELU6.mat');

%t = zeros(21,40138);
sim_geomean    = [];
sim_harmmean   = [];
sim_mean       = [];
sim_mode       = [];
sim_median     = [];
sim_trimmean10 = [];
sim_trimmean20 = [];
percent10      = 10;
percent20      = 20;

start = 1;
for i = 1 : 20
    stride = size(RELU6{i,1},2);
    stop   = start - 1 + stride;
    
    temp = testY(1:20,start:stop);
    
    temp_geomean    = geomean( temp,2);
    temp_harmmean   = harmmean(temp,2);
    temp_mean       = mean(    temp,2);
    temp_mode       = mode(    temp,2);
    temp_median     = median(  temp,2);
    temp_trimmean10 = trimmean(temp,percent10,2);
    temp_trimmean20 = trimmean(temp,percent20,2);
    
    sim_geomean    = [sim_geomean    temp_geomean];
    sim_harmmean   = [sim_harmmean   temp_harmmean];
    sim_mean       = [sim_mean       temp_mean];
    sim_mode       = [sim_mode       temp_mode];
    sim_median     = [sim_median     temp_median];
    sim_trimmean10 = [sim_trimmean10 temp_trimmean10];
    sim_trimmean20 = [sim_trimmean20 temp_trimmean20];
    
    start = stop + 1;
end



% save('sim_geomean.mat',   'sim_geomean');
% save('sim_harmmean.mat',  'sim_harmmean');
% save('sim_mean.mat',      'sim_mean');
% save('sim_mode.mat',      'sim_mode');
% save('sim_median.mat',    'sim_median');
% save('sim_trimmean10.mat','sim_trimmean10');
% save('sim_trimmean20.mat','sim_trimmean20');

toc