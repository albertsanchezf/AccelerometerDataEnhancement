%clear all; clc; close all;

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

[x,y,z] = resampleSignals(inx,lengths,Acc_X,Acc_Y,Acc_Z,Incident_Type,nSignals);

plotResampledSignals(x,y,z);

%% --------- HPF ---------
% Filter 1 --------------------------------------------------------
hp1 = designfilt('highpassfir','StopbandFrequency',0.25, ...
         'PassbandFrequency',0.35,'PassbandRipple',0.5, ...
         'StopbandAttenuation',70,'DesignMethod','kaiserwin');

fvtool(hp1);

xHP1 = filter(hp1,x);
yHP1 = filter(hp1,y);
zHP1 = filter(hp1,z);

% Plot Filtered Data
[m,n] = size(xHP1);
ts = 1:1:m;

figure;
suptitle('Accelerometer induced error HPF')
subplot(3,1,1)
hold on;
for i=1:n
    plot(ts,xHP1(:,1));
end
hold off;
ylabel('x'); xlabel('t(ms)');

subplot(3,1,2)
hold on;
for i=1:n
    plot(ts,yHP1)
end
hold off;
ylabel('y');xlabel('t(ms)');

subplot(3,1,3)
hold on;
for i=1:n
    plot(ts,zHP1)
end
hold off;
ylabel('z');xlabel('t(ms)');
% -----------------------------------------------------------------
% ------------------------
%% --------- LPF ---------
% Filter 1 (0-5Hz) ------------------------------------------------
fc1 = 5;
Fs = 11;

lp1 = designfilt('lowpassfir','FilterOrder',20,'CutoffFrequency',fc1, ...
       'DesignMethod','window','Window',{@kaiser,3},'SampleRate',Fs);

%fvtool(lp1,1,'Fs',Fs)

xLP1 = filter(lp1,x);
yLP1 = filter(lp1,y);
zLP1 = filter(lp1,z);


% Plot Filtered Data

[m,n] = size(xLP1);
ts = 1:1:m;

figure;
suptitle('Accelerometer induced error LPF1 (0-5 Hz)')
subplot(3,1,1)
hold on;
for i=1:n
    plot(ts,xLP1)
end
hold off;
ylabel('x'); xlabel('t(ms)');

subplot(3,1,2)
hold on;
for i=1:n
    plot(ts,yLP1)
end
hold off;
ylabel('y');xlabel('t(ms)');

subplot(3,1,3)
hold on;
for i=1:n
    plot(ts,zLP1)
end
hold off;
ylabel('z');xlabel('t(ms)');

% -----------------------------------------------------------------
%% Filter 2 (0-3Hz) ------------------------------------------------
fc2 = 3;

lp2 = designfilt('lowpassfir','FilterOrder',20,'CutoffFrequency',fc2, ...
       'DesignMethod','window','Window',{@kaiser,3},'SampleRate',Fs);

fvtool(lp2,1,'Fs',Fs)

xLP2 = filter(lp2,x);
yLP2 = filter(lp2,y);
zLP2 = filter(lp2,z);

% Plot Filtered Data
figure;
suptitle('Accelerometer induced error LPF2 (0-3 Hz)')
subplot(3,1,1)
plot(ts,xLP2)
ylabel('x'); xlabel('t(ms)');
subplot(3,1,2)
plot(ts,yLP2)
ylabel('y');xlabel('t(ms)');
subplot(3,1,3)
plot(ts,zLP2)
ylabel('z');xlabel('t(ms)');
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
ylabel('x'); xlabel('t(ms)');
subplot(3,1,2)
plot(ts,yBP1)
ylabel('y');xlabel('t(ms)');
subplot(3,1,3)
plot(ts,zBP1)
ylabel('z');xlabel('t(ms)');
% -----------------------------------------------------------------
% ------------------------
%% FFT

Fs = 8;             % Sampling frequency                    
T = 1/Fs;           % Sampling period       
L = max(lengths);   % Length of signal
t = (0:L-1)*T;      % Time vector

X = fft(x);
Y = fft(y);
Z = fft(z);

P21x = abs(X/L);
P21y = abs(Y/L);
P21z = abs(Z/L);

P11x = P21x(1:L/2+1,:);
P11y = P21y(1:L/2+1,:);
P11z = P21z(1:L/2+1,:);

P11x(2:end-1) = 2*P11x(2:end-1);
P11y(2:end-1) = 2*P11y(2:end-1);
P11z(2:end-1) = 2*P11z(2:end-1);

f = Fs*(0:(L/2))/L;

figure;
subplot(3,1,1)
title('Single-Sided Amplitude Spectrum of X(f)')
plot(f,P11x) 
xlabel('f (Hz)')
ylabel('|P1x(f)|')

%figure;
subplot(3,1,2)
title('Single-Sided Amplitude Spectrum of Y(f)')
plot(f,P11y) 
xlabel('f (Hz)')
ylabel('|P1y(f)|')

%figure;
subplot(3,1,3)
title('Single-Sided Amplitude Spectrum of Z(t)')
plot(f,P11z) 
xlabel('f (Hz)')
ylabel('|P1z(f)|')