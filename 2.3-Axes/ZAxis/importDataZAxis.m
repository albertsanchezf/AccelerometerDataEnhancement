%% Import data from spreadsheet
% Script for importing data from the following spreadsheet:
%
%    Workbook: /Users/AlbertSanchez/Dropbox/TFM/AccelerometerTestsMatlab/ZAxis/Z_Axis.xlsx
%    Worksheet: Sheet1
%
% To extend the code for use with different selected data or a different
% spreadsheet, generate a function instead of a script.

%% Import the data
[~, ~, raw] = xlsread('/Users/AlbertSanchez/Dropbox/TFM/AccelerometerTestsMatlab/ZAxis/Z_Axis.xlsx','Sheet1');
raw = raw(2:end,:);
raw(cellfun(@(x) ~isempty(x) && isnumeric(x) && isnan(x),raw)) = {''};

%% Replace non-numeric cells with NaN
R = cellfun(@(x) ~isnumeric(x) && ~islogical(x),raw); % Find non-numeric cells
raw(R) = {NaN}; % Replace non-numeric cells

%% Create output variable
data = reshape([raw{:}],size(raw));

%% Allocate imported array to column variable names
x = data(:,1);
y = data(:,2);
z = data(:,3);
timestamp = data(:,4);

% Useful variables
L = length(x);
Fs = 10;
Ts = 1/Fs;
ts = (0:L-1)*Ts;

%% Clear temporary variables
clearvars data raw R timestamp;