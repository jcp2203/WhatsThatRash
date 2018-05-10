close all; clear; clc;

%% Load image
close all; clear all; clc


 % images{n} = imread(sprintf('~/Documents/Class/Data Science/Project_pictures/uiowa/skin_tumor/ski_%02d.jpg',n));
 %  images{n} = imread(sprintf('C:\Users\User\Documents\Class\Data Science\Project_pictures\Final_Images\Malignant Melanoma\Filtered_Mel_%02d.jpg',n));
 % directory = 'C:\Users\User\Documents\Class\Data Science\Project_pictures\Final_Images\Malignant Melanoma';


 d=dir('C:\Users\User\Documents\Class\Data Science\Project_pictures\Final_Images\Malignant_Melanoma'); 
 imagefiles = 
 nfiles = length(imagefiles);    % Number of files found
for n = 1:nfiles 
    currentfilename = imagefiles(n).name;
    currentimage = imread(currentfilename);
    images{n} = currentimage;
    I{n}   = rgb2hsv(images{n}); 
end



%% separate R G B intensities
for n=1:nfiles
    R{n}=imhist(I{n}(:,:,1) ); %hue
    G{n}=imhist(I{n}(:,:,2) ); %saturation
    B{n}=imhist(I{n}(:,:,3) ); %values
    average{n} = mean(B{n});
end

%% calculate average value
%mask{n}        = (B{n} > 0.65);
%average(~mask) = NaN;
%average{n} = average{n}

%% plot HSV channels onto a single graph of random image
for n = randi([1 nfiles],1,1)
    figure(1)
    hold on
    imhist(I{n}(:,:,1) ); %hue
    imhist(I{n}(:,:,2) ); %saturation
    imhist(I{n}(:,:,3) ); %values
    legend('hue','saturation','value');
    hold off,
    
    fprintf("average value is: %.2d",average{n});
    
    figure(2)
    imshow(I{n})
end
