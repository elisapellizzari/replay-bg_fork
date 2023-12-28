function [B, dss] = myBolusCalculator_eli_CR(G, mealAnnouncements,bolus,basal,time,timeIndex,dss)

    B = 0;
    
    if hour(time(timeIndex)) < 11
        % CR_b
        CR = dss.bolusCalculatorHandlerParams(1);
    elseif hour(time(timeIndex)) > 11 && hour(time(timeIndex)) < 17
        %CR_l
        CR = dss.bolusCalculatorHandlerParams(2);
    else
        %CR_d
        CR = dss.bolusCalculatorHandlerParams(3);
    end


    %If a meal is announced...
    if(mealAnnouncements(timeIndex) > 0)
        
        %...give a bolus
        B = max([0, mealAnnouncements(timeIndex)/CR + (G(timeIndex) - dss.GT) / dss.CF - iobCalculation(bolus(1:timeIndex),1)]);
       
        
    end
    
end

function [IOB] = iobCalculation(insulin,Ts)

    % define 6 hour curve
    k1 = 0.0173;
    k2 = 0.0116;
    k3 = 6.75;
    IOB_6h_curve = zeros(360,1);
    for t = 1:360
        IOB_6h_curve(t)= 1 - ...
            0.75*((-k3/(k2*(k1-k2))*(exp(-k2*(t)/0.75)-1) + ...
            k3/(k1*(k1-k2))*(exp(-k1*(t)/0.75)-1))/(2.4947e4));
    end
    IOB_6h_curve = IOB_6h_curve(Ts:Ts:end);

    % IOB is the convolution of insulin data with IOB curve
    IOB = conv(insulin, IOB_6h_curve);
    IOB = IOB(length(insulin));

end
        
