close all; clear; clc;

%% Load image
I=imread('~/Documents/Class/Data Science/Project_pictures/uiowa/skin_tumor/ski_01.jpg');

%% separate R G B intensities
R=imhist(I(:,:,1));
G=imhist(I(:,:,2));
B=imhist(I(:,:,3));

%% plot RGB channels onto a single graph
figure, plot(R,'r')
hold on, plot(G,'g')
plot(B,'b'), legend(' Red channel','Green channel','Blue channel');
hold off,

