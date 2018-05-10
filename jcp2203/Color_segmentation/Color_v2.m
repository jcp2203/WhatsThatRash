close all; clear; clc;

%% Load image
nmax = 5;
for n=1:nmax
  images{n}    = imread(sprintf('~/Documents/Class/Data Science/Project_pictures/uiowa/skin_tumor/ski_%12d.jpg',n));
  LabImage{n}  = rgb2lab(images{n});
end


%% separate R G B intensities
%%Enhance the contrast,by changing l{n}
for n=1:5
    l0{n} =(LabImage{n}(:,:,1) ); %light
    a0{n} =(LabImage{n}(:,:,2) ); %color A
    b0{n} =(LabImage{n}(:,:,3) ); %color B
    
    L{n} =LabImage{n}(:,:,1)/100;
    L{n} = adapthisteq(L{n},'NumTiles',[8 8],'ClipLimit',0.005);
    LabImage{n}(:,:,1) = L{n}*100;
    J{n} = lab2rgb(LabImage{n});
    
    l{n} =(LabImage{n}(:,:,1) ); %light
    a{n} =(LabImage{n}(:,:,2) ); %color A
    b{n} =(LabImage{n}(:,:,3) ); %color B
    
end


%% plot LAB channels onto a single graph of random image
% Maximize the figure window.
set(gcf, 'units','normalized','outerposition',[0 0 1 1]);
% Force it to display RIGHT NOW (otherwise it might not display until it's all done, unless you've stopped at a breakpoint.)
drawnow;
axis image; % Make sure image is not artificially stretched because of screen's aspect ratio.


for n = randi([1 nmax],1,1)
    subplot(2,3,1)
    imshow(images{n});
    title('Original Image');
    
    subplot(2,3,2)
    imshow(J{n});
    title('Contrast Enhanced Image');
    
    subplot(2,3,4)
    hold on
    histogram(l0{n}); %light
    histogram(a0{n}); %color A
    histogram(b0{n}); %color B
    legend('Light','Color A','Color B');
    title('Original Histogram')
    hold off,
    
    subplot(2,3,5)
    hold on
    histogram(l{n}); %light
    histogram(a{n}); %color A
    histogram(b{n}); %color B  
    legend('Light','Color A','Color B');
    title('Contrast enhanced Histogram')
    hold off
    
end


