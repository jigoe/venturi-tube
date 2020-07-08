function [Pv]=VapP(fluid,T)

if fluid == 'ox'
    if T > 100.16 && T < 154.33
        disp('high')
        % Temp range: 54.36 - 154.33 K, from https://webbook.nist.gov/cgi/cbook.cgi?ID=C7782447&Mask=4&Type=ANTOINE&Plot=on#ANTOINE
        A=3.9523;
        B=340.024;
        C=-4.144;
        Pvbar = 10^(A - B/(T + C)); %bar       
    elseif T <= 100.16
        disp('low')
        % Temp range: 54.36 - 100.16 K, from https://webbook.nist.gov/cgi/cbook.cgi?ID=C7782447&Mask=4&Type=ANTOINE&Plot=on#ANTOINE
        A=3.85845;
        B=325.675;
        C=-5.667;
        Pvbar = 10^(A - B/(T + C)); %bar
    else
        error('unknown temp range')
    end
else
    error("unknown fluid indicator")
end
Pv = Pvbar*14.5038; %psi
end


