close all; clear; clc;

%% Load image
nmax = 5;
%for n=1:nmax
%  images{n}    = imread(sprintf('~/Documents/Class/Data Science/Project_pictures/uiowa/skin_tumor/ski_%02d.jpg',n));
%  images    = imread('~/Documents/Class/Data Science/Project_pictures/uiowa/skin_tumor/ski_05.jpg');
%  images    = imread('~/Documents/Class/Data Science/Project_pictures/uiowa/christmas_tree_rash/pit_05.jpg');
  images    = imread('C:\Users\User\Documents\Class\Data Science\Project_pictures\Final_Images\Malignant Melanoma\Filtered_Mel_55.jpg');

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

    %% thresholding bit - Uses K-Means clustering
load regioncoordinates;

ab = LabImage(:,:,2:3);
nrows = size(ab,1);
ncols = size(ab,2);
ab = reshape(ab,nrows*ncols,2);

nColors = 3;
% repeat the clustering 3 times to avoid local minima
[cluster_idx, cluster_center] = kmeans(ab,nColors,'distance','sqEuclidean', ...
                                      'Replicates',3);

pixel_labels = reshape(cluster_idx,nrows,ncols);
subplot(2,3,6)
imshow(pixel_labels,[]), title('image labeled by cluster index');

segmented_images = cell(1,3);
rgb_label = repmat(pixel_labels,[1 1 3]);

for k = 1:nColors
    color = images;
    color(rgb_label ~= k) = 0;
    segmented_images{k} = color;
end


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

    subplot(2,3,3)
    imshow(segmented_images{1}), title('objects in cluster 2');

%end
figure(2);
set(gcf, 'units','normalized','outerposition',[0 0 1 1]);

subplot(2,2,1)
imshow(segmented_images{1}), title('objects in cluster 1');

subplot(2,2,2)
imshow(segmented_images{2}), title('objects in cluster 2');

subplot(2,2,3)
imshow(segmented_images{3}), title('objects in cluster 3');

%subplot(2,2,4)
%imshow(segmented_images{4}), title('objects in cluster 4');