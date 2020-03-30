clear all; clc; close all;

%% --- Raw Data import ---
      
% L = length(x);
% Fs = 10;
% Ts = 1/Fs;
% ts = (0:L-1)*Ts;

load acc_y_axis;

% Plot Raw Data
figure;
suptitle('Accelerometer induced error - RAW Data')
subplot(3,1,1)
plot(ts,x)
ylabel('x');xlabel('t(s)');
subplot(3,1,2)
plot(ts,y)
ylabel('y');xlabel('t(s)');
subplot(3,1,3)
plot(ts,z)
ylabel('z');xlabel('t(s)');

% ------------------------

%% ---- Raw Data FFT -----

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

f1 = Fs*(0:(L/2))/L;

% Plot FFT Data
figure;
suptitle('Accelerometer induced error - FFT')
subplot(3,1,1);
plot(f1,P11x) 
xlabel('f (Hz)'); ylabel('|P1X(f)|')

subplot(3,1,2);
plot(f1,P11y) 
xlabel('f (Hz)'); ylabel('|P1Y(f)|');

subplot(3,1,3);
plot(f1,P11z) 
xlabel('f (Hz)'); ylabel('|P1Z(f)|');

% ------------------------

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
figure;
suptitle('Accelerometer induced error HPF')
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
% Filter 1 (0-4.9Hz) ------------------------------------------------
fc1 = 4.9;

lp1 = designfilt('lowpassfir','FilterOrder',20,'CutoffFrequency',fc1, ...
       'DesignMethod','window','Window',{@kaiser,3},'SampleRate',Fs);

fvtool(lp1,1,'Fs',Fs)

xLP1 = filter(lp1,x);
yLP1 = filter(lp1,y);
zLP1 = filter(lp1,z);


% Plot Filtered Data
figure;
suptitle('Accelerometer induced error LPF1 (0-4.9 Hz)')
subplot(3,1,1)
plot(ts,xLP1)
ylabel('x'); xlabel('t(s)');
subplot(3,1,2)
plot(ts,yLP1)
ylabel('y');xlabel('t(s)');
subplot(3,1,3)
plot(ts,zLP1)
ylabel('z');xlabel('t(s)');

% -----------------------------------------------------------------
% Filter 2 (0-3Hz) ------------------------------------------------
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
%% -- Filtered Data FFT --

% High Pass Filter 1
XHP1 = fft(xHP1);
YHP1 = fft(yHP1);
ZHP1 = fft(zHP1);

P21xHP1 = abs(XHP1/L);
P21yHP1 = abs(YHP1/L);
P21zHP1 = abs(ZHP1/L);

P11xHP1 = P21xHP1(1:L/2+1,:);
P11yHP1 = P21yHP1(1:L/2+1,:);
P11zHP1 = P21zHP1(1:L/2+1,:);

P11xHP1(2:end-1) = 2*P11xHP1(2:end-1);
P11yHP1(2:end-1) = 2*P11yHP1(2:end-1);
P11zHP1(2:end-1) = 2*P11zHP1(2:end-1);

% Low Pass Filter 1
XLP1 = fft(xLP1);
YLP1 = fft(yLP1);
ZLP1 = fft(zLP1);

P21xLP1 = abs(XLP1/L);
P21yLP1 = abs(YLP1/L);
P21zLP1 = abs(ZLP1/L);

P11xLP1 = P21xLP1(1:L/2+1,:);
P11yLP1 = P21yLP1(1:L/2+1,:);
P11zLP1 = P21zLP1(1:L/2+1,:);

P11xLP1(2:end-1) = 2*P11xLP1(2:end-1);
P11yLP1(2:end-1) = 2*P11yLP1(2:end-1);
P11zLP1(2:end-1) = 2*P11zLP1(2:end-1);

% Low Pass Filter 2
XLP2 = fft(xLP2);
YLP2 = fft(yLP2);
ZLP2 = fft(zLP2);

P21xLP2 = abs(XLP2/L);
P21yLP2 = abs(YLP2/L);
P21zLP2 = abs(ZLP2/L);

P11xLP2 = P21xLP2(1:L/2+1,:);
P11yLP2 = P21yLP2(1:L/2+1,:);
P11zLP2 = P21zLP2(1:L/2+1,:);

