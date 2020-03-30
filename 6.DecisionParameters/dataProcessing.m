clear all; clc; close all;

load NoUserTaggedData.mat;

% Incident_Type = 1; % From 1 to 8
% nSignals = 2; % Number of signals that what to be used

typeNSignalsAcc = zeros(1,8);
typeNSignalsGyr = zeros(1,8);

allMeans    = cell(2,3);
allVar      = cell(2,3);
allStd      = cell(2,3);
allMedian   = cell(2,3);
allMax      = cell(2,3);
allMin      = cell(2,3);
sma         = cell(2,1);
svmMeans    = cell(2,1);
svmVar      = cell(2,1);
svmStd      = cell(2,1);

allMeansGyr  = cell(2,3);
allVarGyr 	 = cell(2,3);
allStdGyr 	 = cell(2,3);
allMedianGyr = cell(2,3);
allMaxGyr 	 = cell(2,3);
allMinGyr 	 = cell(2,3);
smaGyr 		 = cell(2,1);
svmMeansGyr  = cell(2,1);
svmVarGyr 	 = cell(2,1);
svmStdGyr 	 = cell(2,1);

cAcc = [;;];
cGyr = [;;];
colors = {[0,0,0],[1,0,0],[0,1,0],[0,0,1],...
          [1,1,0],[1,0,1],[0,1,1],[0.5,0.5,0.5]};
cmap = [0,0,0;1,0,0;0,1,0;...
        0,0,1;1,1,0;1,0,1;...
        0,1,1;0.5,0.5,0.5];

for Incident_Type=1:8
    
    % Find indexes and lengths for the different signals
    inx = find(logical(diff(Key{Incident_Type}))); 
    lengths = zeros(length(inx)+1,1);
    lengths(1) = inx(1);
    for i=1:length(inx)-1
        lengths(i+1) = inx(i+1) - inx(i);
    end
    lengths(end) = length(Key{Incident_Type}) - inx(end);

    [x_acc,y_acc,z_acc] = resampleSignalsv2(inx,lengths,Acc_X,Acc_Y,Acc_Z,Incident_Type,5);
    [a_gyr,b_gyr,c_gyr] = resampleSignalsv2(inx,lengths,Gyr_a,Gyr_b,Gyr_c,Incident_Type,5);
    plotResampledSignals(x_acc,y_acc,z_acc);
    plotResampledSignals(a_gyr,b_gyr,c_gyr);
    
    [~,nSignalsAcc] = size(x_acc);
    [~,nSignalsGyr] = size(a_gyr);
    
    cAcc = [cAcc; repmat(colors{Incident_Type},nSignalsAcc,1)];
    cGyr = [cGyr; repmat(colors{Incident_Type},nSignalsGyr,1)];

    typeNSignalsAcc(Incident_Type) = nSignalsAcc;
    typeNSignalsGyr(Incident_Type) = nSignalsGyr;
    [allMeans,allVar,allStd,allMedian,allMax,allMin,sma,svm,svmMeans,...
        svmVar,svmStd] = calculateStatistics(allMeans,allVar,allStd,...
        allMedian,allMax,allMin,sma,svmMeans,svmVar,svmStd,x_acc,y_acc,z_acc);
    
    [allMeansGyr,allVarGyr,allStdGyr,allMedianGyr,allMaxGyr,allMinGyr,smaGyr,svmGyr,svmMeansGyr,...
        svmVarGyr,svmStdGyr] = calculateStatistics(allMeansGyr,allVarGyr,allStdGyr,...
        allMedianGyr,allMaxGyr,allMinGyr,smaGyr,svmMeansGyr,svmVarGyr,svmStdGyr,a_gyr,b_gyr,c_gyr);
    
end

nTotalSignalsAcc = sum(typeNSignalsAcc);
nTotalSignalsGyr = sum(typeNSignalsGyr);

% Plot X Axis: MEAN, VAR, STD
plot3fx_withColormap('Mean Value',allMeans{1,1},allMeans{2,1},...
                     'Variance Value',allVar{1,1},allVar{2,1},...
                     'Standard Deviation Value',allStd{1,1},allStd{2,1},...
                     'Accelerometer X Axis',nTotalSignalsAcc,cAcc,cmap,typeNSignalsAcc);

% Plot X Axis: MEDIAN, MAX, MIN
plot3fx_withColormap('Median Value',allMedian{1,1},allMedian{2,1},...
                     'Max Value',allMax{1,1},allMax{2,1},...
                     'Min Value',allMin{1,1},allMin{2,1},...
                     'Accelerometer X Axis',nTotalSignalsAcc,cAcc,cmap,typeNSignalsAcc);

% Plot Y Axis: MEAN, VAR, STD
plot3fx_withColormap('Mean Value',allMeans{1,2},allMeans{2,2},...
                     'Variance Value',allVar{1,2},allVar{2,2},...
                     'Standard Deviation Value',allStd{1,2},allStd{2,2},...
                     'Accelerometer Y Axis',nTotalSignalsAcc,cAcc,cmap,typeNSignalsAcc);

% Plot Y Axis: MEDIAN, MAX, MIN
plot3fx_withColormap('Median Value',allMedian{1,2},allMedian{2,2},...
                     'Max Value',allMax{1,2},allMax{2,2},...
                     'Min Value',allMin{1,2},allMin{2,2},...
                     'Accelerometer Y Axis',nTotalSignalsAcc,cAcc,cmap,typeNSignalsAcc);

% Plot Z Axis: MEAN, VAR, STD
plot3fx_withColormap('Mean Value',allMeans{1,3},allMeans{2,3},...
                     'Variance Value',allVar{1,3},allVar{2,3},...
                     'Standard Deviation Value',allStd{1,3},allStd{2,3},...
                     'Accelerometer Z Axis',nTotalSignalsAcc,cAcc,cmap,typeNSignalsAcc);

