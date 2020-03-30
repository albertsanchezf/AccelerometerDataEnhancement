%% Import data from spreadsheet
%  Script for importing data from the following spreadsheet:
%
%    Workbook: /Users/AlbertSanchez/Dropbox/TFM/NoUserTaggedData/TimeDomain/NoUserTaggedData.xlsx
%    Worksheets: Type 1-8
%

%% Import the data

[~,sheet_name]=xlsfinfo('/Users/AlbertSanchez/Dropbox/TFM/NoUserTaggedData/TimeDomain/NoUserTaggedData.xlsx');
raw = cell(1,numel(sheet_name));
for k=1:numel(sheet_name)
    [~, ~, rawTemp] = xlsread('/Users/AlbertSanchez/Dropbox/TFM/NoUserTaggedData/TimeDomain/NoUserTaggedData.xlsx',sheet_name{k});
    rawTemp = rawTemp(2:end,2:end);
    raw{k} = rawTemp;
end

%% Create output variable

data = cell(1,numel(sheet_name));
for k=1:numel(sheet_name)
    data{k} = reshape(cell2mat(raw{k}),size(raw{k}));
end

%% Allocate imported array to column variable names

Key        = cell(1,numel(sheet_name));
Type       = cell(1,numel(sheet_name));
Latitude   = cell(1,numel(sheet_name));
Longitude  = cell(1,numel(sheet_name));
Acc_X      = cell(1,numel(sheet_name));
Acc_Y      = cell(1,numel(sheet_name));
Acc_Z      = cell(1,numel(sheet_name));
Timestamp  = cell(1,numel(sheet_name));
%Acc_68    = cell(1,numel(sheet_name));
Gyr_a      = cell(1,numel(sheet_name));
Gyr_b      = cell(1,numel(sheet_name));
Gyr_c      = cell(1,numel(sheet_name));

for k=1:numel(sheet_name)
    Key{k}       = data{k}(:,1);
    Type{k}      = data{k}(:,2);
    Latitude{k}  = data{k}(:,3);
    Longitude{k} = data{k}(:,4);
    Acc_X{k}     = data{k}(:,5);
    Acc_Y{k}     = data{k}(:,6);
    Acc_Z{k}     = data{k}(:,7);
    Timestamp{k} = data{k}(:,8);
    %Acc_68{k}   = data{k}(:,9);
    Gyr_a{k}     = data{k}(:,10);
    Gyr_b{k}     = data{k}(:,11);
    Gyr_c{k}     = data{k}(:,12);
end

%% Clear temporary variables
clearvars data raw rawTemp sheet_name k;
