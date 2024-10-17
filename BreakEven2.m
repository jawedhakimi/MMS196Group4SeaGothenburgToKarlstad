clc
clear all

%% Energy needed
s = 7;
[E_extra, E_prop, Time] = CalcEnergyAndTime2(s);
Ntrip = linspace(0,100,100);
Ntrip2 = linspace(0,1000,1000);


%% Diesel
EtaD = 0.55;
RhoD = 38 * 10^9;   %[J/m3]
P_D = 1500; %[€/m3]
PperJD = P_D / RhoD;    %[€/J]
E_Diesel = (E_prop + E_extra) / EtaD;   %[J]
RCostTripD = E_Diesel * PperJD;  %[€]
RIncomeD = 190 * 800;
RevD = (RIncomeD - RCostTripD) .* Ntrip;

EmissionD = 0.266 / (3600 * 1000);   %[kg/J]
EmissionD_total = E_Diesel * EmissionD * Ntrip2;


%% LNG
EtaLNG = 0.6;
RhoLNG = 24 * 10^9; %[J/m3]
PperJLNG = PperJD * 1.2; %[€/J]
E_LNG = (E_prop + E_extra) / EtaLNG;   %[J]
RCosTripLNG = E_LNG * PperJLNG; %[€/J]
RIncomeLNG = 189 * 800;
ScostLNG = 280000 + 350000 * 1.1;

RevLNG = (RIncomeLNG - RCosTripLNG) .* Ntrip - ScostLNG;

EmissionLNG = 1.7778e-07; %[kg/J]
EmissionLNG = 0.0558 * 10^-6; % [kg/J]
EmissionLNG_tot = EmissionLNG  * E_LNG * Ntrip2; %[Kg/trip]


%% Electric
EtaE = 0.85;
PperJE = PperJD * 0.6; %[€/J]
E_Elec = (E_prop + E_extra) / EtaE;   %[J]
RCostTripE = E_Elec * PperJE; %[€]

NContE = ceil(E_Elec / (300000 * 3600));
RIncomeE = (190 - NContE) * 800;
SCostE = (NContE * 200000) + (0.6 * 1.1 * 350000);
RevE = (RIncomeE - RCostTripE) .* Ntrip - SCostE;
EmissionBat = 89 / (1000 * 3600);   %[kg / J]
EmissionBat2 = EmissionBat * E_Elec;
EmissionElec = 0.014 / (1000 * 3600);   %[Kg/J]
EmissionElec_total = EmissionBat2 + (EmissionElec * E_Elec * Ntrip2);


%% Plots

figure(1)
plot(Ntrip,RevE,'b','LineWidth',2), hold on
plot(Ntrip,RevD,'r','LineWidth',2), hold on
plot(Ntrip,RevLNG,'m','LineWidth',2), grid on
xlabel('Number of trips'), ylabel('Profit [€]')
yline(0, 'k', 'LineWidth', 2); %
legend('Electric', 'Diesel','LNG')
title('Break-even cost for different types of energy.')

figure(2)
plot(Ntrip2,EmissionElec_total,'b','LineWidth',2), hold on
plot(Ntrip2,EmissionD_total,'r','LineWidth',2), hold on
plot(Ntrip2,EmissionLNG_tot,'m','LineWidth',2), grid on
xlabel('Number of trips'), ylabel('Co2 Emission [kg]')
yline(0, 'k', 'LineWidth', 2); %
legend('Electric', 'Diesel','LNG')
title('Cos emissions of different types of energy')


