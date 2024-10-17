clc
clear all
s = 7; %[kts]
EtaElectric = 0.85;

[EnergyExtras, EnergyPropulsion, TravelTime] = CalcEnergyAndTime2(s);
[hours, minutes, seconds] = s2hms(TravelTime);
fprintf('Total Travel time: %d:%d:%d \n',hours,minutes,seconds);

Temp = EnergyExtras + EnergyPropulsion

%% For electric power
EnergyDensityOfBattery = (300000*3600)/33.2;    %[J/m3]

TotalElectricEnergy = (EnergyPropulsion / EtaElectric) + EnergyExtras;
NumberOfBatteryCon = ceil((TotalElectricEnergy / EnergyDensityOfBattery) / 33.2);
TotalCostOfBattCon = NumberOfBatteryCon * 200000;   %[€]

fprintf('Total required electrical energy: %.2f [MWh] or %d [Jouls] \n', TotalElectricEnergy / (3600 * 10^6),TotalElectricEnergy);
fprintf('Total Cost of %d containers %.2f million [€] \n',NumberOfBatteryCon, TotalCostOfBattCon*10^-6);
%% For Diesel
EtaDiesel = 0.35;
EnergyDensOfDiesel = 38*10^9;   % [J/m^3]
CostDieselFuel = 1.5*10^3;      % [€/m^3]

CostDieselGen = 350000; %[€]
TotalDieselEnergy = (EnergyPropulsion + EnergyExtras) / EtaDiesel;
VolumeOfDieselFuel = (TotalDieselEnergy / EnergyDensOfDiesel);
NumberOfDieselCont = ceil(VolumeOfDieselFuel / 33.2);


%% For LNG
