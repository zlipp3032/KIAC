% Data Logger Processing Script
% Zachary Lippay
% 
clear
clc
close all
% 
% File location of HOBO .csv file ---> Need to update for each data logger
hobodata = '/Users/zlipp3032/Desktop/HOBO CSVs/1714_Primary_Aerator.csv';
%
Voltage = 480; % Input voltage to equipment being analyzed
%
% Import and define the data arrays from the .csv file
A = importdata(hobodata);
Real_Current = A.data; 
Memory_Slot = A.textdata(:,1);
Time_Stamp = A.textdata(:,2);
y = linspace(0,length(Real_Current),length(Real_Current));
% 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Create a rolling average of the real current to eliminate unwanted data
MRC = 10; % Lower value which considers the motor to be not electrically loaded (e.g. when the motor is not drawing any energy whatsoever)
% q=1;
averageroll = 200; % Numnber of cells we want to average our data through
for i = (1+averageroll):(length(Real_Current)-averageroll)
%     if (Real_Current(i+averageroll) > MRC) || (Real_Current(i-averageroll) > MRC)
%         Useful_Real_Current(q) = Real_Current(i);
%         q = q + 1;
%     end
    t(i,1) = i;
    Average_Current(i,1) = mean(Real_Current(i:i+averageroll));
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Compute the data that pertains to the useful load
wu = 1000; % This value is to determine how many data points in front or behind a particular data point is needed to consider the "useful data"
q=1;
for h = (1+wu):(length(Real_Current)-wu)
    if (Real_Current(h+wu) > MRC) || (Real_Current(h-wu) > MRC)
        Useful_Real_Current(q) = Real_Current(h);
        q = q + 1;
    end
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Determine the relevant values for an AC induction motor and display in
% MATLAB terminal
Scoobiedoo = Average_Current(Average_Current>MRC); %mean(Real_Current));
display('The average power of the motor is shown below in kilowatts (kW):')
Average_Power = mean(Scoobiedoo)*(sqrt(3)*Voltage/1000)
display('The time percentage the motor is drawing electricity is shown below (WRT 8760 hr/yr):')
Time_Percentage_Loaded = length(Scoobiedoo)/length(Useful_Real_Current)
display('The Load Factor of the motor is shown below:')
Load_Factor = Average_Power/(sqrt(3)*max(Scoobiedoo)*Voltage/1000)
display('The current energy usage of the motor is shown below in kilowatt-hours (kWh):')
Current_Energy_Usage = Average_Power*8760*Time_Percentage_Loaded
% 
% Compare the Raw current to the rolling Average Visually
% It is good to look at the Raw Current to avoid missing anything the
% processed data has removed from the actual data.
figure(1)
plot(y,Real_Current,'linewidth',1.5)
hold on
plot(t,Average_Current,'r --','linewidth',1.5)
title('Current Draw of the BFP Blower','interpreter','latex','Fontsize',18)
xlabel('Memory Slot ID','interpreter','latex','Fontsize',18)
ylabel('Current (A)','interpreter','latex','Fontsize',18)
legend('Real Current','Average Current')
% ylim([0 75])
grid('on')
hold off
% 
% Plot of the Average Current
figure(2)
plot(t,Average_Current,'linewidth',1.5)
title('Average Current Draw of the BFP Blower','interpreter','latex','Fontsize',18)
xlabel('Memory Slot ID','interpreter','latex','Fontsize',18)
ylabel('Average Current (A)','interpreter','latex','Fontsize',18)
grid('on')
%
% Plot the Motor Current when there is an electrical load and compare to
% the useful load to make sure the code worked preoperly
figure(3)
yy = linspace(0,length(Useful_Real_Current),length(Useful_Real_Current));
yyy = linspace(0,length(Scoobiedoo),length(Scoobiedoo));
plot(yy,Useful_Real_Current,'k',yyy,Scoobiedoo,'-- b','linewidth',1.5)
title('Electrical Loading Current Draw of the BFP Blower','interpreter','latex','Fontsize',18)
xlabel('Memory Slot ID','interpreter','latex','Fontsize',18)
ylabel('Loaded Current (A)','interpreter','latex','Fontsize',18)
legend('Useful Real Current','Scoobiedoo')
grid('on')