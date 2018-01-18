% Data Logger Processing Script - main
% Zachary Lippay
% 
clear
clc
close all
% 
%
% These values may vary
Voltage = 480; % Input voltage to equipment being analyzed
averageroll = 250; % Numnber of cells we want to average our data through
MRC = 10; % Lower value which considers the motor to be not electrically loaded (e.g. when the motor is not drawing any energy whatsoever)
% 
% 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% File location of HOBO .csv file ---> Need to update for each data logger
hobodata1 = '/Users/zlipp3032/Google Drive/KIAC/Assessments - working directory/1801 Bekaert/Post Assessment/Data Loggers/1801_Comp3_VFD.csv';
wu1 = 1000; % This value is to determine how many data points in front or behind a particular data point is needed to consider the "useful data"
%
% Call Function for Motor 1
[LF1,TPL1,AP1,RC1,AC1,Scoobie1,URC1,CEU1,t1] = processor_HOBOProcessor(hobodata1,Voltage,wu1,averageroll,MRC);
Load_Factor1 = sprintf('The Load Factor for this motor is %d.',LF1) % Load Factor
Time_Percentage_Loaded1 = sprintf('The Time Percentage the motor is Loaded with respect to 8,760 hr/yr is %d.',TPL1)% Time Percentage whil the motor is on
Average_Power1 = sprintf('The Average Power the motor is %d kW.',AP1) % Average Power
Current_Energy_Usage1 = sprintf('The Average Power the motor is %d kWh/yr.',CEU1) % Current Energy usage 
% 
% Compare the Raw current to the rolling Average Visually
% It is good to look at the Raw Current to avoid missing anything the
% processed data has removed from the actual data.
figure(1)
y = linspace(0,length(RC1),length(RC1));
plot(y,RC1,'linewidth',1.5)
hold on
plot(t1,AC1,'r --','linewidth',1.5)
title('Current Draw of the 50hp Air Compressor','interpreter','latex','Fontsize',18)
xlabel('Memory Slot ID','interpreter','latex','Fontsize',18)
ylabel('Current (A)','interpreter','latex','Fontsize',18)
legend('Real Current','Average Current')
%ylim([0 75])
grid('on')
hold off
% 
% Plot of the Average Current
figure(2)
plot(t1,AC1,'linewidth',1.5)
title('Average Current Draw of the 50hp Air Compressor','interpreter','latex','Fontsize',18)
xlabel('Memory Slot ID','interpreter','latex','Fontsize',18)
ylabel('Average Current (A)','interpreter','latex','Fontsize',18)
grid('on')
%
% Plot the Motor Current when there is an electrical load and compare to
% the useful load to make sure the code worked preoperly
figure(3)
yy = linspace(0,length(URC1),length(URC1));
yyy = linspace(0,length(Scoobie1),length(Scoobie1));
plot(yy,URC1,'k',yyy,Scoobie1,'-- b','linewidth',1.5)
title('Electrical Loading Current Draw of the 50hp Air Compressor','interpreter','latex','Fontsize',18)
xlabel('Memory Slot ID','interpreter','latex','Fontsize',18)
ylabel('Loaded Current (A)','interpreter','latex','Fontsize',18)
legend('Useful Real Current','Scoobiedoo')
grid('on')
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % File location of HOBO .csv file ---> Need to update for each data logger
% hobodata2 = '/Users/zlipp3032/Desktop/1714_BFP_Blower.csv';
% wu2 = 1000; % This value is to determine how many data points in front or behind a particular data point is needed to consider the "useful data"
% %
% % Call Function for Motor 2
% [LF2,TPL2,AP2,RC2,AC2,Scoobie2,URC2,CEU2,t2] = processor_HOBOProcessor(hobodata2,Voltage,wu2,averageroll,MRC);
% Load_Factor2 = sprintf('The Load Factor for this motor is %d.',LF1) % Load Factor
% Time_Percentage_Loaded2 = sprintf('The Time Percentage the motor is Loaded with respect to 8,760 hr/yr is %d.',TPL1) % Time Percentage while the motor is on
% Average_Power2 = sprintf('The Average Power the motor is %d kW.',AP1) % Average Power in  kW
% Current_Energy_Usage2 = sprintf('The Average Power the motor is %d kWh/yr.',CEU2) % Current Energy usage 
% % 
% % Compare the Raw current to the rolling Average Visually
% % It is good to look at the Raw Current to avoid missing anything the
% % processed data has removed from the actual data.
% figure(4)
% y2 = linspace(0,length(RC2),length(RC2));
% plot(y2,RC2,'linewidth',1.5)
% hold on
% plot(t2,AC2,'r --','linewidth',1.5)
% title('Current Draw of the BFP Blower','interpreter','latex','Fontsize',18)
% xlabel('Memory Slot ID','interpreter','latex','Fontsize',18)
% ylabel('Current (A)','interpreter','latex','Fontsize',18)
% legend('Real Current','Average Current')
% ylim([0 100])
% grid('on')
% hold off
% % 
% % Plot of the Average Current
% figure(5)
% plot(t2,AC2,'linewidth',1.5)
% title('Average Current Draw of the BFP Blower','interpreter','latex','Fontsize',18)
% xlabel('Memory Slot ID','interpreter','latex','Fontsize',18)
% ylabel('Average Current (A)','interpreter','latex','Fontsize',18)
% grid('on')
% %
% % Plot the Motor Current when there is an electrical load and compare to
% % the useful load to make sure the code worked preoperly
% figure(6)
% yy2 = linspace(0,length(URC2),length(URC2));
% yyy2 = linspace(0,length(Scoobie2),length(Scoobie2));
% plot(yy2,URC2,'k',yyy2,Scoobie2,'-- b','linewidth',1.5)
% title('Electrical Loading Current Draw of the BFP Blower','interpreter','latex','Fontsize',18)
% xlabel('Memory Slot ID','interpreter','latex','Fontsize',18)
% ylabel('Loaded Current (A)','interpreter','latex','Fontsize',18)
% legend('Useful Real Current','Scoobiedoo')
% grid('on')
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % File location of HOBO .csv file ---> Need to update for each data logger
% hobodata3 = '/Users/zlipp3032/Desktop/1710_Chiller2.csv';
% wu3 = 100; % This value is to determine how many data points in front or behind a particular data point is needed to consider the "useful data"
% %
% % Call Function for Motor 3
% [LF3,TPL3,AP3,RC3,AC3,Scoobie3,URC3,CEU3,t3] = processor_HOBOProcessor(hobodata3,Voltage,wu3,averageroll,MRC);
% Load_Factor3 = sprintf('The Load Factor for this motor is %d.',LF3) % Load Factor
% Time_Percentage_Loaded3 = sprintf('The Time Percentage the motor is Loaded with respect to 8,760 hr/yr is %d.',TPL3)% Time Percentage whil the motor is on
% Average_Power3 = sprintf('The Average Power the motor is %d kW.',AP3) % Average Power
% Current_Energy_Usage3 = sprintf('The Average Power the motor is %d kWh/yr.',CEU3) % Current Energy usage 
% % 
% % Compare the Raw current to the rolling Average Visually
% % It is good to look at the Raw Current to avoid missing anything the
% % processed data has removed from the actual data.
% figure(7)
% y3 = linspace(0,length(RC3),length(RC3));
% plot(y3,RC3,'linewidth',1.5)
% hold on
% plot(t3,AC3,'r --','linewidth',1.5)
% title('Current Draw of the Chiller','interpreter','latex','Fontsize',18)
% xlabel('Memory Slot ID','interpreter','latex','Fontsize',18)
% ylabel('Current (A)','interpreter','latex','Fontsize',18)
% legend('Real Current','Average Current')
% ylim([0 100])
% grid('on')
% hold off
% % 
% % Plot of the Average Current
% figure(8)
% plot(t3,AC3,'linewidth',1.5)
% title('Average Current Draw of the Chiller','interpreter','latex','Fontsize',18)
% xlabel('Memory Slot ID','interpreter','latex','Fontsize',18)
% ylabel('Average Current (A)','interpreter','latex','Fontsize',18)
% grid('on')
% %
% % Plot the Motor Current when there is an electrical load and compare to
% % the useful load to make sure the code worked preoperly
% figure(9)
% yy3 = linspace(0,length(URC3),length(URC3));
% yyy3 = linspace(0,length(Scoobie3),length(Scoobie3));
% plot(yy3,URC3,'k',yyy3,Scoobie3,'-- b','linewidth',1.5)
% title('Electrical Loading Current Draw of the Chiller','interpreter','latex','Fontsize',18)
% xlabel('Memory Slot ID','interpreter','latex','Fontsize',18)
% ylabel('Loaded Current (A)','interpreter','latex','Fontsize',18)
% legend('Useful Real Current','Scoobiedoo')
% grid('on')
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
