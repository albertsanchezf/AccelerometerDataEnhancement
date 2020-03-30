function [] = fft_plot(Fs, L, x, y, z)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

    T = 1/Fs;
    t = (0:L-1)*T; 
    
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
    legend('Type 1','Type 2','Type 3','Type 4','Type 5','Type 6','Type 7','Type 8')

    %figure;
    subplot(3,1,2)
    title('Single-Sided Amplitude Spectrum of Y(f)')
    plot(f,P11y) 
    xlabel('f (Hz)')
    ylabel('|P1y(f)|')
    legend('Type 1','Type 2','Type 3','Type 4','Type 5','Type 6','Type 7','Type 8')

    %figure;
    subplot(3,1,3)
    title('Single-Sided Amplitude Spectrum of Z(f)')
    plot(f,P11z) 
    xlabel('f (Hz)')
    ylabel('|P1z(f)|')
    legend('Type 1','Type 2','Type 3','Type 4','Type 5','Type 6','Type 7','Type 8')


end

