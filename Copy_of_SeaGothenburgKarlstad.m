clc
clear all

% Total distance 244464[m]
l1 = 1852 * 51;             % Distance one [m]
l2 = 1852 * 81;             % Distance two [m]

Eta_prop = 0.66;    % Propeller efficiency


%% Finding required power as a function of speed

S1_InKnots = 7;                    % Example speed in m/s
s1 = 0.514444 * S1_InKnots;         % m/s
T1 = l1 / s1;                       % Time it takes to travel l1
E1 = PowerRequirement(s1) * T1;     % Required energy to go l1 [Jouls]

s2_knots = 7;
s2 = 0.514444 * s2_knots;
T2 = l2 / s2;
E2 = PowerRequirement(s2) * T2;         % Required energy to go l2 [Jouls]
E3 = (E1 + E2) /(0.85 * 0.66);          % Energy required to run [Jouls], given 85% Efficiency of the electric system and 66% for prop

T_wait = (6 + 8) * 20 * 60;             % 6 locks and 8 bridges to pass, average 20min to pass
TotalTime = T1 + T2 + T_wait;
E4 = 17*10^3 * TotalTime;               % The required energy to run extras

E5 = (E3 + E4) * 1.20;                               % Total energy required [J]
E6 = (E3 + E4);

%% TravelTime
[hours, minutes, seconds] = s2hms(TotalTime);
fprintf('Total Travel time: %d:%d:%d \n',hours,minutes,seconds);
fprintf('Total required energy: %.2f [MWh] \n', E5 / (3600 * 10^6));


%% Battery size and cost
C_batt = 600000*3600;           % Capacity of a 40" battery container
N_batt = ceil(E5 / C_batt);     % Number of 40" battery container required to do the trip
Cost_batt = N_batt * 400000;    % Battery cost in [€]
fprintf('Required number of 40" battery containers to do the trip is: %d which in total costs: %.1f Million Euros \n', N_batt,Cost_batt/10^6);

%% Chargers capability
T_charger = 12 * 3600;          % Turn around time at port
P_charger = E6 / T_charger;
fprintf('Power output of the charger should be at least: %.0f [KW] \n', ceil(P_charger/1000));





