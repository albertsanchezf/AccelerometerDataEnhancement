function [x,y,z] = resampleSignals(inx,lengths,Acc_X,Acc_Y,Acc_Z,...
    Incident_Type,nSignals)
%resampleSignals: Resample all the X, Y, Z signals to obtain the same 
%                 n? of samples
% Input:
% - inx: Vector(N-1,1) with the starting indexes from each signal in Acc_*
% - lengths: Vector(N,1) with the lenghts of the diferent signals in X,Y,Z 
% - Acc_X: Vector(M,1) with the X component of the accelerometer
% - Acc_Y: Vector(M,1) with the Y component of the accelerometer
% - Acc_Z: Vector(M,1) with the Z component of the accelerometer
% - Incident Type: Integer with the incident type evaluated
% - nSignals: # of Signals that want to be used. If null, use all signals
%
% Output
% - X: Matrix(M,N) with the N signals from Acc_X and the M samples
% - Y: Matrix(M,N) with the N signals from Acc_Y and the M samples
% - Z: Matrix(M,N) with the N signals from Acc_Z and the M samples

    if nargin == 6
        nSignals = length(lengths);
    end
    maxSize = max(lengths);
    idx = find(lengths == maxSize);

    x = zeros(maxSize,length(lengths));
    y = zeros(maxSize,length(lengths));
    z = zeros(maxSize,length(lengths));

    if find(idx == 1)
        x(:,1) = Acc_X{Incident_Type}(1:inx(1));
        y(:,1) = Acc_Y{Incident_Type}(1:inx(1));
        z(:,1) = Acc_Z{Incident_Type}(1:inx(1));
    else
        x(:,1) = resample(Acc_X{Incident_Type}(1:inx(1)),maxSize,inx(1));
        y(:,1) = resample(Acc_Y{Incident_Type}(1:inx(1)),maxSize,inx(1));
        z(:,1) = resample(Acc_Z{Incident_Type}(1:inx(1)),maxSize,inx(1));
    end

    for i=2:length(lengths)-1
        if find(idx == i)
            x(:,i) = Acc_X{Incident_Type}(inx(i-1)+1:inx(i));
            y(:,i) = Acc_Y{Incident_Type}(inx(i-1)+1:inx(i));
            z(:,i) = Acc_Z{Incident_Type}(inx(i-1)+1:inx(i));
        else
            x(:,i) = resample(Acc_X{Incident_Type}(inx(i-1)+1:inx(i)),maxSize,lengths(i));
            y(:,i) = resample(Acc_Y{Incident_Type}(inx(i-1)+1:inx(i)),maxSize,lengths(i));
            z(:,i) = resample(Acc_Z{Incident_Type}(inx(i-1)+1:inx(i)),maxSize,lengths(i));
        end
    end

    if find(idx == length(lengths))
        x(:,length(lengths)) = Acc_X{Incident_Type}(inx(end)+1:end);
        y(:,length(lengths)) = Acc_Y{Incident_Type}(inx(end)+1:end);
        z(:,length(lengths)) = Acc_Z{Incident_Type}(inx(end)+1:end);
    else
        x(:,length(lengths)) = resample(Acc_X{Incident_Type}(inx(end)+1:end),maxSize,lengths(end));
        y(:,length(lengths)) = resample(Acc_Y{Incident_Type}(inx(end)+1:end),maxSize,lengths(end));
        z(:,length(lengths)) = resample(Acc_Z{Incident_Type}(inx(end)+1:end),maxSize,lengths(end));
    end
    
    x = x(:,1:nSignals);
    y = y(:,1:nSignals);
    z = z(:,1:nSignals);
end

