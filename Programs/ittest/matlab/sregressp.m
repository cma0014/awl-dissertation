function [bcoff yhat varargout] = sregressp(struct,withinter)
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
     %    x5 = struct.HT1;
     %    x6 = struct.HT2;
     %    x7 = struct.c1c2missC0;
     %    x8 = struct.c1c2missC1;
     %    x9 = struct.c1c2missC2;
     %    x10 = struct.c1c2missc3
    x11 = struct.disk_read_kbytes;
    x12 = struct.disk_write_kbytes;
    x13 = struct.Axial_Fan_0;
    x14 = struct.Axial_Fan_1;
    x15 = struct.Blower_Fan_0;
    x16 = struct.Blower_Fan_1;


    X = [ x1 x2 x3 x4 x5 x6 x7 x8 x9 x10 x11 x12 x13 x14 x15 x16]; 
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
    fprintf('      b8  * cmiss_core1_scales +\n');
    fprintf('      b9  * cmiss_core2_scaled +\n');
    fprintf('      b10 * cmiss_core3_scaled\n');
    fprintf('      b12 * data_read_kbytes + \n');
    fprintf('      b13 * data_write_kbytes\n');
    fprintf('      b14 * axial_fan_speed_1');
    fprintf('      b15 * axial_fan_speed_2');
    fprintf('      b16 * blower_fan_speed_1');
    fprintf('      b17 * blower_fan_speed_2');

    if withinter == 1
        fprintf('+ interaction terms\n');
    end;
    [bcoff yhat stats] = doregress(Y,X,withinter);
    %h=figure();
    %normplot(stats.r);
    %title('Normal plots of residuals of model');
    %h2=figure();
    %scatter(stats.yhat,stats.r);
    %title('Scatterplot of estimates vs. residuals');


    varargout(1) = {stats};


   
