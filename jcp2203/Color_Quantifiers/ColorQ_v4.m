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
        
    for n = 1:2:nfiles(i)
        currentfilename = imgFiles_temp(n).name; 
        currentimage = imread(currentfilename);
        images{i}{n} = currentimage; 
        LabImage{i}{n}   = rgb2lab(images{i}{n});
    
        l0{i}{n} =(LabImage{i}{n}(:,:,1) ); %light
        a0{i}{n} =(LabImage{i}{n}(:,:,2) ); %color A
        b0{i}{n} =(LabImage{i}{n}(:,:,3) ); %color B

        L{i}{n} =LabImage{i}{n}(:,:,1)/100;
        L{i}{n} = adapthisteq(L{i}{n},'NumTiles',[8 8],'ClipLimit',0.005);
        LabImage{i}{n}(:,:,1) = L{i}{n}*100;
        J{i}{n} = lab2rgb(LabImage{i}{n});

        l{i}{n} =(LabImage{i}{n}(:,:,1) ); %light
        a{i}{n} =(LabImage{i}{n}(:,:,2) ); %color A
        b{i}{n} =(LabImage{i}{n}(:,:,3) ); %color B
    %% Find color Quantifiers (omit black background)
        %%find mean of L A B values.
        l_temp = l{i}{n};
        l_temp(l_temp==0) = nan;
        mean_l{i}(n) = nanmean(nanmean(l_temp));   % mean of values
        std_l{i}(n) = mean(std(l_temp, 'omitnan'));% mean of standard deviation of values

        a_temp = a{i}{n};
        a_temp(a_temp==0) = nan;
        mean_a{i}(n) = nanmean(nanmean(a_temp));
        std_a{i}(n) = mean(std(a_temp, 'omitnan'));

        b_temp = b{i}{n};
        b_temp(b_temp==0) = nan;
        mean_b{i}(n) = nanmean(nanmean(b_temp));
        std_b{i}(n) = mean(std(b_temp, 'omitnan'));
    end
    
    Dis_avg{i}     = mean(mean_l{i}(:));
    Dis_avg_std{i} = std(Dis_avg{i}(:));
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
       % histogram(mean_l{1}(:)./ceil(max(mean_l{1}(:))),5) %for beta distribution fit
        histogram(mean_a{1}(:)./ceil(max(mean_a{1}(:))),5) %for beta distribution fit
       % histogram(mean_b{1}(:)./ceil(max(mean_b{1}(:))),5) %for beta distribution fit
        title('Atopic Dermatitis');
        legend('Intensity','Green-Red','Blue-Yellow');
        hold off
        
        subplot(2,3,2)
        hold on
       % histogram(mean_l{2}(:)./ceil(max(mean_l{2}(:))),5) %for beta distribution fit
        histogram(mean_a{2}(:)./ceil(max(mean_a{2}(:))),5) %for beta distribution fit
       % histogram(mean_b{2}(:)./ceil(max(mean_b{2}(:))),5) %for beta distribution fit
        title('Christmas Rash');
        hold off
        
        subplot(2,3,3)
        hold on
       % histogram(mean_l{3}(:)./ceil(max(mean_l{3}(:))),5) %for beta distribution fit
        histogram(mean_a{3}(:)./ceil(max(mean_a{3}(:))),5) %for beta distribution fit
       % histogram(mean_b{3}(:)./ceil(max(mean_b{3}(:))),5) %for beta distribution fit        
        title('Contact Dermatitis');
        hold off
        
        subplot(2,3,4)
        hold on
       % histogram(mean_l{4}(:)./ceil(max(mean_l{4}(:))),5) %for beta distribution fit
        histogram(mean_a{4}(:)./ceil(max(mean_a{4}(:))),5) %for beta distribution fit
       % histogram(mean_b{4}(:)./ceil(max(mean_b{4}(:))),5) %for beta distribution fit
        title('Malignant Melanoma');
        hold off
        
        subplot(2,3,5)
        hold on
       % histogram(mean_l{5}(:)./ceil(max(mean_l{5}(:))),5) %for beta distribution fit
        histogram(mean_a{5}(:)./ceil(max(mean_a{5}(:))),5) %for beta distribution fit
       % histogram(mean_b{5}(:)./ceil(max(mean_b{5}(:))),5) %for beta distribution fit
        title('Psoriasis');
        hold off
        
        subplot(2,3,6)
        hold on
       % histogram(mean_l{6}(:)./ceil(max(mean_l{6}(:))),5) %for beta distribution fit
        histogram(mean_a{6}(:)./ceil(max(mean_a{6}(:))),5) %for beta distribution fit
       % histogram(mean_b{6}(:)./ceil(max(mean_b{6}(:))),5) %for beta distribution fit        
        title('Ringworm');
        hold off
     
        figure(2)
        % Maximize the figure window.
        set(gcf, 'units','normalized','outerposition',[0 0 1 1]);
        % Force it to display RIGHT NOW (otherwise it might not display until it's all done, unless you've stopped at a breakpoint.)
        axis image; % Make sure image is not artificially stretched because of screen's aspect ratio.
        
        subplot(2,3,1)
        hold on
       % histogram(std_l{1}(:)./ceil(max(std_l{1}(:))),5) %for beta distribution fit
        histogram(std_a{1}(:)./ceil(max(std_a{1}(:))),5) %for beta distribution fit
       % histogram(std_b{1}(:)./ceil(max(std_b{1}(:))),5) %for beta distribution fit
        title('Atopic Dermatitis');
        legend('Intensity','Green-Red','Blue-Yellow');
        hold off
        
        subplot(2,3,2)
        hold on
       % histogram(std_l{2}(:)./ceil(max(std_l{2}(:))),5) %for beta distribution fit
        histogram(std_a{2}(:)./ceil(max(std_a{2}(:))),5) %for beta distribution fit
       % histogram(std_b{2}(:)./ceil(max(std_b{2}(:))),5) %for beta distribution fit
        title('Christmas Rash');
        hold off
        
        subplot(2,3,3)
        hold on
       % histogram(std_l{3}(:)./ceil(max(std_l{3}(:))),5) %for beta distribution fit
        histogram(std_a{3}(:)./ceil(max(std_a{3}(:))),5) %for beta distribution fit
       % histogram(std_b{3}(:)./ceil(max(std_b{3}(:))),5) %for beta distribution fit        
        title('Contact Dermatitis');
        hold off
        
        subplot(2,3,4)
        hold on
       % histogram(std_l{4}(:)./ceil(max(std_l{4}(:))),5) %for beta distribution fit
        histogram(std_a{4}(:)./ceil(max(std_a{4}(:))),5) %for beta distribution fit
       % histogram(std_b{4}(:)./ceil(max(std_b{4}(:))),5) %for beta distribution fit
        title('Malignant Melanoma');
        hold off
        
        subplot(2,3,5)
        hold on
       % histogram(std_l{5}(:)./ceil(max(std_l{5}(:))),5) %for beta distribution fit
        histogram(std_a{5}(:)./ceil(max(std_a{5}(:))),5) %for beta distribution fit
       % histogram(std_b{5}(:)./ceil(max(std_b{5}(:))),5) %for beta distribution fit
        title('Psoriasis');
        hold off
        
        subplot(2,3,6)
        hold on
       % histogram(std_l{6}(:)./ceil(max(std_l{6}(:))),5) %for beta distribution fit
        histogram(std_a{6}(:)./ceil(max(std_a{6}(:))),5) %for beta distribution fit
       % histogram(std_b{6}(:)./ceil(max(std_b{6}(:))),5) %for beta distribution fit       
        title('Ringworm');
        hold off
    
