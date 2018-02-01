%Data Logger Processing Script - Processing Function
%Author: Zachary Lippay
%
function [Time_Stamp,Load_Factor,Time_Percentage_Loaded,Average_Power,Real_Current,Average_Current,Scoobiedoo,Useful_Real_Current,Current_Energy_Usage,t,Title] = processor_HOBOProcessor(hobodata,Voltage,wu,averageroll,MRC,Time)

% Import parameters from the .csv file
A = importdata(hobodata);
Real_Current = A.data; 
Memory_Slot = A.textdata(:,1);
Time_Stamp = A.textdata(:,2);

Title = Memory_Slot(1);

% Create a rolling average of the real current to eliminate unwanted data
for i = (1+averageroll):(length(Real_Current)-averageroll)
    t(i,1) = i;
    Average_Current(i,1) = mean(Real_Current(i:i+averageroll));
end

% Compute the data that pertains to the useful load
q=1;
for h = (1+wu):(length(Real_Current)-wu)
    if (Real_Current(h+wu) > MRC) || (Real_Current(h-wu) > MRC)
        Useful_Real_Current(q) = Real_Current(h);
        q = q + 1;
    end
end

% Determine the relevant values for an AC induction motor and display in
% MATLAB terminal
Scoobiedoo = Average_Current(Average_Current>mean(Real_Current));
% display('The average power of the loaded item is shown below in kilowatts (kW):')
Average_Power = mean(Scoobiedoo)*(sqrt(3)*Voltage/1000);
% display('The time percentage the induction motor is drawing electricity is shown below (WRT 8760 hr/yr):')
Time_Percentage_Loaded = length(Scoobiedoo)/length(Useful_Real_Current);
% display('The Load Factor of the induction motor is shown below:')
Load_Factor = Average_Power/(sqrt(3)*max(Scoobiedoo)*Voltage/1000);
Current_Energy_Usage = Average_Power*8760*Time_Percentage_Loaded;
end