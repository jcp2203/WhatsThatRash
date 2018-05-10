close all; clc; clear all

%addpath 'C:\Users\User\Documents\Class\Data Science\Project_pictures\Final_Images\Psoriasis\'
    imagefiles1=dir('C:\Users\User\Documents\Class\Data Science\Project_pictures\Final_Images\Atopic Dermatitis\*.jpg'); 
    imagefiles2=dir('C:\Users\User\Documents\Class\Data Science\Project_pictures\Final_Images\Christmas Rash\*.jpg'); 
    imagefiles3=dir('C:\Users\User\Documents\Class\Data Science\Project_pictures\Final_Images\Contact Dermatitis\*.jpg'); 
    imagefiles4=dir('C:\Users\User\Documents\Class\Data Science\Project_pictures\Final_Images\Malignant_Melanoma\*.jpg'); 
    imagefiles5=dir('C:\Users\User\Documents\Class\Data Science\Project_pictures\Final_Images\Psoriasis\*.jpg'); 
    imagefiles6=dir('C:\Users\User\Documents\Class\Data Science\Project_pictures\Final_Images\Ringworm\*.jpg'); 
    
for i = 1:6
    imgFiles{n} =  {imagefiles1, imagefiles2, imagefiles3, imagefiles4, imagefiles5, imagefiles6};
    nfiles(n)  = length(imgFiles{n});    % Number of files found

    for n = 1:nfiles(i)
        currentfilename = imgFiles{i}(n).name; 
        currentimage = imread(currentfilename);
        images{i}{n} = currentimage; 
        LabImage1{n}   = rgb2lab(images{i}{n}); 
    end
end


%% Find color Quantifiers (omit black background)
%% find mean of L A B values.

for i = 1:6
    for n = 1:nfiles(i)
    l_temp = l{n}; l_temp(l_temp==0) = nan; mean_l(n) = nanmean(nanmean(l_temp));
    std_l(n) = mean(std(l_temp, 'omitnan'));
    
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

    
    

