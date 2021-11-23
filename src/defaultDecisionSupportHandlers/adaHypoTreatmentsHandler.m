function [HT, dss] = adaHypoTreatmentsHandler(G,CHO,hypotreatments,bolus,basal,time,timeIndex,dss)
% function  adaHypoTreatmentsHandler(G,CHO,hypotreatments,bolus,basal,time,timeIndex,dss)
% Implements the default hypotreatment strategy: "take an hypotreatment of 
% 10 g every 15 minutes while in hypoglycemia".
%
% Inputs:
%   - G: a glucose vector as long the simulation length containing all the 
%   simulated glucose concentrations up to timeIndex. The other values are
%   nan;
%   - CHO: is a vector that contains the CHO intakes input for the whole
%   replay simulation (g/min);
%   - hypotreatments: is a vector that contains the hypotreatments intakes 
%   input for the whole replay simulation (g/min);
%   - bolus: is a vector that contains the bolus insulin input for the
%   whole replay simulation (U/min);
%   - basal: is a vector that contains the basal insulin input for the
%   whole replay simulation (U/min);
%   - time: is a vector that contains the time instants of current replay
%   simulation. Contains one value for each integration step;
%   - timeIndex: is a number that defines the current time instant in the
%   replay simulation;
%   - dss: a structure that contains the hyperparameters of the integrated
%   decision support system.
% Output:
%   - HT: the hypotreatment to administer at time(timeIndex+1) (g/min);
%   - dss: a structure that contains the hyperparameters of the integrated
%   decision support system.  
%
% ---------------------------------------------------------------------
% NOTES: 
% - If the scenario is single meal, hypotreatments will contain only the
%   hypotreatments generated by this function during the simulation. If the
%   scenario is multi-meal, hypotreatments will ALSO contain the
%   hypotreatments already present in the given data that labeled as such.
% - CHO does not contain hypotreatments.
% - dss is also an output since it contains hypoTreatmentsHandlerParams 
%   that beside being a structure that contains the parameters to pass to 
%   this function, it also serves as memory area. It is possible to store   
%   values inside it and the adaHypoTreatmentsHandler function will be able 
%   to access to them in the next call of the function).
%
% ---------------------------------------------------------------------
%
% Copyright (C) 2020 Giacomo Cappon
%
% This file is part of ReplayBG.
%
% ---------------------------------------------------------------------

    HT = 0;
    
    %If glucose is lower than 70...
    if(G(timeIndex) < 70)
        
        %...and if there are no CHO intakes in the last 15 minutes, then take an HT
        if(timeIndex > 15 && ~any(hypotreatments((timeIndex - 15):timeIndex)))
            HT = 15; % g/min
        end
        
    end
        
end
        