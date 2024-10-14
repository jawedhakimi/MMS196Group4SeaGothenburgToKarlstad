function P_required = PowerRequirement(speed)
    % Data
    V_tab = 0.514444 .* [3 4 5 6 7 8 9 10 11 12]; % Speed [m/s]
    P_tab = 1000 .* [9.2 21.1 40.2 68.2 107.3 161.2 236.8 344 502.7 721.2]; % Power requirement [W]

    % Interpolation
    P_required = interp1(V_tab, P_tab, speed, 'linear', 'extrap');
end
