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
end

for n = 1:nfiles(1)
    currentfilename = imagefiles(n).name; currentimage = imread(currentfilename);
    images1{n} = currentimage; LabImage1{n}   = rgb2lab(images1{n}); 
end

for n = 1:nfiles(2)
    currentfilename = imagefiles(n).name; currentimage = imread(currentfilename);
    images2{n} = currentimage; LabImage2{n}   = rgb2lab(images2{n}); 
end

for n = 1:nfiles(3)
    currentfilename = imagefiles(n).name; currentimage = imread(currentfilename);
    images3{n} = currentimage; LabImage3{n}   = rgb2lab(images3{n}); 
end

for n = 1:nfiles(4)
    currentfilename = imagefiles(n).name; currentimage = imread(currentfilename);
    images4{n} = currentimage; LabImage4{n}   = rgb2lab(images4{n}); 
end

for n = 1:nfiles(5)
    currentfilename = imagefiles(n).name; currentimage = imread(currentfilename);
    images5{n} = currentimage; LabImage5{n}   = rgb2lab(images5{n}); 
end

for n = 1:nfiles(6)
    currentfilename = imagefiles(n).name; currentimage = imread(currentfilename);
    images6{n} = currentimage; LabImage6{n}   = rgb2lab(images6{n}); 
end


%% break into histogram parts
for n=1:nfiles(1)
    L{n} =LabImage1{n}(:,:,1)/100; L{n} = adapthisteq(L{n},'NumTiles',[8 8],'ClipLimit',0.005);
    LabImage1{n}(:,:,1) = L{n}*100; J{n} = lab2rgb(LabImage1{n}); 
    l1{n} =(LabImage1{n}(:,:,1) ); a1{n} =(LabImage1{n}(:,:,2) ); b1{n} =(LabImage1{n}(:,:,3) ); %color B
end

for n=1:nfiles(2)
    L{n} =LabImage2{n}(:,:,1)/100; L{n} = adapthisteq(L{n},'NumTiles',[8 8],'ClipLimit',0.005);
    LabImage2{n}(:,:,1) = L{n}*100; J{n} = lab2rgb(LabImage2{n}); 
    l2{n} =(LabImage2{n}(:,:,1) ); a2{n} =(LabImage2{n}(:,:,2) ); b2{n} =(LabImage2{n}(:,:,3) ); %color B
end

for n=1:nfiles(3)
    L{n} =LabImage{n}(:,:,1)/100; L{n} = adapthisteq(L{n},'NumTiles',[8 8],'ClipLimit',0.005);
    LabImage{n}(:,:,1) = L{n}*100; J{n} = lab2rgb(LabImage{n}); 
    l{n} =(LabImage{n}(:,:,1) ); a{n} =(LabImage{n}(:,:,2) ); b{n} =(LabImage{n}(:,:,3) ); %color B
end

for n=1:nfiles(4)
    L{n} =LabImage{n}(:,:,1)/100; L{n} = adapthisteq(L{n},'NumTiles',[8 8],'ClipLimit',0.005);
    LabImage{n}(:,:,1) = L{n}*100; J{n} = lab2rgb(LabImage{n}); 
    l{n} =(LabImage{n}(:,:,1) ); a{n} =(LabImage{n}(:,:,2) ); b{n} =(LabImage{n}(:,:,3) ); %color B
end

for n=1:nfiles(5)
    L{n} =LabImage{n}(:,:,1)/100; L{n} = adapthisteq(L{n},'NumTiles',[8 8],'ClipLimit',0.005);
    LabImage{n}(:,:,1) = L{n}*100; J{n} = lab2rgb(LabImage{n}); 
    l{n} =(LabImage{n}(:,:,1) ); a{n} =(LabImage{n}(:,:,2) ); b{n} =(LabImage{n}(:,:,3) ); %color B
end

for n=1:nfiles(6)
    L{n} =LabImage{n}(:,:,1)/100; L{n} = adapthisteq(L{n},'NumTiles',[8 8],'ClipLimit',0.005);
    LabImage{n}(:,:,1) = L{n}*100; J{n} = lab2rgb(LabImage{n}); 
    l{n} =(LabImage{n}(:,:,1) ); a{n} =(LabImage{n}(:,:,2) ); b{n} =(LabImage{n}(:,:,3) ); %color B
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

    
    

