% Load image
img = imread('colorful-objects.jpg');

% Convert image to HSV color space
hsvImg = rgb2hsv(img);

% Define color ranges for objects of interest
redRange = [0, 0.1; 0.8, 1; 0.6, 1];
greenRange = [0.2, 0.5; 0.4, 1; 0.4, 1];
blueRange = [0.5, 0.7; 0.4, 1; 0.4, 1];

% Create masks for each object of interest
redMask = createColorMask(hsvImg, redRange);
greenMask = createColorMask(hsvImg, greenRange);
blueMask = createColorMask(hsvImg, blueRange);

% Remove small objects from each mask
redMask = bwareaopen(redMask, 100);
greenMask = bwareaopen(greenMask, 100);
blueMask = bwareaopen(blueMask, 100);

% Display masks and count objects
figure;
subplot(1, 3, 1);
imshow(redMask);
title(['Red Objects: ', num2str(sum(redMask(:)))]);

subplot(1, 3, 2);
imshow(greenMask);
title(['Green Objects: ', num2str(sum(greenMask(:)))]);

subplot(1, 3, 3);
imshow(blueMask);
title(['Blue Objects: ', num2str(sum(blueMask(:)))]);

% Function to create color mask for a given color range
function mask = createColorMask(img, colorRange)
    hueMask = (img(:,:,1) >= colorRange(1,1)) & (img(:,:,1) <= colorRange(1,2));
    satMask = (img(:,:,2) >= colorRange(2,1)) & (img(:,:,2) <= colorRange(2,2));
    valMask = (img(:,:,3) >= colorRange(3,1)) & (img(:,:,3) <= colorRange(3,2));
    mask = hueMask & satMask & valMask;
end