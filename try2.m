clear;
close all;
clc;

%Read the image
img = imread('objects1.png');

%View the image
figure,
imshow(img);

%Convert into Grayscale Image
img_gray = rgb2gray(img);
figure,
imshow(img_gray);

% Conver to a binary version of image
BW = imbinarize(img_gray, 0.7);
figure,
imshow(BW);

% Complement the image
BW1 = imcomplement(BW);
figure,
imshow(BW1);

% Fill the holes to make a solid object
BW2 = imfill(BW1,'holes');
figure,
imshow(BW2);

% Filter the image
BW3 = bwareaopen(BW2, 1);

% Remove objects that touch the border of the image
BW4 = imclearborder(BW3);

% Count the number of objects
objects = bwconncomp(BW4);
disp('Count: ');
disp(objects);
