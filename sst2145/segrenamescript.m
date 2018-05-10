%Sragvi Tirumala
%29 April, 2018
%rename skin rashes


% request user input for disease
disease = input('Type in the 3 letter code for the disease and press enter: ','s');
extension = input('Type the total number of properly named images already existing in this dataset and press enter: ');

% user selects rash images folder
path = uigetdir('C:','Select folder containing image files to be renamed');
rashdir = dir(path);
mkdir([path,'\renamed']);
newpath = [path,'\renamed'];

% traverse through rash images folder and change image file names
for i = 1:length(rashdir)-2
    subject = rashdir(i+2).name;
    [~,fn,ext] = fileparts(subject); %fn is filename
    newname = strcat(fn,'seg',ext); %This is the line where I concatenated the string
    status = movefile([path,'\',subject],[newpath,'\',newname]);
end