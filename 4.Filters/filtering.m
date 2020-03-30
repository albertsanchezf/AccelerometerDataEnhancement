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

%plotResampledSignals(x,y,z);

Fs = 10;
Ts = 1/Fs;
L = length(x);

ts = (0:L-1)*Ts;


%% --------- HPF ---------
% Filter 1 (0.5Hz)--------------------------------------------------------
hp1 = designfilt('highpassfir','StopbandFrequency',0.25, ...
         'PassbandFrequency',0.5,'PassbandRipple',0.5, ...
         'StopbandAttenuation',70,'SampleRate',Fs,'DesignMethod','kaiserwin');

fvtool(hp1);

xHP1 = filter(hp1,x);
yHP1 = filter(hp1,y);
zHP1 = filter(hp1,z);

% Plot Filtered Data
figure;
suptitle('Accelerometer induced error HPF (0.5 Hz)')
subplot(3,1,1)
plot(ts,xHP1)
ylabel('x'); xlabel('t(s)');
subplot(3,1,2)
plot(ts,yHP1)
ylabel('y');xlabel('t(s)');
subplot(3,1,3)
plot(ts,zHP1)
ylabel('z');xlabel('t(s)');
% -----------------------------------------------------------------
% ------------------------
%% --------- LPF ---------
% Filter 1 (0-4Hz) ------------------------------------------------
fc1 = 4;

lp1 = designfilt('lowpassfir','FilterOrder',20,'CutoffFrequency',fc1, ...
       'DesignMethod','window','Window',{@kaiser,3},'SampleRate',Fs);

fvtool(lp1,1,'Fs',Fs)

xLP1 = filter(lp1,x);
yLP1 = filter(lp1,y);
zLP1 = filter(lp1,z);


% Plot Filtered Data
figure;
suptitle('Accelerometer induced error LPF1 (0-4 Hz)')
subplot(3,1,1)
plot(ts,xLP1)
ylabel('x'); xlabel('t(s)');
subplot(3,1,2)
plot(ts,yLP1)
ylabel('y');xlabel('t(s)');
subplot(3,1,3)
plot(ts,zLP1)
ylabel('z');xlabel('t(s)');
%%
% -----------------------------------------------------------------
% Filter 2 (0-2.5Hz) ------------------------------------------------
fc2 = 2.5;

lp2 = designfilt('lowpassfir','FilterOrder',20,'CutoffFrequency',fc2, ...
       'DesignMethod','window','Window',{@kaiser,3},'SampleRate',Fs);

fvtool(lp2,1,'Fs',Fs)

xLP2 = filter(lp2,x);
yLP2 = filter(lp2,y);
zLP2 = filter(lp2,z);

% Plot Filtered Data
figure;
suptitle('Accelerometer induced error LPF2 (0-2.5 Hz)')
subplot(3,1,1)
plot(ts,xLP2)
ylabel('x'); xlabel('t(s)');
subplot(3,1,2)
plot(ts,yLP2)
ylabel('y');xlabel('t(s)');
subplot(3,1,3)
plot(ts,zLP2)
ylabel('z');xlabel('t(s)');
% -----------------------------------------------------------------
% ------------------------
%% --------- BPF ---------
% Filter 1 (0.5-3Hz) ------------------------------------------------
fc3 = 0.5;
fc4 = 3;

bp1 = designfilt('bandpassfir','FilterOrder',20, ...
         'CutoffFrequency1',fc3,'CutoffFrequency2',fc4, ...
         'SampleRate',Fs);

fvtool(bp1,1,'Fs',Fs)

xBP1 = filter(bp1,x);
yBP1 = filter(bp1,y);
zBP1 = filter(bp1,z);

% Plot Filtered Data
figure;
suptitle('Accelerometer induced error BPF1 (0.5-3 Hz)')
subplot(3,1,1)
plot(ts,xBP1)
ylabel('x'); xlabel('t(s)');
subplot(3,1,2)
plot(ts,yBP1)
ylabel('y');xlabel('t(s)');
subplot(3,1,3)
plot(ts,zBP1)
ylabel('z');xlabel('t(s)');
% -----------------------------------------------------------------
% ------------------------



fft_plot(Fs,L,x,y,z);