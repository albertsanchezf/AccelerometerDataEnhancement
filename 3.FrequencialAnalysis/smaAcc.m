function [sma] = smaAcc(x,y,z)

[xLength, xSignals] = size(x);

sma = (1/xLength) * (trapz(abs(x))+trapz(abs(y))+trapz(abs(z)));

end

