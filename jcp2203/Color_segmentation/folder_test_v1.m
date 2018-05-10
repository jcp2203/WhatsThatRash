close all; clc; clear all

%addpath 'C:\Users\User\Documents\Class\Data Science\Project_pictures\Final_Images\Psoriasis\'
    imagefiles1=dir('C:\Users\User\Documents\Class\Data Science\Project_pictures\Final_Images\Atopic Dermatitis\*.jpg'); 
    imagefiles2=dir('C:\Users\User\Documents\Class\Data Science\Project_pictures\Final_Images\Christmas Rash\*.jpg'); 
    imagefiles3=dir('C:\Users\User\Documents\Class\Data Science\Project_pictures\Final_Images\Contact Dermatitis\*.jpg'); 
    imagefiles4=dir('C:\Users\User\Documents\Class\Data Science\Project_pictures\Final_Images\Malignant_Melanoma\*.jpg'); 
    imagefiles5=dir('C:\Users\User\Documents\Class\Data Science\Project_pictures\Final_Images\Psoriasis\*.jpg'); 
    imagefiles6=dir('C:\Users\User\Documents\Class\Data Science\Project_pictures\Final_Images\Ringworm\*.jpg'); 
    imgFiles =  {imagefiles1, imagefiles2, imagefiles3, imagefiles4, imagefiles5, imagefiles6};
for i = 1:6
    nfiles(i)  = length(imgFiles{i});    % Number of files found
    imgFiles_temp = imgFiles{i};
        
    for n = 1:nfiles(i)
        currentfilename = imgFiles_temp(n).name; 
        currentimage = imread(currentfilename);
        images{i}{n} = currentimage; 
        LabImage{i}{n}   = rgb2lab(images{i}{n});
    
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
    
    

end