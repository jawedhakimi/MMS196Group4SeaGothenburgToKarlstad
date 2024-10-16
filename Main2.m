clc
clear all
s = 7; %[kts]
EtaElectric = 0.85;

v = linspace(3,12,10);
for i = 3:12
    k = i-2;
    [EnergyExtras(k), EnergyPropulsion(k), TravelTime(k)] = CalcEnergyAndTime2(i);
end

[hours, minutes, seconds] = s2hms(TravelTime);
h = TravelTime / 3600;
fprintf('Total Travel time: %d:%d:%d \n',hours,minutes,seconds);

%% For electric power
EnergyDensityOfBattery = (300000*3600)/33.2;    %[J/m3]

TotalElectricEnergy = (EnergyPropulsion ./ EtaElectric) + EnergyExtras;
NumberOfBatteryCon = ceil((TotalElectricEnergy ./ EnergyDensityOfBattery) / 33.2);
TotalCostOfBattCon = NumberOfBatteryCon * 200000;   %[€]
NContElectric = 190 - NumberOfBatteryCon;

% fprintf('Total required electrical energy: %.2f [MWh] or %d [Jouls] \n', TotalElectricEnergy / (3600 * 10^6),TotalElectricEnergy);
% fprintf('Total Cost of %d containers %.2f million [€] \n',NumberOfBatteryCon, TotalCostOfBattCon*10^-6);
%% For Diesel
EtaDiesel = 0.35;
EnergyDensOfDiesel = 38*10^9;   % [J/m^3]
CostDieselFuel = 1.5*10^3;      % [€/m^3]

CostDieselGen = ones(length(v)) * 350000; %[€]
TotalDieselEnergy = (EnergyPropulsion + EnergyExtras) ./ EtaDiesel;
VolumeOfDieselFuel = (TotalDieselEnergy ./ EnergyDensOfDiesel);
NumberOfDieselCont = ceil(VolumeOfDieselFuel ./ 33.2);


%% For LNG
LNGEnergyDensity = 24 * 10^9;   %[J/m3]
EtaLNG = 0.6;
CostLNG = 1500 * 1.2;   %[€/m3]

CostLNGGen = ones(length(v)) * 350000 * 1.1;
TotalLNGEnergy = (EnergyPropulsion + EnergyExtras) ./ EtaLNG;
VolumeOfLNG = TotalLNGEnergy ./ LNGEnergyDensity;

%% Plots
figure(1)
subplot(2,2,1)
plot(v,TotalElectricEnergy,'b','LineWidth',2), hold on
plot(v,TotalDieselEnergy,'r','LineWidth',2), hold on
plot(v,TotalLNGEnergy,'m','LineWidth',2)
xlabel('Speed[Kts]'), ylabel('Energy[MWh]')
grid on, title('Energy consumption as a function of speed.')
legend('Electric','Diesel','LNG')

subplot(2,2,2)
plot(v,h,'b','LineWidth',2)
xlabel('Speed[kts]'), ylabel('TravelTime[h]')
grid on, title('Travel time as a function of speed.')

subplot(2,2,3)
plot(v,NumberOfBatteryCon,'k','LineWidth',2)
xlabel('Speed[Kts]'), ylabel("Number of 20' batteries")
grid on, title('Number of batteries as a function of speed.')

subplot(2,2,4)
plot(v,TotalCostOfBattCon,'b','LineWidth',2), hold on
plot(v,CostDieselGen,'r','LineWidth',2), hold on
plot(v,CostLNGGen,'m','LineWidth',2)
xlabel('Speed[Kts]'), ylabel('Initial cost[€]')
grid on, title('Cost of batteries as a function of speed.')
legend('Electric','Diesel','LNG')


