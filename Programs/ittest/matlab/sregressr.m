function bcoff = sregressr(struct,withinter)
%REGRESSDATA
%  Use the Stat Toolbox regstats function to do linear regression
%  on a data set collected for the HPCA paper
%

% Setup the regression variables.
    Y = struct.ProcPwr;
    x1 = struct.Ambient_Temp0;
    x2 = struct.Ambient_Temp1;
    x3 = struct.CPU_0_Temp;
    x4 = struct.CPU_1_Temp;
    x5 = struct.HT1Scaled;
    x6 = struct.HT2Scaled;
    x7 = struct.cmiss_core0_scaled;
    x8 = struct.cmiss_core1_scaled;
    x9 = struct.cmiss_core2_scaled;
    x10 = struct.cmiss_core3_scaled;

    X = [ x1 x3 x4  x8 x10]; 
    % Now do the regression
    if withinter == 1
        fprintf('Linear regression with interaction terms:\n');
        stats = regstats(Y,X,'interaction');
    else
        fprintf('Linear regression without interaction terms:\n');
        stats = regstats(Y,X);
    end;
        fprintf('Model is\n');
    fprintf('ProcPwr = \n');
    fprintf('      b0  +\n');
    fprintf('      b1  * Ambient_Temp0 + \n');
    fprintf('      b3  * CPU_0_Temp + \n');
    fprintf('      b4  * CPU_1_Temp + \n');
    fprintf('      b10 * cmiss_core2_scaled\n');
    if withinter == 1
        fprintf('+ interaction terms\n');
    end;
    bcoff = stats.beta;
    
    printmodel(stats);
    printanova(stats);
    h=figure();
    normplot(stats.r);
    title('Normal plots of residuals of model');
    h2=figure();
    scatter(stats.yhat,stats.r);
    title('Scatterplot of estimates vs. residuals');
    
