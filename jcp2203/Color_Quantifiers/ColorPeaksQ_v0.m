close all; clc; clear 

%addpath 'C:\Users\User\Documents\Class\Data Science\Project_pictures\Final_Images\'
    imagefiles1=dir('C:\Users\User\Documents\Class\Data Science\Project_pictures\Final_Images\Atopic Dermatitis\*.jpg'); 
    imagefiles2=dir('C:\Users\User\Documents\Class\Data Science\Project_pictures\Final_Images\Christmas Rash\*.jpg'); 
    imagefiles3=dir('C:\Users\User\Documents\Class\Data Science\Project_pictures\Final_Images\Contact Dermatitis\*.jpg'); 
    imagefiles4=dir('C:\Users\User\Documents\Class\Data Science\Project_pictures\Final_Images\Malignant Melanoma\*.jpg'); 
    imagefiles5=dir('C:\Users\User\Documents\Class\Data Science\Project_pictures\Final_Images\Psoriasis\*.jpg'); 
    imagefiles6=dir('C:\Users\User\Documents\Class\Data Science\Project_pictures\Final_Images\Ringworm\*.jpg'); 
    imgFiles =  {imagefiles1, imagefiles2, imagefiles3, imagefiles4, imagefiles5, imagefiles6};
    
    nfiles        = zeros(1,6);
    images{1,6}   = []; LabImage{1,6} = [];
    l{1,6}= []; a{1,6}=[]; b{1,6}=[];
    mean_l{1,6} =[]; std_l{1,6}=[];
    mean_a{1,6} =[]; std_a{1,6}=[];
    mean_b{1,6} =[]; std_b{1,6}=[];    
    Dis_avg{1,6} = [];  Dis_avg_std{1,6} = [];
    lsizes = []; aa{1,6} =[]; bb{1,6}=[];
    
for i = 1:6
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
    lsizes(i) = max(size(l{i}));

    aa(i) = (a{i}{1,lsizes(i)}); 
    bb(i) = (b{i}{1,lsizes(i)});    
end

%% process averages of all images
        figure (1)
        % Maximize the figure window.
        set(gcf, 'units','normalized','outerposition',[0 0 1 1]);
        % Force it to display RIGHT NOW (otherwise it might not display until it's all done, unless you've stopped at a breakpoint.)
        drawnow;
        axis image; % Make sure image is not artificially stretched because of screen's aspect ratio.

        subplot(2,3,1)
        hold on
%       histogram(l{1}{1,lsizes(1)}); 
        histogram(a{1}{1,lsizes(1)}); 
        histogram(b{1}{1,lsizes(1)}); 
        title('Atopic Dermatitis');
        legend('Green-Red','Blue-Yellow');
        ylim([0 1E4]);
        hold off
%{
        subplot(2,3,2)
        hold on
%       histogram(l{2}{1,lsizes(2)}); 
        histogram(a{2}{1,lsizes(2)}); 
        histogram(b{2}{1,lsizes(2)}); 
        title('Christmas Rash');
        ylim([0 1E4]);
        hold off
        
        subplot(2,3,3)
        hold on
%       histogram(l{3}{1,lsizes(3)}); 
        histogram(a{3}{1,lsizes(3)}); 
        histogram(b{3}{1,lsizes(3)});     
        title('Contact Dermatitis');
        ylim([0 1.5E4]);
        hold off
        
        subplot(2,3,4)
        hold on
%       histogram(l{4}{1,lsizes(4)}); 
        histogram(a{4}{1,lsizes(4)}); 
        histogram(b{4}{1,lsizes(4)}); 
        title('Malignant Melanoma');
        ylim([0 1E4]);
        hold off
        
        subplot(2,3,5)
        hold on
%       histogram(l{5}{1,lsizes(5)}); 
        histogram(a{5}{1,lsizes(5)}); 
        histogram(b{5}{1,lsizes(5)}); 
        title('Psoriasis');
        ylim([0 2E4]);
        hold off
        
        subplot(2,3,6)
        hold on
%       histogram(l{6}{1,lsizes(6)}); 
        histogram(a{6}{1,lsizes(6)}); 
        histogram(b{6}{1,lsizes(6)});  
        ylim([0 1E4]);
        title('Ringworm');
        hold off
%}