% Plot Z Axis: MEDIAN, MAX, MIN
plot3fx_withColormap('Median Value',allMedian{1,3},allMedian{2,3},...
                     'Max Value',allMax{1,3},allMax{2,3},...
                     'Min Value',allMin{1,3},allMin{2,3},...
                     'Accelerometer Z Axis',nTotalSignalsAcc,cAcc,cmap,typeNSignalsAcc);

% Plot SMA
figure;
scatter(1:nTotalSignalsAcc,sma{1},25,cAcc);
if sma{2} ~= 0
    offset = 1;
    for i=1:length(typeNSignalsAcc)
        x1 = offset;
        x2 = offset + typeNSignalsAcc(i) - 1;
        line([x1,x2],[sma{2}(i),sma{2}(i)]);
        offset = x2 + 1;
    end
end
title('SMA')

colormap(cmap);
chb = colorbar();
set(chb,'Ticks',0.125/2:0.125:1,'TickLabels',...
    {'Typ.1','Typ.2','Typ.3','Typ.4','Typ.5','Typ.6','Typ.7','Typ.8'});

% Plot SVM: MEAN, VAR, STD
plot3fx_withColormap('Mean Value',svmMeans{1},svmMeans{2},...
                     'Variance Value',svmVar{1},svmVar{2},...
                     'Starndard Deviation Value',svmStd{1},svmStd{2},...
                     'SVM Statistics',nTotalSignalsAcc,cAcc,cmap,typeNSignalsAcc);

%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------

% % Plot Gyroscope A: MEAN, VAR, STD
% plot3fx_withColormap('Mean Value',allMeansGyr{1,1},allMeansGyr{2,1},...
%                      'Variance Value',allVarGyr{1,1},allVarGyr{2,1},...
%                      'Standard Deviation Value',allStdGyr{1,1},allStdGyr{2,1},...
%                      'Gyroscope A',nTotalSignalsGyr,cGyr,cmap,typeNSignalsGyr);
% 
% % Plot Gyroscope A: MEDIAN, MAX, MIN
% plot3fx_withColormap('Median Value',allMedianGyr{1,1},allMedianGyr{2,1},...
%                      'Max Value',allMaxGyr{1,1},allMaxGyr{2,1},...
%                      'Min Value',allMinGyr{1,1},allMinGyr{2,1},...
%                      'Gyroscope A',nTotalSignalsGyr,cGyr,cmap,typeNSignalsGyr);
% 
% % Plot Gyroscope B: MEAN, VAR, STD
% plot3fx_withColormap('Mean Value',allMeansGyr{1,2},allMeansGyr{2,2},...
%                      'Variance Value',allVarGyr{1,2},allVarGyr{2,2},...
%                      'Standard Deviation Value',allStdGyr{1,2},allStdGyr{2,2},...
%                      'Gyroscope B',nTotalSignalsGyr,cGyr,cmap,typeNSignalsGyr);
% 
% % Plot Gyroscope B: MEDIAN, MAX, MIN
% plot3fx_withColormap('Median Value',allMedianGyr{1,2},allMedianGyr{2,2},...
%                      'Max Value',allMaxGyr{1,2},allMaxGyr{2,2},...
%                      'Min Value',allMinGyr{1,2},allMinGyr{2,2},...
%                      'Gyroscope B',nTotalSignalsGyr,cGyr,cmap,typeNSignalsGyr);
% 
% % Plot Gyroscope C: MEAN, VAR, STD
% plot3fx_withColormap('Mean Value',allMeansGyr{1,3},allMeansGyr{2,3},...
%                      'Variance Value',allVarGyr{1,3},allVarGyr{2,3},...
%                      'Standard Deviation Value',allStdGyr{1,3},allStdGyr{2,3},...
%                      'Gyroscope C',nTotalSignalsGyr,cGyr,cmap,typeNSignalsGyr);
% 
% % Plot Gyroscope C: MEDIAN, MAX, MIN
% plot3fx_withColormap('Median Value',allMedianGyr{1,3},allMedianGyr{2,3},...
%                      'Max Value',allMaxGyr{1,3},allMaxGyr{2,3},...
%                      'Min Value',allMinGyr{1,3},allMinGyr{2,3},...
%                      'Gyroscope C',nTotalSignalsGyr,cGyr,cmap,typeNSignalsGyr);
% 
% % Plot Gyroscope SMA
% figure;
% scatter(1:nTotalSignalsGyr,smaGyr{1},25,cGyr);
% if smaGyr{2} ~= 0
%     offset = 1;
%     for i=1:length(typeNSignalsGyr)
%         x1 = offset;
%         x2 = offset + typeNSignalsGyr(i) - 1;
%         line([x1,x2],[smaGyr{2}(i),smaGyr{2}(i)]);
%         offset = x2 + 1;
%     end
% end
% title('Gyroscope SMA ')
% 
% colormap(cmap);
% chb = colorbar();
% set(chb,'Ticks',0.125/2:0.125:1,'TickLabels',...
%     {'Typ.1','Typ.2','Typ.3','Typ.4','Typ.5','Typ.6','Typ.7','Typ.8'});
% 
% % Plot Gyroscope SVM: MEAN, VAR, STD
% plot3fx_withColormap('Mean Value',svmMeansGyr{1},svmMeansGyr{2},...
%                      'Variance Value',svmVarGyr{1},svmVarGyr{2},...
%                      'Starndard Deviation Value',svmStdGyr{1},svmStdGyr{2},...
%                      'Gyroscope SVM Statistics',nTotalSignalsGyr,cGyr,cmap,typeNSignalsGyr);
% 
