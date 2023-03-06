function mask = createMask(img, colorRange)
% Create binary mask for the specified color range
% img: input image
% colorRange: a 6-element vector [rmin rmax gmin gmax bmin bmax]

rmin = colorRange(1);
rmax = colorRange(2);
gmin = colorRange(3);
gmax = colorRange(4);
bmin = colorRange(5);
bmax = colorRange(6);

mask = (img(:,:,1) >= rmin) & (img(:,:,1) <= rmax) & ...
       (img(:,:,2) >= gmin) & (img(:,:,2) <= gmax) & ...
       (img(:,:,3) >= bmin) & (img(:,:,3) <= bmax);
end