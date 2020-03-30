clear all; clc; close all;

load RealData.mat;

Incident_Type = 1; % From 1 to 8
nSignals = 1; % Number of signals that what to be used

% Find indexes and lengths for the different signals
inx = find(logical(diff(Key{Incident_Type}))); 
lengths = zeros(length(inx)+1,1);
lengths(1) = inx(1);
for i=1:length(inx)-1
    lengths(i+1) = inx(i+1) - inx(i);
end
lengths(end) = length(Key{Incident_Type}) - inx(end);

[x(:,1),y(:,1),z(:,1)] = resampleSignalsv2(inx,lengths,Acc_X,Acc_Y,Acc_Z,1,nSignals);
[x(:,2),y(:,2),z(:,2)] = resampleSignalsv2(inx,lengths,Acc_X,Acc_Y,Acc_Z,2,nSignals);
[x(:,3),y(:,3),z(:,3)] = resampleSignalsv2(inx,lengths,Acc_X,Acc_Y,Acc_Z,3,nSignals);
[x(:,4),y(:,4),z(:,4)] = resampleSignalsv2(inx,lengths,Acc_X,Acc_Y,Acc_Z,4,nSignals);
[x(:,5),y(:,5),z(:,5)] = resampleSignalsv2(inx,lengths,Acc_X,Acc_Y,Acc_Z,5,nSignals);
[x(:,6),y(:,6),z(:,6)] = resampleSignalsv2(inx,lengths,Acc_X,Acc_Y,Acc_Z,6,nSignals);
[x(:,7),y(:,7),z(:,7)] = resampleSignalsv2(inx,lengths,Acc_X,Acc_Y,Acc_Z,7,nSignals);
[x(:,8),y(:,8),z(:,8)] = resampleSignalsv2(inx,lengths,Acc_X,Acc_Y,Acc_Z,8,nSignals);

plotResampledSignals(x,y,z);

Fs = 10;
L = max(lengths);

fft_plot(Fs,L,x,y,z);