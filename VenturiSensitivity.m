%% ALL VALUES CHANGED FOR ITAR

clear all; close all; clc;

maxError = 5; %max percent error of mass flow rate

%% LOx --> fluid = 'ox'
%% input 
T_range = 80:154.33; % K
P_range = 500:50:900; % psia
nom_T = 54.35; % K
nom_P = 600; %psia
At = 0.0000595872; %m^2, constant
rho = 1140.64; %kg/m^3, placeholder, should change with temp in future version
Cd = .94; % given, constant
nom_mdot = 6.0; %kg/s
%% calcs
i=0;
j=0;
Tind = length(T_range);
Pind = length(P_range);
mdot = zeros(1, Tind);
error = zeros(1, Tind);
for T= T_range
    i=i+1;
    %get saturation P
    Pv = VapP('ox',T);
    j=0;
    for nom_P = P_range
        j=j+1;
        %O_Pdrop is the diff btwn Pv & P1 
        O_Pdrop = (nom_P - Pv)*6895; %Pa, the *6895 is to convert psi to Pa

        % mdot = Cd*A*sqrt(2*rho*(P1-Pv))
        mdot(j,i) = Cd*At*sqrt(2*rho*(O_Pdrop)); %kg/s
        error(j,i) = abs(nom_mdot-mdot(j,i))/nom_mdot*100; %percentage
    end
end
%% graph
figure(1)
% ('Ox temp (K) sensitivity')
subplot(2,1,1)
plot(T_range, mdot)
title('Mass Flow Rate (kg/s)')
subplot(2,1,2)
plot(T_range, error)
xlabel('Temp (K)')
hold on
yline(maxError, 'LineStyle', '--');
hold off
title('Mass Flow Error (%)')



