clear all; clc; close all;

% Load Data
cd('/Users/AlbertSanchez/Desktop/TFM (noDropBox)/AccelerometerDataEnhacement/5.ICA');
load RealData.mat;
load provaTJ.mat;

Fs = 10;

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

%% ICA
cd('./pca_ica/pca_ica/');

[xLength,xSignals] = size(x);
[yLength,ySignals] = size(y);
[zLength,zSignals] = size(z);

if length(xJ) < xLength
    n = xLength/length(xJ);
    xJ = repmat(xJ,ceil(n));
end

if length(xJ) > xLength
    xJ = xJ(1:xLength);
end

ica = zeros(2,xLength);
Zica = cell(1,xSignals);

for i=1:xSignals
    
    ica(1,:) = x(:,i)';
    ica(2,:) = xJ(:,1)';
    
    Zica{i} = fastICA(ica,2)';
end
%%

L = length(x);
ts = (0:L-1)*(1/Fs);

for i=1:xSignals
    figure;
    hold on;
    plot(ts,x(:,i));
    plot(ts,Zica{i}(:,1));
    plot(ts,Zica{i}(:,2));
    legend('Original signal','Useful data','Pedaling signal')
    xlabel('t(s)');
    hold off;
end



%%
X = fft(x);
Zica1 = fft(y);
Zica2 = fft(z);

P21x = abs(X/xLength);
P21Zica1 = abs(Zica1/xLength);
P21Zica2 = abs(Zica2/xLength);

P11x = P21x(1:xLength/2+1,:);
P11Zica1 = P21Zica1(1:xLength/2+1,:);
P11Zica2 = P21Zica2(1:xLength/2+1,:);

P11x(2:end-1) = 2*P11x(2:end-1);
P11Zica1(2:end-1) = 2*P11Zica1(2:end-1);
P11Zica2(2:end-1) = 2*P11Zica2(2:end-1);

f = Fs*(0:(xLength/2))/xLength;

figure;
subplot(3,1,1)
title('Single-Sided Amplitude Spectrum of X(f)')
plot(f,P11x) 
xlabel('f (Hz)')
ylabel('|P1x(f)|')

%figure;
subplot(3,1,2)
title('Single-Sided Amplitude Spectrum of Zica1(f)')
plot(f,P11Zica1) 
xlabel('f (Hz)')
ylabel('|P1Zica1(f)|')

%figure;
subplot(3,1,3)
title('Single-Sided Amplitude Spectrum of Zica2(f)')
plot(f,P11Zica2) 
xlabel('f (Hz)')
ylabel('|P1Zica2(f)|')