P11xLP2(2:end-1) = 2*P11xLP2(2:end-1);
P11yLP2(2:end-1) = 2*P11yLP2(2:end-1);
P11zLP2(2:end-1) = 2*P11zLP2(2:end-1);

% Band Pass Filter 1
XBP1 = fft(xBP1);
YBP1 = fft(yBP1);
ZBP1 = fft(zBP1);

P21xBP1 = abs(XBP1/L);
P21yBP1 = abs(YBP1/L);
P21zBP1 = abs(ZBP1/L);

P11xBP1 = P21xBP1(1:L/2+1,:);
P11yBP1 = P21yBP1(1:L/2+1,:);
P11zBP1 = P21zBP1(1:L/2+1,:);

P11xBP1(2:end-1) = 2*P11xBP1(2:end-1);
P11yBP1(2:end-1) = 2*P11yBP1(2:end-1);
P11zBP1(2:end-1) = 2*P11zBP1(2:end-1);

% Plot Filtered Data FFT
% HP1
figure;
suptitle('Accelerometer induced error - FFT - HP1 Filter')
subplot(3,1,1);
plot(f1,P11xHP1) 
xlabel('f (Hz)'); ylabel('|P1X(f)|')

subplot(3,1,2);
plot(f1,P11yHP1) 
xlabel('f (Hz)'); ylabel('|P1Y(f)|')

subplot(3,1,3);
plot(f1,P11zHP1) 
xlabel('f (Hz)'); ylabel('|P1Z(f)|')

% Plot Filtered Data FFT
% LP1
figure;
suptitle('Accelerometer induced error - FFT - LP1 Filter')
subplot(3,1,1);
plot(f1,P11xLP1) 
xlabel('f (Hz)'); ylabel('|P1X(f)|')

subplot(3,1,2);
plot(f1,P11yLP1) 
xlabel('f (Hz)'); ylabel('|P1Y(f)|')

subplot(3,1,3);
plot(f1,P11zLP1) 
xlabel('f (Hz)'); ylabel('|P1Z(f)|')

% Plot Filtered Data FFT
% LP2
figure;
suptitle('Accelerometer induced error - FFT - LP2 Filter')
subplot(3,1,1);
plot(f1,P11xLP2) 
xlabel('f (Hz)'); ylabel('|P1X(f)|')

subplot(3,1,2);
plot(f1,P11yLP2) 
xlabel('f (Hz)'); ylabel('|P1Y(f)|')

subplot(3,1,3);
plot(f1,P11zLP2) 
xlabel('f (Hz)'); ylabel('|P1Z(f)|')

% Plot Filtered Data FFT
% BP1
figure;
suptitle('Accelerometer induced error - FFT - BP1 Filter')
subplot(3,1,1);
plot(f1,P11xBP1) 
xlabel('f (Hz)'); ylabel('|P1X(f)|')

subplot(3,1,2);
plot(f1,P11yBP1) 
xlabel('f (Hz)'); ylabel('|P1Y(f)|')

subplot(3,1,3);
plot(f1,P11zBP1) 
xlabel('f (Hz)'); ylabel('|P1Z(f)|')

%% Summary Plots

figure;
suptitle('Accelerometer induced error - RAW Data')
subplot(3,1,1)
hold on;
plot(ts,x);plot(ts,xHP1);plot(ts,xLP1);plot(ts,xLP2);plot(ts,xBP1);
ylabel('x');xlabel('t(s)');
hold off;
legend('Raw','HPF','LPF(0-3Hz)','LPF(0-4.9Hz)','BPF(0.5-3Hz)');
subplot(3,1,2)
hold on;
plot(ts,y);plot(ts,yHP1);plot(ts,yLP1);plot(ts,yLP2);plot(ts,yBP1);
ylabel('y');xlabel('t(s)');
hold off;
legend('Raw','HPF','LPF(0-3Hz)','LPF(0-4.9Hz)','BPF(0.5-3Hz)');
subplot(3,1,3)
hold on;
plot(ts,z);plot(ts,zHP1);plot(ts,zLP1);plot(ts,zLP2);plot(ts,zBP1);
ylabel('z');xlabel('t(s)');
hold off;
legend('Raw','HPF','LPF(0-3Hz)','LPF(0-4.9Hz)','BPF(0.5-3Hz)');
