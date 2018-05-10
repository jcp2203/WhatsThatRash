close all; clear; clc;
%% Load Images
for n=1:5
  images{n} = imread(sprintf('~/Documents/Class/Data Science/Project_pictures/uiowa/skin_tumor/ski_%02d.jpg',n));
end
%I=imread('~/Documents/Class/Data Science/Project_pictures/uiowa/skin_tumor/ski_01.jpg');

%% convert to grayscale intensity image
for n=1:5
    G{n} = rgb2gray(images{n});
end

%% display intensity of grayscale image 
imhist(G{2});
 
%imshow(G{2});

