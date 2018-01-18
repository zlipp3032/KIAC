% Radiant heat transfer calculator
% Zachary Lippay
clear
clc
%
% The equation for radiation heat trasnfer of a black body is listed below.
% We can assume the emissivity of the material is 1.0 due to the
% tempertaure mesaurement acquired being an exterior surface temperature.
% q = sigma * (Th^4 - Tc^4) * A * OH
%
% where,
%       q = radiated heat, Btu/yr
%       sigma = Stefan-Boltzman constant, 1.1714e-9 BTU/(ft^2 * hr * R^4)
%       Th = Temperature of emitter, R
%       Tc = Temperature of surroundings (primarily the bodies absorbing
%       the energy), R
%       A = Surface area of the emitter, ft^2
%       OH = Operating hours the emitter is emitting, hr/yr (the units can
%       be hr/i where i is any time period --> this would change the units
%       of q is well!!!)
%
sigma = 1.714e-9; %(BTU/(ft^2 * hr * R^4))
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%                                          %%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%                 INPUTS                   %%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%                                          %%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%
% The following inputs should be measured during the site visit
Th = 978; %(R) Please recall that if you have temperature that is measured in degrees Farenheit, you can simply switch to the Rankine scale by adding 460 to the measured value
Tc = 530; %(R) This value can be the temperature of the room. It is likely that the equipment in the room will be of similar temperature.
A = 100; %(ft^2)

% The following values are faciltiy specific
OH = 8760; %(hr/yr) 
AUC = 3.65; %($/MMBtu) Annual usage cost --> Calculated from the utility analysis
LR = 26.64; %($/hr) Labor Rate --> Used for Implementation Cost
TI = 16; %(hr) Time it will take to complete the job for the personnel being paid

%The following values are used to calculate the energy savings
%SF = 0.9; %(%) This value is the scaling factor to determine how much energy will be saved
TT = [70:0.1:; %(R) This is the target temperature to compute percent reduction (same as SF above) --> This is the desired method

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%                                          %%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%                OUTPUTS                   %%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%                                          %%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Energy Savings
q = sigma*(Th^4-Tc^4)*A*OH; %(Btu/yr) Energy Lost to radiation
qLost_MMBtuYr = q/1000000 %(MMBtu/yr)
%NET = (Th^4 - (q*SF)/(sigma*OH*100))^(1/4); %(R) New Exterior Temperature --> based on the scaling factor (e.g. the percentage of energy saved due to insulating the hot surface)
%NET_degF = NET - 460; %(degF)
%qSaved_MMBtuYr = qLost_MMBtuYr*0.9 %(MMBtu/yr)
qNew_MMBtuYr = (sigma*(TT^4-Tc^4)*200*OH)/1000000 %(MMBtu/yr)
NSF = (qLost_MMBtuYr-qNew_MMBtuYr)/qLost_MMBtuYr
qSaved_MMBtuYr = qLost_MMBtuYr - qNew_MMBtuYr

% Energy Cost Savings
ECS_DollarYr = qSaved_MMBtuYr*AUC %($/yr)

% Implementation Cost
DC = 24/8; %($/ft^2) Cost of duct per unit length
A = 200;
MC_Dollar = A*DC;% Material Cost
LC_Dollar = LR*TI; % Labor Cost
SM = 500; %($) Structural Materials
IC_Dollar = MC_Dollar + LC_Dollar + SM%Total

% Simple Payback and CO2
SPP = IC_Dollar/ECS_DollarYr;
if SPP <= 1
    SPP_Mo = SPP * 12
else
    SPP_Yr = SPP
end

%CO2 Savings
CF1 = 117; %(lbs CO2/MMBtu) Conversion Factor
CF2 = 1/2000; %(ton/lbs) Conversion factor
CO2_Yr = qSaved_MMBtuYr*CF1*CF2























