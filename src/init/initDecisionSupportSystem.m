function dss = initDecisionSupportSystem(CR,CF,GT,...
    bolusCalculatorHandler, bolusCalculatorHandlerParams, ...
    enableHypoTreatments,hypoTreatmentsHandler,enableCorrectionBoluses,correctionBolusesHandler,hypoTreatmentsHandlerParams,correctionBolusesHandlerParams, ...
    environment)
% function  initDecisionSupportSystem(CR,CF,enableHypoTreatments,hypoTreatmentsHandler,enableCorrectionBoluses,correctionBolusesHandler,hypoTreatmentsHandlerParams,correctionBolusesHandlerParams)
% Initializes the 'dss' core variable.
%
% Inputs:
%   - CR: the carbohydrate-to-insulin ratio of the patient in g/U to be 
%   used by the integrated decision support system;
%   - CF: the correction factor of the patient in mg/dl/U to be used by the 
%   integrated decision support system;
%   - GT: the target glucose value in mg/dl to be used by the decsion
%   support system modules;
%   - bolusCalculatorHandler: a vector of characters that specifies the
%   name of the function handler that implements a bolus calculator to be
%   used during the replay of a given scenario;
%   - bolusCalculatorHandlerParams: a structure that contains the parameters
%   to pass to the bolusCalculatorHandler function. It also serves as memory
%   area for the bolusCalculatorHandler function;
%   - enableHypoTreatments: a numerical flag that specifies whether to 
%   enable hypotreatments during the replay of a given scenario;
%   - hypoTreatmentsHandler: a vector of characters that specifies the
%   name of the function handler that implements an hypotreatment strategy
%   during the replay of a given scenario;
%   - enableCorrectionBoluses: a numerical flag that specifies whether to 
%   enable correction boluses during the replay of a given scenario;
%   - correctionBolusesHandler: a vector of characters that specifies the
%   name of the function handler that implements a corrective bolusing strategy
%   during the replay of a given scenario;
%   - hypoTreatmentsHandlerParams: a structure that contains the parameters
%   to pass to the hypoTreatmentsHandler function. It also serves as memory
%   area for the hypoTreatmentsHandler function;
%   - correctionBolusesHandlerParams: a structure that contains the parameters
%   to pass to the correctionBolusesHandler function. It also serves as memory
%   area for the correctionBolusesHandler function;
%   - environment: a structure that contains general parameters to be used
%   by ReplayBG.
% Outputs:
%   - dss: a structure that contains the hyperparameters of the integrated
%   decision support system.
%
% ---------------------------------------------------------------------
%
% Copyright (C) 2021 Giacomo Cappon
%
% This file is part of ReplayBG.
%
% ---------------------------------------------------------------------
    
    if(environment.verbose && strcmp(environment.modality,'replay'))
    	fprintf('Setting up the Decision Support System hyperparameters...');
    	tic;
    end
    
    %Patient therapy parameters
    dss.GT = GT;
    dss.CR = CR;
    dss.CF = CF;
    
    %Bolus Calculator module parameters
    dss.bolusCalculatorHandler = bolusCalculatorHandler;
    dss.bolusCalculatorHandlerParams = bolusCalculatorHandlerParams;
    
    %Hypotreatment module parameters
    dss.enableHypoTreatments = enableHypoTreatments;
    dss.hypoTreatmentsHandler = hypoTreatmentsHandler;
    
    %Correction bolus module parameters
    dss.enableCorrectionBoluses = enableCorrectionBoluses;
    dss.correctionBolusesHandler = correctionBolusesHandler;
    
    %Handlers optional parameters
    dss.hypoTreatmentsHandlerParams = hypoTreatmentsHandlerParams;
    dss.correctionBolusesHandlerParams = correctionBolusesHandlerParams;
    
    if(environment.verbose && strcmp(environment.modality,'replay'))
        time = toc;
        fprintf(['DONE. (Elapsed time ' num2str(time/60) ' min)\n']);
    end
    
end