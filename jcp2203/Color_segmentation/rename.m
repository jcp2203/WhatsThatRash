%Sragvi Tirumala
%6 April, 2018
%rename skin rashes
close all; clear; clc;

% request user input for disease
disease = input('Type in the 3 letter code for the disease and press enter: ','s');

% user selects rash images folder
path = uigetdir('C:','Select folder containing image files to be renamed');
rashdir = dir(path);
mkdir([path,'\renamed']);
newpath = [path,'\renamed'];

% traverse through rash images folder and change image file names
for i = 1:length(rashdir)-2
    subject = rashdir(i+2).name;
    [~,~,ext] = fileparts(subject);
    newname = strcat(disease,'_',num2str(i),ext);
    status = movefile([path,'\',subject],[newpath,'\',newname]);
end