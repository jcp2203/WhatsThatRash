close all; clear; clc;
%% Load Images
nmax = 5;
for n=1:nmax
  images{n} = imread(sprintf('~/Documents/Class/Data Science/Project_pictures/uiowa/skin_tumor/ski_%02d.jpg',n));
end
%I=imread('~/Documents/Class/Data Science/Project_pictures/uiowa/skin_tumor/ski_01.jpg');

%% convert to grayscale intensity image
for n=1:5
    G{n} = rgb2gray(images{n});
    average{n} = mean(mean(G{n}));
end

%% display intensity of grayscale image 
for n = randi([1 nmax],1,1)
    imhist(G{n});
    fprintf('average is: %2d',average{n}) 
end
    


