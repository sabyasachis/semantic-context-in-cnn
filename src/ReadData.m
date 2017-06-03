%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   READ DATA FROM 'PASCAL' DATASET & SAVE FC6, FC7 LAYERS
%   Data Analysis and Visualisation Project
%   Authors: Sabyasachi Sahoo and Vineetha Kondameedi
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear all
clc
% download a pre-trained CNN from the web
net = load('data\imagenet-vgg-verydeep-16.mat') ;
headerlinesIn = 0;
delimiterIn = ' ';
% Read the folders and files to be read
head =  'C:\Users\Sabyasachi\My Documents\MATLAB\Project\data\PASCAL\';
xml_dir         =     strcat(head,'Annotations');
jpeg_dir        =     strcat(head,'JPEGImages');

xml_list     =        dir(fullfile(xml_dir));
jpeg_list    =        dir(fullfile(jpeg_dir));

class_list = importdata('data\classes.txt');

FC6 = cell(20,1);
FC7 = cell(20,1);
RELU6 = cell(20,1);
RELU7 = cell(20,1);
SCORE = cell(20,1);

for i = 3 : numel(jpeg_list)
    disp(i);
    Filename = jpeg_list(i).name;
    path1 =  strcat(jpeg_dir,'\',Filename);
    im    =  imread(path1);
    
    xmlFilename = xml_list(i).name;
    path2 = strcat(xml_dir,'\',xmlFilename);
    Doc = xml2struct(path2);
    
    if size(Doc.annotation.object,2) > 1
        % If number of objects in image > 1
        for k = 1 : size(Doc.annotation.object,2)
            xmin = str2num(Doc.annotation.object{1,k}.bndbox.xmin.Text);
            ymin = str2num(Doc.annotation.object{1,k}.bndbox.ymin.Text);
            xmax = str2num(Doc.annotation.object{1,k}.bndbox.xmax.Text);
            ymax = str2num(Doc.annotation.object{1,k}.bndbox.ymax.Text);
            
            width  = xmax - xmin;
            height = ymax - ymin;
            
            bounds = [xmin ymin width height];
            im2        =  imcrop(im, bounds);
            im_        = single(im2) ; % note: 255 range
            im_ = imresize(im_, net.normalization.imageSize(1:2)) ;
            im_ = im_ - net.normalization.averageImage ;
            
            res   = vl_simplenn(net, im_) ;
            fc_6 = res(33).x(:);
            relu_6 = res(34).x(:);
            fc_7 = res(35).x(:);
            relu_7 = res(36).x(:);
            score = res(38).x(:);
            
            classname = Doc.annotation.object{1,k}.name.Text;
            for j = 1: numel(class_list)
                if(isequal(classname, class_list{j}))
                    FC6{j}      = [FC6{j} fc_6];
                    FC7{j}      = [FC7{j} fc_7];
                    RELU6{j} = [RELU6{j} relu_6];
                    RELU7{j} = [RELU7{j} relu_7];
                    SCORE{j} = [SCORE{j} score];
                    break;
                end
            end
        end
        
    else
        % If number of objects in image = 1
        xmin = str2num(Doc.annotation.object.bndbox.xmin.Text);
        ymin = str2num(Doc.annotation.object.bndbox.ymin.Text);
        xmax = str2num(Doc.annotation.object.bndbox.xmax.Text);
        ymax = str2num(Doc.annotation.object.bndbox.ymax.Text);
        
        width  = xmax - xmin;
        height = ymax - ymin;
        
        bounds = [xmin ymin width height];
        im2        = imcrop(im, bounds);
        im_        = single(im2) ; % note: 255 range
        im_        = imresize(im_, net.normalization.imageSize(1:2)) ;
        im_        = im_ - net.normalization.averageImage ;
        
        res       = vl_simplenn(net, im_) ;
        fc_6     = res(33).x(:);
        relu_6 = res(34).x(:);
        fc_7     = res(35).x(:);
        relu_7 = res(36).x(:);
        score   = res(38).x(:);
        
        classname = Doc.annotation.object.name.Text;
        for j = 1: numel(class_list)
            if isequal(classname, class_list{j})
                FC6{j}      = [FC6{j} fc_6];
                FC7{j}      = [FC7{j} fc_7];
                RELU6{j} = [RELU6{j} relu_6];
                RELU7{j} = [RELU7{j} relu_7];
                SCORE{j} = [SCORE{j} score];
                break;
            end
        end
        
    end
end

save('FC6');
save('FC7');
save('RELU6');
save('RELU7');
save('SCORE');