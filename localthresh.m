function imgout = localthresh(img, ssize, msize, sthresh, mthresh, varargin)
%LOCALTHRESH performs local adaptive thresholding. 
%  imgout = localthresh(img, ssize, msize, sweight, mweight) separates 
%  foreground from background using local mean and standard deviation.
%  ssize is neighborhood size for calculating standard deviation and must
%  be an odd number. msize is neighborhood size for calculating mean. 
%  imgout is a binary image, with foreground being 1 and backgroud being 0.
%
%  optional : 
%  imgout = localthresh(img, ssize, msize, sweight, mweight, 'global') uses
%  global mean instead for segmentation. 
%
% Copyright Chao-Yuan Yeh, 2016

if mod(ssize, 2) ~= 1
    error('ssize must be an odd number!')
end

% turn rgb image into grayscale
if length(size(img))==3
    img = rgb2gray(img);
end

img = im2double(img);
ssize = ones(ssize);

img_stdfiltered = stdfilt(img, ssize);
if any(strcmpi(varargin, 'global'))
    img_meanfiltered = mean2(img);
else
    mfilter = ones(msize) / (msize^2);
    img_meanfiltered = imfilter(img, mfilter, 'replicate');
end

% Obtain segmented image. 
imgout = (img > sthresh * img_stdfiltered) & ...
    (img > mthresh * img_meanfiltered);
end

