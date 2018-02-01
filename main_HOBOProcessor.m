%Data Logger Processing Script - Main
%Author: Zachary Lippay and Grayson Woods

%DESCRIPTION: This program is designed to process .csv files from Onset 
%(HOBO) data loggers.
%
%INSTRUCTIONS: Input the following values:
%   1. "Location": Location of file in format of 'C:\Users\...' (the
%   example shown is for Windows users. Try going to the file location and
%   changing the current path to that folder and typing 'pwd' into the
%   command window. copy and paste that text for the file location. Then
%   type the file name.)
%   2. "Number": Define the starting point of the data set (exclude data
%   that is not applicable)
%   3. "Voltage": Define operating voltage(typically 460 V or 480 V)
%   4. "Current_Limit": Define the minimum operating current that should be
%   considered in analysis (exclude data that is not significant)
%   5. "Average_Roll": Define number of cells to average data over (for
%   rolling average)
%   6. "Start_Date": Define the start date in the form ' M-D-YYYY '
%   7. "End_Date": Define end date in the form ' M-D-YYYY '
%
%TIPS: 
%   1. It is a good practice to look at the "Raw Current" in the generated
%   figures to ensure the processed data was not significantly changed from
%   the raw data.
%   2. Compare the "Usefull Load" to the "Electrical Load" to ensure that
%   the program functioned properly.
clc                                     %Clear command window
clear all                               %Clear workspace
close all                               %Clear all figures
%% User Input
Location = '/Users/zlipp3032/Google Drive/KIAC/Assessments - working directory/1801 Bekaert/Post Assessment/Data Loggers/1801_Comp1.csv';
Number = 1000; 
Voltage = 480; 
Current_Limit = 10;
Average_Roll = 100;
% Title = 'Compressor 1';
%% Analysis
[Time_Stamp,LF1,TPL1,AP1,RC1,AC1,Scoobie1,URC1,CEU1,t1,Title] = processor_HOBOProcessor(Location,Voltage,Number,Average_Roll,Current_Limit);
disp(['Load Factor: ' num2str(LF1,3)])                       
disp(['Percentage of time equipment is loaded (with respect to 8,760 hr/yr): ' num2str(TPL1)])
disp(['Average Power Draw: ' num2str(AP1,3) ' kW'])             
disp(['Current Annual Energy Usage: ' num2str(CEU1,7) ' kWh/yr']) 
plotFunction_HOBOProcessor(Time_Stamp,RC1,AC1,URC1,Scoobie1,Title)

