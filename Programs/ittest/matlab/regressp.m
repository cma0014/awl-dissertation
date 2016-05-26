function bcoff = regressp(filename,withinter)
%REGRESSDATA
%  Use the Stat Toolbox regstats function to do linear regression
%  on a data set collected for the HPCA paper
%
% Tell the world which file we're processing
    fprintf('\nFilename: %s\n',filename);
% Read the data from the disk
    importcsv(filename);
% Setup the regression variables.
    Y = ProcPwr;
    x1 = Ambient_Temp0;
    x2 = Ambient_Temp1;
    x3 = CPU_0_Temp;
    x4 = CPU_1_Temp;
    x6 = HT1Scaled;
    x7 = HT2Scaled;
    x8 = cmiss_core0_scaled;
    x9 = cmiss_core1_scaled;
    x10 = cmiss_core2_scaled;
    x11 = cmiss_core3_scaled;
    x12 = disk_read_kbytes;
    x13 = disk_write_kbytes;
    x14 = Axial_Fan_0;
    x15 = Axial_Fan_1;
    x16 = Blower_Fan_0;
    x17 = Blower_Fan_1;

    X = [ x1 x2 x3 x4 x6 x7 x8 x9 x10 x11 x12 x13 x14 x15 x16 x17]; 
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
    
    printmodel(stats);
    printanova(stats);
    h=figure();
    normplot(stats.r);
    title('Normal plots of residuals of model');
    h2=figure();
    scatter(stats.yhat,stats.r);
    title('Scatterplot of estimates vs. residuals');
    
