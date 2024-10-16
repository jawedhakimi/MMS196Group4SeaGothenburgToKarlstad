

clc
clear all

V = linspace(3,12,10);
for i = 3:12
    k = i-2;
    [E(k), T(k), Nbatt(k),Cost(k)]= SeaGothenburgKarlstad(i);
end
E = E ./ (10^6*3600);
h = T ./ (3600);
CostM = Cost./ 10^6;

figure(1)
subplot(2,2,1)
plot(V,E,'r','LineWidth',2)
xlabel('Speed[Kts]'), ylabel('Energy[MWh]')
grid on, title('Energy consumption as a function of speed.')

subplot(2,2,2)
plot(V,h,'b','LineWidth',2)
xlabel('Speed[kts]'), ylabel('TravelTime[h]')
grid on, title('Travel time as a function of speed.')

subplot(2,2,3)
plot(V,Nbatt,'k','LineWidth',2)
xlabel('Speed[Kts]'), ylabel("Number of 20' batteries")
grid on, title('Number of batteries as a function of speed.')

subplot(2,2,4)
plot(V,CostM,'m','LineWidth',2)
xlabel('Speed[Kts]'), ylabel('Cost of batteries [M€]')
grid on, title('Cost of batteries as a function of speed.')



%% Running cost
for i = 3:12
    j = i-2;
    RunningCostDiesel(j) = DieselCostCalc(i);
end
RunningCostBattery = RunningCostDiesel .* 0.6;
figure(2)
plot(V,RunningCostDiesel,'m','LineWidth',2), grid on
xlabel('Speed[Kts]'), ylabel('Running cost [€]')
hold on
plot(V,RunningCostBattery,'k','LineWidth',2), grid on
xlabel('Speed[Kts]'), ylabel('Running cost [€]')
hold on

legend('Running cost of diesel','Running cost of battery')


%% Start cost + running cost
% With 7 kts
BatteryStartCost = Cost(5);
DieselStartCost = 350000;
RunningCostBattery7 = RunningCostBattery(5);
RunningCostDiesel7 = RunningCostDiesel(5);

Ntrips = linspace(1,15000);
TotalCostDiesel = (DieselStartCost+(Ntrips .* RunningCostDiesel7)) * 10^-6;
TotalCostBattery = (BatteryStartCost+(Ntrips .* RunningCostBattery7)) * 10^-6;
figure(3)
plot(Ntrips,TotalCostDiesel,'k','LineWidth',2), hold on
plot(Ntrips,TotalCostBattery,'m','LineWidth',2), grid on
xlabel('Number of trips'), ylabel('Cost in [M€]')
legend('Total diesel cost','Total battery cost')









