close all; clear; clc;

%% Load image
nmax = 5;
%for n=1:nmax
%  images{n}    = imread(sprintf('~/Documents/Class/Data Science/Project_pictures/uiowa/skin_tumor/ski_%02d.jpg',n));
%  images    = imread('~/Documents/Class/Data Science/Project_pictures/uiowa/skin_tumor/ski_05.jpg');
%  images    = imread('~/Documents/Class/Data Science/Project_pictures/uiowa/christmas_tree_rash/pit_05.jpg');
  images    = imread('~/Documents/Class/Data Science/Project_pictures/uiowa/psoriasis/pso_07.jpg');
  LabImage  = rgb2lab(images);
%end

%% separate R G B intensities
%%Enhance the contrast,by changing l{n}
%for n=1:5
    l0 =(LabImage(:,:,1) ); %light
    a0 =(LabImage(:,:,2) ); %color A
    b0 =(LabImage(:,:,3) ); %color B
    
    L =LabImage(:,:,1)/100;
    L = adapthisteq(L,'NumTiles',[8 8],'ClipLimit',0.01);
    LabImage(:,:,1) = L*100;
    J = lab2rgb(LabImage);
    
    l =(LabImage(:,:,1) ); %light
    a =(LabImage(:,:,2) ); %color A
    b =(LabImage(:,:,3) ); %color B

    %% thresholding bit - finds average color
load regioncoordinates;

nColors = 6;
sample_regions = false([size(images,1) size(images,2) nColors]);

for count = 1:nColors
  sample_regions(:,:,count) = roipoly(images,region_coordinates(:,1,count),...
                                      region_coordinates(:,2,count));
end

%imshow(sample_regions(:,:,2)),title('sample region for red');
color_markers = zeros([nColors, 2]);

for count = 1:nColors
  color_markers(count,1) = mean2(a(sample_regions(:,:,count)));
  color_markers(count,2) = mean2(b(sample_regions(:,:,count)));
end

fprintf('average color for A and B space is: [%0.3f,%0.3f] \n',color_markers(2,1),color_markers(2,2));
%% classify each pixel using nearest neighbor rule
color_labels = 0:nColors-1;
%initialize matrices used in nearest neighbor classification
a = double(a);
b = double(b);
distance = zeros([size(a), nColors]);
%% perform classification
for count = 1:nColors
  distance(:,:,count) = ( (a - color_markers(count,1)).^2 + ...
                      (b - color_markers(count,2)).^2 ).^0.5;
end

[~, label] = min(distance,[],3);
label = color_labels(label);
clear distance;
rgb_label = repmat(label,[1 1 3]);
segmented_images = zeros([size(images), nColors],'uint8');

for count = 1:nColors
  color = images;
  color(rgb_label ~= color_labels(count)) = 0;
  segmented_images(:,:,:,count) = color;
end

figure();
subplot(2,3,3)
imshow(segmented_images(:,:,:,2)), title('red objects');

%% Display 'a*' and 'b*' Values of the Labeled Colors.
purple = [119/255 73/255 152/255];
plot_labels = {'k', 'r', 'g', purple, 'm', 'y'};

subplot(2,3,6)
for count = 1:nColors
  plot(a(label==count-1),b(label==count-1),'.','MarkerEdgeColor', ...
       plot_labels{count}, 'MarkerFaceColor', plot_labels{count});
  hold on;
end
  
title('Scatterplot of the segmented pixels in ''a*b*'' space');
xlabel('''a*'' values');
ylabel('''b*'' values');

%% plot LAB channels onto a single graph of random image
% Maximize the figure window.
set(gcf, 'units','normalized','outerposition',[0 0 1 1]);
% Force it to display RIGHT NOW (otherwise it might not display until it's all done, unless you've stopped at a breakpoint.)
axis image; % Make sure image is not artificially stretched because of screen's aspect ratio.

%for n = randi([1 nmax],1,1)
    subplot(2,3,1)
    imshow(images);
    title('Original Image');
    
    subplot(2,3,2)
    imshow(J);
    title('Contrast Enhanced Image');
    
    subplot(2,3,4)
    hold on
    histogram(l0); %light
    histogram(a0); %color A
    histogram(b0); %color B
    legend('Light','Color A','Color B');
    title('Original Histogram')
    hold off,
    
    subplot(2,3,5)
    hold on
    histogram(l); %light
    histogram(a); %color A
    histogram(b); %color B  
    legend('Light','Color A','Color B');
    title('Contrast enhanced Histogram')
    hold off
    
%end
figure(2);
set(gcf, 'units','normalized','outerposition',[0 0 1 1]);

subplot(2,3,1)
imshow(segmented_images(:,:,:,2)), title('red objects');

subplot(2,3,2)
imshow(segmented_images(:,:,:,3)), title('green objects');

subplot(2,3,3)
imshow(segmented_images(:,:,:,4)), title('purple objects');

subplot(2,3,4)
imshow(segmented_images(:,:,:,5)), title('magenta objects');

subplot(2,3,5)
imshow(segmented_images(:,:,:,6)), title('yellow objects');
