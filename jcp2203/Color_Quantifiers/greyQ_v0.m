close all; clc; clear all

    imagefiles1=dir('C:\Users\User\Documents\Class\Data Science\Project_pictures\Final_Images\Atopic Dermatitis\*.jpg'); 
    imagefiles2=dir('C:\Users\User\Documents\Class\Data Science\Project_pictures\Final_Images\Christmas Rash\*.jpg'); 
    imagefiles3=dir('C:\Users\User\Documents\Class\Data Science\Project_pictures\Final_Images\Contact Dermatitis\*.jpg'); 
    imagefiles4=dir('C:\Users\User\Documents\Class\Data Science\Project_pictures\Final_Images\Malignant Melanoma\*.jpg'); 
    imagefiles5=dir('C:\Users\User\Documents\Class\Data Science\Project_pictures\Final_Images\Psoriasis\*.jpg'); 
    imagefiles6=dir('C:\Users\User\Documents\Class\Data Science\Project_pictures\Final_Images\Ringworm\*.jpg'); 
    imgFiles =  {imagefiles1, imagefiles2, imagefiles3, imagefiles4, imagefiles5, imagefiles6};

    nfiles        = zeros(1,6);
    images{1,6}   = []; LabImage{1,6} = [];
    rows = zeros(1,300); columns = zeros(1,300);
    numberOfColorChannels = zeros(1,300);
    Gmag{1,6}=[]; Gdir{1,6} = [];
    
for i = 1:6
    nfiles(i)  = length(imgFiles{i});    % Number of files found
    imgFiles_temp = imgFiles{i};
    for n = 1:10:nfiles(i)
        currentfilename = imgFiles_temp(n).name;
        currentimage = imread(currentfilename);
        images{i}{n} = currentimage;
        [rows(n), columns(n), numberOfColorChannels(n)] = size(images{i}{n});
      
        if numberOfColorChannels(n) > 1
            images{i}{n} = rgb2gray(images{i}{n});
        end
        
        %%Gradient magnitude and direction
        [Gmag{i}{n},Gdir{i}{n}]=imgradient(images{i}{n});

        Gmag_temp = Gmag{i}{n};
        Gmag_temp(Gmag_temp==0) = nan;
        mean_Gmag{i}(n) = nanmean(nanmean(Gmag_temp));
        std_Gmag{i}(n) = mean(std(Gmag_temp, 'omitnan'));
    
        Gdir_temp = Gmag{i}{n};
        Gdir_temp(Gdir_temp==0) = nan;
        mean_Gdir{i}(n) = nanmean(nanmean(Gdir_temp));
        std_Gdir{i}(n) = mean(std(Gdir_temp, 'omitnan'));
    
    end
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
        histogram(mean_Gmag{1}(:)./ceil(max(mean_Gmag{1}(:))),5) %for beta distribution fit
        title('Atopic Dermatitis');
        legend('Gradient Magnitude');
        hold off
        
        subplot(2,3,2)
        hold on
        histogram(mean_Gmag{2}(:)./ceil(max(mean_Gmag{2}(:))),5) %for beta distribution fit
        title('Christmas Rash');
        hold off
        
        subplot(2,3,3)
        hold on
        histogram(mean_Gmag{3}(:)./ceil(max(mean_Gmag{3}(:))),5) %for beta distribution fit        
        title('Contact Dermatitis');
        hold off
        
        subplot(2,3,4)
        hold on
        histogram(mean_Gmag{4}(:)./ceil(max(mean_Gmag{4}(:))),5) %for beta distribution fit
        title('Malignant Melanoma');
        hold off
        
        subplot(2,3,5)
        hold on
        histogram(mean_Gmag{5}(:)./ceil(max(mean_Gmag{5}(:))),5) %for beta distribution fit
        title('Psoriasis');
        hold off
        
        subplot(2,3,6)
        hold on
        histogram(mean_Gmag{6}(:)./ceil(max(mean_Gmag{6}(:))),5) %for beta distribution fit        
        title('Ringworm');
        hold off
     
        figure(2)
        % Maximize the figure window.
        set(gcf, 'units','normalized','outerposition',[0 0 1 1]);
        % Force it to display RIGHT NOW (otherwise it might not display until it's all done, unless you've stopped at a breakpoint.)
        axis image; % Make sure image is not artificially stretched because of screen's aspect ratio.
        
        subplot(2,3,1)
        hold on
        histogram(mean_Gdir{1}(:)./ceil(max(mean_Gdir{1}(:))),5) %for beta distribution fit
        title('Atopic Dermatitis');
        legend('Green-Red');
        hold off
        
        subplot(2,3,2)
        hold on
        histogram(mean_Gdir{2}(:)./ceil(max(mean_Gdir{2}(:))),5) %for beta distribution fit
        title('Christmas Rash');
        hold off
        
        subplot(2,3,3)
        hold on
        histogram(mean_Gdir{3}(:)./ceil(max(mean_Gdir{3}(:))),5) %for beta distribution fit        
        title('Contact Dermatitis');
        hold off
        
        subplot(2,3,4)
        hold on
        histogram(mean_Gdir{4}(:)./ceil(max(mean_Gdir{4}(:))),5) %for beta distribution fit
        title('Malignant Melanoma');
        hold off
        
        subplot(2,3,5)
        hold on
        histogram(mean_Gdir{5}(:)./ceil(max(mean_Gdir{5}(:))),5) %for beta distribution fit
        title('Psoriasis');
        hold off
        
        subplot(2,3,6)
        hold on
        histogram(mean_Gdir{6}(:)./ceil(max(mean_Gdir{6}(:))),5) %for beta distribution fit       
        title('Ringworm');
        hold off



    

