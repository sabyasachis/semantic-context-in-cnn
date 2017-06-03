%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%	HELP TEXT FILE TO RUN VARIOUS PARTS OF "PROJECT" FOLDER
%	Data Analysis and Visualisation Project
%	Authors: Sabyasachi Sahoo and Vineetha Kondameedi
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

Upon entering the "PROJECT" folder, you will see many files and folders related to our DAV Project. In the following lines, we describe about them:

All the MATLAB files you see in this directory are used either for reading of data or for "Exploring semantic relationships".
The "data" folder contains all the data that you will need, if you want to run any of the MATLAB files in "PROJECT" folder. 
It also contains some additional data (eg: Similarity matrix) which can also be generated from SimilarityMatrix.m MATLAB file.

The image dataset that we used is: PASCAL. However, these MATLAB files can also be made to run on other datasets like ImageNet dataset, etc.
The CNN used was trained on ImageNet dataset to generate the FC6 and FC7 layer vectors for images from PASCAL dataset.

The "Plots" folder contains two dendrogram plot, one obtained from hierarchical clustering of all 20 classes (by their representative centroids) of FC7 layer vectors, and
second obtained from hierarchical clustering of all 20 classes (by their representative centroids) of SCORE vectors (which was generated after those FC7 vectors of 
all the images were passed through a pre-trained ANN).

The "QUERY" folder contains list of all the functions used for Improving Image Classification using the semantic relations present in FC7 layer vectors.


THE SEQUENCE OF STEPS TO EXPLORE SEMANTIC RELATIONSHIPS IS LISTED AS FOLLOWS:
In MATLAB Command window, enter following:
go to QUERY\matconvnet\matlab
Enter "vl_setupnn"
Come back to "PROJECT" folder. And run the following codes:
ReadData.m				: This MATLAB file is used to read images from PASCAL dataset, generate (using CNN) and store the FC6 and FC7 layer vectors.
DimensionReduction.m	: This MATLAB file applies PCA and FDA dimensionality reduction techniques on FC6 and FC7 vectors.
GenerateSmallDataset.m	: This MATLAB file selects only first 500 FC7 vectors of every class and genrates a small dataset.
kMeans.m				: This MATLAB file does kMeans clustering for varying value of 'k'.
AggloClust.m			: This MATLAB file performs hierarchical clustering of all 20 classes (by their representative centroids) of FC7 layer vectors.
BarPlots.m				: This MATLAB file can be used to generate bar plots after applying kMeans on dimensionally reduced FC6 vectors.
Classify.m				: This MATLAB file is used to train an ANN for generating 20 dimensional score vector for each of the object in PASCAL Dataset.
SimilarityMatrix.m		: This MATLAB file is used to form a similarity matrix among 20 object classes using SCORE vectors generated from FC7 vectors at previous step.
Dend4mSim.m				: This MATLAB file is used to plot dendrogram from Similarity Matrix generated in previous step.

THE SEQUENCE OF STEPS TO IMPROVE IMAGE CLASSIFICATION USING SEMANTIC RELATIONSHIPS IN FC7 VECTORS AS FOLLOWS:
In MATLAB Command window, enter following:
go to QUERY\matconvnet\matlab
Enter "vl_setupnn"
Come back to "PROJECT\QUERY" folder. 
Set some image already stored in "test" folder, eg: image = 'ufo.jpg'.
Set value of count, eg: count = 5.
Set distance measure to be used, eg: distance = 'euclidean'.
And then following functions can be used as follows:
[class, obj, sim] = query(image,count)
[class, obj, sim] = query_fc7_1nn(image,count,distance)
[class, obj, sim] = query_score_1nn(image,count,distance)
[class, obj, sim] = query_score_knn(image,count,distance)

[objects] = query_kmeans(image,distance)
[class, obj, sim] = query_centroid(image,count,distance)

Set input as some object class, eg: input = 'person';
[OBJ, SIM] = query_similarity(input,count)
