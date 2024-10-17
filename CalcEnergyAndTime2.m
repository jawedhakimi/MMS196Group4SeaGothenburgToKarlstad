function [E3, E4, TotalTime] = CalcEnergyAndTime2(s) % s in knots
% Total distance 244464[m]
l1 = 1852 * 51;             % Distance one [m]
l2 = 1852 * 81;             % Distance two [m]

Eta_prop = 0.66;    % Propeller efficiency

% Finding required power as a function of speed
s1_kts = min(s,10);                    % Example speed in m/s
s1 = 0.514444 * s1_kts;             % m/s
T1 = l1 / s1;                       % Time it takes to travel l1
E1 = PowerRequirement(s1) * T1;     % Required energy to go l1 [Jouls]

s2_kts = s;
s2 = 0.514444 * s2_kts;
T2 = l2 / s2;
E2 = PowerRequirement(s2) * T2;         % Required energy to go l2 [Jouls]

T_wait = (6 + 8) * 20 * 60;             % 6 locks and 8 bridges to pass, average 20min to pass
TotalTime = T1 + T2 + T_wait;

E3 = 17*10^3 * TotalTime;               % The required energy to run extras
E4 = ((E1 + E2) / Eta_prop);            % Total required energy, considering 66% props efficiency

end
