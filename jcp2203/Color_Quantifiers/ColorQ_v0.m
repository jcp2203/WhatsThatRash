close all; clc; clear all

%addpath 'C:\Users\User\Documents\Class\Data Science\Project_pictures\Final_Images\Psoriasis\'

    imagefiles=dir('C:\Users\User\Documents\Class\Data Science\Project_pictures\Final_Images\Atopic Dermatitis\*.jpg'); 

nfiles  = length(imagefiles);    % Number of files found

for n = 1:nfiles
    currentfilename = imagefiles(n).name;
    currentimage = imread(currentfilename);
    images{n} = currentimage;
    LabImage{n}   = rgb2lab(images{n}); 
end



%% break into histogram parts
for n=1:nfiles
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

%% Find color Quantifiers (omit black background)
%% find mean of L A B values.
for n = 1:nfiles
    l_temp = l{n};
    l_temp(l_temp==0) = nan;
    mean_l(n) = nanmean(nanmean(l_temp));   % mean of values
    std_l(n) = mean(std(l_temp, 'omitnan'));% mean of standard deviation of values
    
    a_temp = a{n};
    a_temp(a_temp==0) = nan;
    mean_a(n) = nanmean(nanmean(a_temp));
    std_a(n) = mean(std(a_temp, 'omitnan'));
    
    b_temp = b{n};
    b_temp(b_temp==0) = nan;
    mean_b(n) = nanmean(nanmean(b_temp));
    std_b(n) = mean(std(b_temp, 'omitnan'));
end

%% process averages of all images
    figure(1)
    subplot(3,3,1)
    Dis_avg     = mean(mean_l);
    Dis_avg_std = std(Dis_avg);
    histfit(mean_l./round(max(mean_l)),5,'beta') %for beta distribution fit
    % https://www.mathworks.com/help/stats/histfit.html 
    title('mean_L')
    
    subplot(3,3,2)
    histfit(std_l./round(max(std_l)),5,'beta')
    title('std_dev_L')

    
    

