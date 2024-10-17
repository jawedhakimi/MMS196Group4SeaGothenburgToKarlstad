clc
clear all
s = 7; %[kts]
EtaElectric = 0.85;

v = linspace(3,12,10);
[EnergyExtras, EnergyPropulsion, TravelTime] = CalcEnergyAndTime2(s);
[hours, minutes, seconds] = s2hms(TravelTime);
h = TravelTime / 3600;
fprintf('Total Travel time: %d:%d:%d \n',hours,minutes,seconds);

%% For electric power
EnergyDensityOfBattery = (300000*3600)/33.2;    %[J/m3]

TotalElectricEnergy = (EnergyPropulsion / EtaElectric) + EnergyExtras;
NumberOfBatteryCon = ceil((TotalElectricEnergy / EnergyDensityOfBattery) / 33.2);
TotalCostOfBattCon = NumberOfBatteryCon * 200000;   %[€]
NContElectric = 190 - NumberOfBatteryCon;

% fprintf('Total required electrical energy: %.2f [MWh] or %d [Jouls] \n', TotalElectricEnergy / (3600 * 10^6),TotalElectricEnergy);
% fprintf('Total Cost of %d containers %.2f million [€] \n',NumberOfBatteryCon, TotalCostOfBattCon*10^-6);
%% For Diesel
EtaDiesel = 0.35;
EnergyDensOfDiesel = 38*10^9;   % [J/m^3]
CostDieselFuel = 1.5*10^3;      % [€/m^3]
CostDieselJ = CostDieselFuel / EnergyDensOfDiesel;

CostDieselGen = ones(length(v)) * 350000; %[€]
TotalDieselEnergy = (EnergyPropulsion + EnergyExtras) / EtaDiesel;
VolumeOfDieselFuel = (TotalDieselEnergy / EnergyDensOfDiesel);
NumberOfDieselCont = ceil(VolumeOfDieselFuel / 33.2);


%% For LNG
LNGEnergyDensity = 24 * 10^9;   %[J/m3]
EtaLNG = 0.6;
CostLNG = 1500 * 1.2;   %[€/m3]
CostLNGJ = CostLNG / LNGEnergyDensity;

CostLNGGen = 280000 + 350000 * 1.1;
TotalLNGEnergy = (EnergyPropulsion + EnergyExtras) / EtaLNG;
VolumeOfLNG = TotalLNGEnergy / LNGEnergyDensity;
%% Break Even
Ntrips = linspace(1,100,1000);
% Diesel
RunningCostDiesel = VolumeOfDieselFuel .* CostDieselFuel .* Ntrips;
TotalCostDiesel = RunningCostDiesel;
IncomeDiesel = 190 * 800 * Ntrips;
RevenueDiesel = IncomeDiesel - TotalCostDiesel;
% (TotalDieselEnergy*CostDieselJ*Ntrips)

% Battery
RunningCostBattery = RunningCostDiesel * 0.6 .* Ntrips;
TotalCostBattery = RunningCostBattery + TotalCostOfBattCon;
CostElectricJ = CostDieselJ * 0.6;
IncomeElec = NContElectric * 800  * Ntrips;
RevenueElec = IncomeElec - (TotalCostOfBattCon+TotalElectricEnergy*CostElectricJ*Ntrips);

% LNG
RunningCostLNG = VolumeOfLNG .* CostDieselFuel * 1.2 .* Ntrips;
TotalCostLNG = RunningCostLNG + (350000 * 1.1) + 280000;
IncomeLNG = 189 * 800 * Ntrips;
RevenueLNG = IncomeLNG - (CostLNGGen+TotalLNGEnergy*CostLNGJ*Ntrips);

figure(2)
plot(Ntrips,RevenueElec,'b','LineWidth',2),hold on
plot(Ntrips,RevenueDiesel,'r','LineWidth',2),hold on
plot(Ntrips,RevenueLNG,'m','LineWidth',2), grid on
xlabel('Number of trips'), ylabel('Total cost [€]')
legend('Electric','Diesel','LNG')