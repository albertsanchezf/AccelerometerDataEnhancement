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

    if nargin == 7
        lengths = lengths(1:nSignals,:);
        inx = inx(1:nSignals-1,:);
    end
    maxSize = max(lengths);
    idx = find(lengths == maxSize);

    x = zeros(maxSize,length(lengths));
    y = zeros(maxSize,length(lengths));
    z = zeros(maxSize,length(lengths));

    % Sample #1
    x_tmp = Acc_X{Incident_Type}(1:lengths(1));
    y_tmp = Acc_Y{Incident_Type}(1:lengths(1));
    z_tmp = Acc_Z{Incident_Type}(1:lengths(1));    

    if find(idx == 1)
        x(:,1) = x_tmp;
        y(:,1) = y_tmp;
        z(:,1) = z_tmp;
    else
        Lp = ceil(length(x_tmp)*maxSize/lengths(1));
        
        fx = [flip(x_tmp);x_tmp;flip(x_tmp)];
        fy = [flip(y_tmp);y_tmp;flip(y_tmp)];
        fz = [flip(z_tmp);z_tmp;flip(z_tmp)];
        
        px = resample(fx,maxSize,lengths(1));
        py = resample(fy,maxSize,lengths(1));
        pz = resample(fz,maxSize,lengths(1));

        x(:,1) = px(Lp:2*Lp-1);
        y(:,1) = py(Lp:2*Lp-1);
        z(:,1) = pz(Lp:2*Lp-1);
    end

    % Sample #2 to #N-1
    for i=2:length(lengths)-1

        x_tmp = Acc_X{Incident_Type}(inx(i-1)+1:inx(i-1)+lengths(i));
        y_tmp = Acc_Y{Incident_Type}(inx(i-1)+1:inx(i-1)+lengths(i));
        z_tmp = Acc_Z{Incident_Type}(inx(i-1)+1:inx(i-1)+lengths(i));

        if find(idx == i)
            x(:,i) = x_tmp; 
            y(:,i) = y_tmp; 
            z(:,i) = z_tmp; 
        else
            Lp = ceil(length(x_tmp)*maxSize/lengths(i));

            fx = [flip(x_tmp);x_tmp;flip(x_tmp)];
            fy = [flip(y_tmp);y_tmp;flip(y_tmp)];
            fz = [flip(z_tmp);z_tmp;flip(z_tmp)];
        
            px = resample(fx,maxSize,lengths(i));
            py = resample(fy,maxSize,lengths(i));
            pz = resample(fz,maxSize,lengths(i));

            x(:,i) = px(Lp:2*Lp-1);
            y(:,i) = py(Lp:2*Lp-1);
            z(:,i) = pz(Lp:2*Lp-1);
        end
    end

    % Sample #N
    if length(lengths) > 1
        
        x_tmp = Acc_X{Incident_Type}(inx(end)+1:inx(end)+lengths(end));
        y_tmp = Acc_Y{Incident_Type}(inx(end)+1:inx(end)+lengths(end));
        z_tmp = Acc_Z{Incident_Type}(inx(end)+1:inx(end)+lengths(end));
        
        if find(idx == length(lengths))
            x(:,length(lengths)) = x_tmp;
            y(:,length(lengths)) = y_tmp;
            z(:,length(lengths)) = z_tmp;
        else
            Lp = ceil(length(x_tmp)*maxSize/lengths(end));

            fx = [flip(x_tmp);x_tmp;flip(x_tmp)];
            fy = [flip(y_tmp);y_tmp;flip(y_tmp)];
            fz = [flip(z_tmp);z_tmp;flip(z_tmp)];
        
            px = resample(fx,maxSize,lengths(end));
            py = resample(fy,maxSize,lengths(end));
            pz = resample(fz,maxSize,lengths(end));

            x(:,i) = px(Lp:2*Lp-1);
            y(:,i) = py(Lp:2*Lp-1);
            z(:,i) = pz(Lp:2*Lp-1);
        end
    end

end

