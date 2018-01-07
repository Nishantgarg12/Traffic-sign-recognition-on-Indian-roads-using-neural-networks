load('stopSigns.mat');
%%
% Add the images location to the MATLAB path.
imDir = fullfile(matlabroot,'toolbox','vision','visiondata','stopSignImages');
imDir1= fullfile(matlabroot,'toolbox','vision','visiondata','keeprightSignImages');
addpath(imDir,imDir1);
%%
% Specify the folder for negative images.
negativeFolder = fullfile(matlabroot,'toolbox','vision','visiondata','nonStopSigns');
neg1=fullfile(matlabroot,'toolbox','vision','visiondata','nonkeeprightSignImages');
%%
% Train a cascade object detector called 'stopSignDetector.xml' using HOG features. The following command may take several minutes to run:
trainCascadeObjectDetector('stopSignDetector.xml',data,negativeFolder,'FalseAlarmRate',0.2,'NumCascadeStages',5);
trainCascadeObjectDetector('keeprightsigndetector.xml',data,neg1,'FalseAlarmRate',0.1,'NumCascadeStages',5);
%%
% Use the newly trained classifier to detect a stop sign in an image.
detector = vision.CascadeObjectDetector('stopSignDetector.xml');
%%
% Read the test image.
img = imread('donotenter.jpg');
%%
% Detect a stop sign.
bbox = step(detector,img);
bbox1=step(detector1,img);
%%
% Insert bounding boxes and return marked image.
detectedImg = insertObjectAnnotation(img,'rectangle',bbox,'stop sign');
detectedImg1 = insertObjectAnnotation(img,'rectangle',bbox1,'Keep right');
% Display the detected stop sign.
figure;
imshow(detectedImg);
figure;
imshow(detectedImg1);
% Remove the image directory from the path.