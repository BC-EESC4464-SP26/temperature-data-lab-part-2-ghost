function [baseline_model, P, anomaly, smooth] = StationModelProjections(station_number)

% StationModelProjections Analyze modeled future temperature projections at individual stations
%===================================================================
%
% USAGE:  [baseline_model, P, anomaly] = StationModelProjections(station_number) <--update here
%
% DESCRIPTION:
%   **Add your description here**
%
% INPUT:
%    staton_number: Number of the station from which to analyze historical temperature data
%    **Describe any other inputs you choose to include**
%
% OUTPUT:
%    baseline_model: [mean annual temperature over baseline period
%       (2006-2025); standard deviation of temperature over baseline period]
%    P: slope and intercept for a linear fit to annual mean temperature
%       values over the full 21st century modeled period
%    anomaly: annual mean temperture anomaly for each year, as compared to
%       baseline period
%   
% AUTHOR:   Nicole and Celia
%
% REFERENCE:
%    Written for EESC 4464: Environmental Data Exploration and Analysis, Boston College
%    Data are from the a global climate model developed by the NOAA
%       Geophysical Fluid Dynamics Laboratory (GFDL) in Princeton, NJ - output
%       from the A2 scenario extracted by Sarah Purkey for the University of
%       Washington's Program on Climate Change
%==================================================================

%% Read and extract the data from your station from the csv file
filename = ['model' num2str(station_number) '.csv'];
stationdata = readtable(filename);
%Extract the year and annual mean temperature data
Year = stationdata.Year; 
AnnualMeanTemperature = stationdata.AnnualMeanTemperature;

%% Calculate the mean and standard deviation of the annual mean temperatures
%  over the baseline period over the first 20 years of the modeled 21st
%  century (2006-2025) - if you follow the template for output values I
%  provided above, you will want to combine these together into an array
%  with both values called baseline_model
baseline_model = NaN(1,2); % making the array 
baseline = find(stationdata.Year >= 2006 & stationdata.Year <= 2025); %extracting baseline year rows
mean_baseline = mean(stationdata.AnnualMeanTemperature(baseline)); % finding average of just the baseline years in mean temperature
baseline_model(:, 1) = mean_baseline; % putting mean value into array 
baseline_model(:, 2) = std(stationdata.AnnualMeanTemperature(baseline)); % putting stdev into array
 %followed in Part 1 for a reminder of how you can do this)


%% Calculate the 5-year moving mean smoothed annual mean temperature anomaly over the modeled period
% Note that you could choose to provide these as an output if you want to
% have these values available to plot.
 anomaly = stationdata.AnnualMeanTemperature - mean_baseline;  % difference between annual mean temperature and baseline = anomaly
 smooth = movemean(anomaly, 5); % movemen 5 years

%% Calculate the linear trend in temperature this station over the modeled 21st century period
 P = polyfit(stationdata.Year, anomaly, 1); % linear trend slope and intercept 

end

