close all; clc; clear 

%addpath 'C:\Users\User\Documents\Class\Data Science\Project_pictures\Final_Images\'
    imagefiles1=dir('C:\Users\User\Documents\Class\Data Science\Project_pictures\Final_Images\AtopicDermatitis\*.jpg'); 
    imagefiles2=dir('C:\Users\User\Documents\Class\Data Science\Project_pictures\Final_Images\ChristmasRash\*.jpg'); 
    imagefiles3=dir('C:\Users\User\Documents\Class\Data Science\Project_pictures\Final_Images\ContactDermatitis\*.jpg'); 
    imagefiles4=dir('C:\Users\User\Documents\Class\Data Science\Project_pictures\Final_Images\MalignantMelanoma\*.jpg'); 
    imagefiles5=dir('C:\Users\User\Documents\Class\Data Science\Project_pictures\Final_Images\Psoriasis\*.jpg'); 
    imagefiles6=dir('C:\Users\User\Documents\Class\Data Science\Project_pictures\Final_Images\Ringworm\*.jpg');
    imagefiles7=dir('C:\Users\User\Documents\Class\Data Science\Project_pictures\Final_Images\MelanomaMimic\*.jpg'); 
    imgFiles =  {imagefiles1, imagefiles2, imagefiles3, imagefiles4, imagefiles5, imagefiles6,imagefiles7};
    
    nfiles        = zeros(1,7);
    images{1,7}   = []; LabImage{1,7} = [];
    l{1,7}= []; a{1,7}=[]; b{1,7}=[];
    mean_l{1,7} =[]; std_l{1,7}=[];
    mean_a{1,7} =[]; std_a{1,7}=[];
    mean_b{1,7} =[]; std_b{1,7}=[];    
    Dis_avg{1,7} = [];  Dis_avg_std{1,7} = [];
    aa{1,7} =[]; bb{1,7}=[];
    
for i = 1:max(size((nfiles)))
    nfiles(i)  = length(imgFiles{i});    % Number of files found
    imgFiles_temp = imgFiles{i};
        
    for n = 1:1:nfiles(i)
        currentfilename = imgFiles_temp(n).name; 
        currentimage = imread(currentfilename);
        images{i}{n} = currentimage; 
        LabImage{i}{n}   = rgb2lab(images{i}{n});

        l{i}{n} =(LabImage{i}{n}(:,:,1) ); %light
        a{i}{n} =(LabImage{i}{n}(:,:,2) ); %color A
        b{i}{n} =(LabImage{i}{n}(:,:,3) ); %color B

    %% Find color Quantifiers (omit black background)
        %%find mean of L A B values.
        l_temp = l{i}{n};
        l_temp(l_temp==0) = nan;
        l{i}{n} = (l_temp);   % mean of values
        %std_l{i}(n) = mean(std(l_temp, 'omitnan'));% mean of standard deviation of values

        a_temp = a{i}{n};
        a_temp(a_temp==0) = nan;
        a{i}{n} = (a_temp);
        %std_a{i}(n) = mean(std(a_temp, 'omitnan'));

        b_temp = b{i}{n};
        b_temp(b_temp==0) = nan;
        b{i}{n} = (b_temp);
        %std_b{i}(n) = mean(std(b_temp, 'omitnan'));

    end
   
    Dis_avg{i}     = mean(mean_l{i}(:));
    Dis_avg_std{i} = std(Dis_avg{i}(:));

    aa{i} = (a{i}{1,nfiles(i)}); 
    bb{i} = (b{i}{1,nfiles(i)});    
end
figure(1)
imshow(images{7}{36})
figure(2)
hold on
histogram(l{7}{36});
histogram(a{7}{36});
histogram(b{7}{36});
%{
%% process averages of all images
        figure (1)
        % Maximize the figure window.
        set(gcf, 'units','normalized','outerposition',[0 0 1 1]);
        % Force it to display RIGHT NOW (otherwise it might not display until it's all done, unless you've stopped at a breakpoint.)
        drawnow;
        axis image; % Make sure image is not artificially stretched because of screen's aspect ratio.

        subplot(2,3,1)
        hold on
        findpeaks(aa(1),)   
        title('Atopic Dermatitis');
        legend('Green-Red','Blue-Yellow');
        ylim([0 1E4]);
        hold off

        subplot(2,3,2)
        hold on
%       histogram(l{2}{1,nfiles(2)}); 
        histogram(a{2}{1,nfiles(2)}); 
        histogram(b{2}{1,nfiles(2)}); 
        title('Christmas Rash');
        ylim([0 1E4]);
        hold off
        
        subplot(2,3,3)
        hold on
%       histogram(l{3}{1,nfiles(3)}); 
        histogram(a{3}{1,nfiles(3)}); 
        histogram(b{3}{1,nfiles(3)});     
        title('Contact Dermatitis');
        ylim([0 1.5E4]);
        hold off
        
        subplot(2,3,4)
        hold on
%       histogram(l{4}{1,nfiles(4)}); 
        histogram(a{4}{1,nfiles(4)}); 
        histogram(b{4}{1,nfiles(4)}); 
        title('Malignant Melanoma');
        ylim([0 1E4]);
        hold off
        
        subplot(2,3,5)
        hold on
%       histogram(l{5}{1,nfiles(5)}); 
        histogram(a{5}{1,nfiles(5)}); 
        histogram(b{5}{1,nfiles(5)}); 
        title('Psoriasis');
        ylim([0 2E4]);
        hold off
        
        subplot(2,3,6)
        hold on
%       histogram(l{6}{1,nfiles(6)}); 
        histogram(a{6}{1,nfiles(6)}); 
        histogram(b{6}{1,nfiles(6)});  
        ylim([0 1E4]);
        title('Ringworm');
        hold off
%}
