function TotalCostDiesel = DieselCostCalc(s)
% running costs
EtaDiesel = 0.35;
EtaProp = 0.66;

EDiesel = 38*10^9;      % [J/m^3]
Costdiesel = 1.5*10^3;  % [€/m^3]

% Total distance 244464[m]
l1 = 1852 * 51;             % Distance one [m]
l2 = 1852 * 81;             % Distance two [m]


Power = PowerRequirement(s);

S1_InKnots = min(s,10);             % Example speed in m/s
s1 = 0.514444 * S1_InKnots;         % m/s
T1 = l1 / s1;                       % Time it takes to travel l1
E1 = PowerRequirement(s1) * T1;     % Required energy to go l1 [Jouls]

s2_knots = s;
s2 = 0.514444 * s2_knots;
T2 = l2 / s2;
E2 = PowerRequirement(s2) * T2;         % Required energy to go l2 [Jouls]
E3 = (E1 + E2) /(EtaDiesel * EtaProp);          % Energy required to run [Jouls], given 85% Efficiency of the electric system and 66% for prop

T_wait = (6 + 8) * 20 * 60;             % 6 locks and 8 bridges to pass, average 20min to pass
TotalTime = T1 + T2 + T_wait;
E4 = (17*10^3 * TotalTime) / EtaDiesel;               % The required energy to run extras
E6 = (E3 + E4);

VolDiesel = E6 / EDiesel;
TotalCostDiesel = VolDiesel * Costdiesel;
end

