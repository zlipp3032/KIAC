%Data Logger Processing Script - Plot Function
%Author: Zachary Lippay and Grayson Woods
%
function plotFunction_HOBOProcessor(Time_Stamp,RC1,AC1,URC1,Scoobie1,Title)

figure(1)
Start_Date = datenum(Time_Stamp(3));%datenum(Start_Date);
End_Date = datenum(Time_Stamp(end));%datenum(End_Date);
y = linspace(Start_Date,End_Date,length(RC1));
z = linspace(Start_Date,End_Date,length(AC1));
plot(y,RC1,'linewidth',1.5)
hold on
plot(z,AC1,'r --','linewidth',1.5)
title(['Current Draw of',' ' ,num2str(Title)],'interpreter','latex','Fontsize',16)
xlabel('Date (mm/dd)','interpreter','latex','Fontsize',16)
ylabel('Current (A)','interpreter','latex','Fontsize',16)
Legend = legend('Real Current','Average Current');
set(Legend,'Interpreter','Latex','Location','NorthEast','FontSize',14)
grid('on')
hold off
datetick('x','mm/dd','keepticks')
xlim([Start_Date End_Date])

figure(2)
plot(z,AC1,'linewidth',1.5)
title(['Average Current Draw of',' ', num2str(Title)],'interpreter','latex','Fontsize',16)
xlabel('Date (mm/dd)','interpreter','latex','Fontsize',16)
ylabel('Average Current (A)','interpreter','latex','Fontsize',16)
grid('on')
datetick('x','mm/dd','keepticks')
xlim([Start_Date End_Date])

figure(3)
l = linspace(Start_Date,End_Date,length(URC1));
m = linspace(Start_Date,End_Date,length(Scoobie1));
plot(l,URC1,'k',m,Scoobie1,'-- b','linewidth',1.5)
title(['Electrical Loading Current Draw of', ' ', num2str(Title)],'interpreter','latex','Fontsize',16)
xlabel('Date (mm/dd)','interpreter','latex','Fontsize',16)
ylabel('Loaded Current (A)','interpreter','latex','Fontsize',16)
Legend = legend('Useful Real Current','Scoobiedoo');
set(Legend,'Interpreter','Latex','Location','NorthEast','FontSize',14)
grid('on')
datetick('x','mm/dd','keepticks')
xlim([Start_Date End_Date])


%Save all figures.
for m = 1:1:3
figure(m)
xMargin = 1;                                            %Width margin is defined.
yMargin = 1;                                            %Height margin is defined.
xSize = 3.5;                                            %Width of figure is defined.
ySize = 4.38;                                           %Height of figure is defined.
set(gcf,'Units','inches','PaperUnits','inches'...       %Specify desired formatting.
    ,'PaperOrientation','Portrait','PaperPosition'...
    ,[xMargin yMargin xSize ySize]);       
saveas(figure(m),['figure' num2str(m) '.jpeg']);
end

end