clear all; clc; close all;

%% Load Data
load RealData.mat;

svm = cell(1,8);
sma = cell(1,8);

for Incident_Type=1:1
    %Incident_Type = 1; % From 1 to 8
    nSignals = 3; % Number of signals that what to be used

    % Find indexes and lengths for the different signals
    inx = find(logical(diff(Key{Incident_Type}))); 
    lengths = zeros(length(inx)+1,1);
    lengths(1) = inx(1);
    for i=1:length(inx)-1
        lengths(i+1) = inx(i+1) - inx(i);
    end
    lengths(end) = length(Key{Incident_Type}) - inx(end);

    %[x,y,z] = resampleSignals(inx,lengths,Acc_X,Acc_Y,Acc_Z,Incident_Type,nSignals);
    [x,y,z] = resampleSignals(inx,lengths,Acc_X,Acc_Y,Acc_Z,Incident_Type);

    %plotResampledSignals(x,y,z);
    [~,nSignals] = size(x);

    meansX = mean(x);
    varX   = var(x);
    stdX   = std(x);
    
    meansY = mean(y);
    varY   = var(y);
    stdY   = std(y);
    
    meansZ = mean(z);
    varZ   = var(z);
    stdZ   = std(z);
    
    svm{Incident_Type} = svmAcc(x,y,z);
    sma{Incident_Type} = smaAcc(x,y,z);

    figure;
    
    subplot(3,3,1)
    scatter(1:nSignals,meansX,[],'r')
    subplot(3,3,4)
    scatter(1:nSignals,meansY,[],'b')
    subplot(3,3,7)
    scatter(1:nSignals,meansZ,[],'g')
    
    subplot(3,3,2)
    scatter(1:nSignals,varX,[],'r')
    subplot(3,3,5)
    scatter(1:nSignals,varY,[],'b')
    subplot(3,3,8)
    scatter(1:nSignals,varZ,[],'g')
    
    subplot(3,3,3)
    scatter(1:nSignals,stdX,[],'r')
    subplot(3,3,6)
    scatter(1:nSignals,stdY,[],'b')
    subplot(3,3,9)
    scatter(1:nSignals,stdZ,[],'g')
    
    figure;
    hold on;
    scatter(1:nSignals,sma{Incident_Type}(1:nSignals),[],'r')
    hold off;

end