close all; clear; clc;
format long g;
format compact;
captionFontSize = 14;
%% Load Images
%  images{n}    = imread(sprintf('~/Documents/Class/Data Science/Project_pictures/uiowa/skin_tumor/ski_%02d.jpg',n));
%  originalImage    = imread('~/Documents/Class/Data Science/Project_pictures/uiowa/skin_tumor/ski_05.jpg');
%  originalImage    = imread('~/Documents/Class/Data Science/Project_pictures/uiowa/christmas_tree_rash/pit_02.jpg');
%  originalImage    = imread('~/Documents/Class/Data Science/Project_pictures/uiowa/psoriasis/pso_05.jpg');
originalImage = imread('C:\Users\User\Documents\Class\Data Science\Project_pictures\Final_Images\Malignant Melanoma\Filtered_mel_138.jpg') ;
% Check to make sure that it is grayscale, just in case the user substituted their own image.
[rows, columns, numberOfColorChannels] = size(originalImage);
if numberOfColorChannels > 1
	originalImage = rgb2gray(originalImage);
end
%% Display the grayscale image.
subplot(2, 2, 1);
imshow(originalImage);
title('original image grayscale')

%% Enhance contrast of image
enhancedImaged = adapthisteq(originalImage,'clipLimit',0.005,'Distribution','Rayleigh');
%imshowpair(I,J,'montage');

%% Display the Enhanced Image
subplot(2, 2, 2);
imshow(enhancedImaged);
title('Contrast enhanced image')

% Maximize the figure window.
set(gcf, 'units','normalized','outerposition',[0 0 1 1]);
% Force it to display RIGHT NOW (otherwise it might not display until it's all done, unless you've stopped at a breakpoint.)
drawnow;
axis image; % Make sure image is not artificially stretched because of screen's aspect ratio.

% display grayscale histogram
[pixelCount, grayLevels] = imhist(enhancedImaged);
subplot(2, 2, 3);
bar(pixelCount); %gray colors
title('Histogram of Enhanced image', 'FontSize', captionFontSize);
xlim([0 grayLevels(end)]); % Scale x axis manually.
grid on;

% Threshold the image to get a binary image (only 0's and 1's) of class "logical."
% Method #1: using im2bw()
%   normalizedThresholdValue = 0.5; % In range 0 to 1.
%   thresholdValue = normalizedThresholdValue * mean(mean(originalImage)); % Gray Levels.
%   binaryImage    = imbinarize(originalImage, normalizedThresholdValue);       % One way to threshold to binary

% Method #2: using a logical operation.
%thresholdValue = 100;
%binaryImage = originalImage < thresholdValue; % Bright objects will be chosen if you use >.

% Method #3: Peak value
[pks,locs] = findpeaks(pixelCount,grayLevels,'MinPeakDistance',80);% additionally returns the indices at which the peaks occur.
thresholdValue = ( locs(1)+locs(2) )/2;
binaryImage = enhancedImaged < thresholdValue; % Bright objects will be chosen if you use >.

% ========== IMPORTANT OPTION ============================================================
% Use < if you want to find dark objects instead of bright objects.
%   binaryImage = originalImage < thresholdValue; % Dark objects will be chosen if you use <.

% Do a "hole fill" to get rid of any background pixels or "holes" inside the blobs.
binaryImage = imfill(binaryImage, 'holes');
    
% Show the threshold as a vertical red bar on the histogram.
hold on;
maxYValue = ylim;
findpeaks(pixelCount,grayLevels,'MinPeakDistance',100);% additionally returns the indices at which the peaks occur.
line([thresholdValue, thresholdValue], maxYValue, 'Color', 'r');
% Place a text label on the bar chart showing the threshold.
annotationText = sprintf('Thresholded at %d gray levels', thresholdValue);
% For text(), the x and y need to be of the data class "double" so let's cast both to double.
text(double(thresholdValue + 5), double(0.5 * maxYValue(2)), annotationText, 'FontSize', 10, 'Color', [0 .5 0]);
text(double(thresholdValue - 70), double(0.94 * maxYValue(2)), 'Background', 'FontSize', 10, 'Color', [0 0 .5]);
text(double(thresholdValue + 50), double(0.94 * maxYValue(2)), 'Foreground', 'FontSize', 10, 'Color', [0 0 .5]);

% Display the binary image.
subplot(2, 2, 4);
imshow(binaryImage); 
title('Binary Image, obtained by thresholding', 'FontSize', captionFontSize); 


