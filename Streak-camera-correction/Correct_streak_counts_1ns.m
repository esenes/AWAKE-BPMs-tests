close all
clc
clear all
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   
%   Process the streak images and compensate for the nonlinear voltage
%   swing. 
%
%   Read the files in a folder and create .csv files with the same name but
%   corrected pixel population.
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
NpySC = 512; NpxSC = 672; sz = [NpxSC,NpySC]; %Size of the image for conversion vector image to matrix image

dirPath = '/Users/esenes/work/AWAKE-BPMs-tests/Measurements-streak-laser-simulataneous/LaserOnStreak+photodiode/Gain40_slit20um_1ns_lecroy';
fname = '/markerar';

savePath = strcat(dirPath, '_corrected');

fnum = 500;
%%
for k=1:fnum
    
    if mod(k,10) == 0
        disp(k)
    end

    load('timeAxis1ns.mat');
        
    fullName = strcat(dirPath, fname, pad(string(k),3,'left','0'), '.tif' );
    myRead = double(imread(fullName));
    
    OrigImage = myRead ; 
    x = linspace(1,NpxSC,NpxSC);

    y_lin = linspace(y(1),y(end),length(y));
    [X,Y] = meshgrid(x,y);
    V = OrigImage;
    [X,Yq] = meshgrid(x,y_lin);
    CorrImage = interp2(X,Y,OrigImage,X,Yq);
    
    sName = strcat(savePath, fname, pad(string(k),3,'left','0'), '.csv'  );
    csvwrite(sName, CorrImage)
    
end