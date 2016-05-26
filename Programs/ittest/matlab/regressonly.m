function  regressonly(ProcPwr, data,varargin)
    optargs = size(varargin,1);
    if optargs > 0
        withinter = varargin{1}
    else
        withinter = 0;
    end
    Y = ProcPwr;

    X = data;
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
    fprintf('      b2  * Ambient_Temp1 + \n');
    fprintf('      b3  * CPU_0_Temp + \n');
    fprintf('      b4  * CPU_1_Temp + \n');
    fprintf('      b5  * HT1Scaled + \n');
    fprintf('      b6  * HT2Scaled + \n');
    fprintf('      b7  * cmiss_core0_scaled +\n');
    fprintf('      b9  * cmiss_core1_scaled +\n');
    fprintf('      b10 * cmiss_core2_scaled +\n');
    fprintf('      b11 * cmiss_core3_scaled +\n');
    fprintf('      b12 * data_read_kbytes + \n');
    fprintf('      b13 * data_write_kbytes +\n');
    fprintf('      b14 * Axial_Fan_0 +\n');
    fprintf('      b15 * Axial_Fan_1 +\n');
    fprintf('      b16 * Blower_Fan_0 +\n');
    fprintf('      b17 * Blower_Fan_1\n');
    
    if withinter == 1
        fprintf('+ interaction terms\n');
    end;
    bcoff = stats.beta;
    yhat = stats.yhat;
    
    printmodel(stats);
    printanova(stats);
    h=figure();
    normplot(stats.r);
    title('Normal plots of residuals of model');
    h2=figure();
    scatter(stats.yhat,stats.r);
    title('Scatterplot of estimates vs. residuals')

    dplus1 = [ ones(size(data,1))' data]
    powerhat = dplus1*bhat;
    err =  abs(ProcPwer - powerhat);
    plot(
