close all; clc; clear all

addpath 'C:\Users\User\Documents\Class\Data Science\Project_pictures\Final_Images\Psoriasis\'
 
imagefiles=dir('C:\Users\User\Documents\Class\Data Science\Project_pictures\Final_Images\Psoriasis\*.jpg'); 
nfiles = length(imagefiles);    % Number of files found

for n = 1:nfiles 
    currentfilename = imagefiles(n).name;
    currentimage = imread(currentfilename);
    images{n} = currentimage;
    I{n}   = rgb2hsv(images{n}); 
end

