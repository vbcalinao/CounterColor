clear;
close all;
clc;

% Load image
img = imread('objects1.png');
figure,
imshow(img);

% Convert image to LAB color space
labImg = rgb2lab(img);
figure,
imshow(labImg);

% Define color ranges for objects of interest in LAB color space
colorRanges = {[35 65; 60 85; -5 25], ... % red
               [50 70; -40 -15; 0 30], ... % green
               [20 50; -5 25; -50 -20], ... % blue
               [80 95; -15 5; 40 70], ... % yellow
               [15 40; 10 40; 10 40], ... % brown
               [0 100; -10 10; -10 10]}; ... % gray

% Create masks for each object of interest
colorMasks = cell(1, length(colorRanges));
for i = 1:length(colorRanges)
    colorMasks{i} = createColorMask(labImg, colorRanges{i});
end

% Combine masks into a single binary image
binaryImg = cat(3, colorMasks{:});
binaryImg = any(binaryImg,3);
figure,
imshow(binaryImg);

% Remove small objects from binary image
binaryImg = bwareaopen(binaryImg, 40);

% Remove objects that touch the border of the image
BW = imclearborder(binaryImg);

% Fill the holes to make a solid object
BW2 = imfill(BW,'holes');
figure,
imshow(BW2);

% Count objects in binary image and get their properties
props = regionprops(binaryImg, 'BoundingBox');

% Display original image with red bounding boxes around counted objects
figure;
imshow(img);
hold on;
for i = 1:length(props)
    bb = props(i).BoundingBox;
    rectangle('Position', bb, 'EdgeColor', 'r', 'LineWidth', 2);
    label = ['Object ', num2str(i)];
    text(bb(1), bb(2)-10, label, 'Color', 'r', 'FontSize', 11);
end
hold off;

% Display binary image with number of objects in title
numObjects = length(props);
title(['Number of Objects: ', num2str(numObjects)]);

% Function to create color mask for a given color range in LAB color space
function mask = createColorMask(img, colorRange)
    LMask = (img(:,:,1) >= colorRange(1,1)) & (img(:,:,1) <= colorRange(1,2));
    AMask = (img(:,:,2) >= colorRange(2,1)) & (img(:,:,2) <= colorRange(2,2));
    BMask = (img(:,:,3) >= colorRange(3,1)) & (img(:,:,3) <= colorRange(3,2));
    mask = LMask & AMask & BMask;
end