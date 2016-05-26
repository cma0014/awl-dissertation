function bcoff = regresswithht(filename)
%REGRESSDATA
%  Use the Stat Toolbox regstats function to do linear regression
%  on a data set collected for the HPCA paper
%

% Tell the world which file we're processing
    fprintf('\nFilename: %s',filename);
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

    

    X = [ x1 x2 x3 x4 x6 x7 x8 x9 x10 x11 x12 x13];
    % Now do the regression
    stats = regstats(Y,X,'interaction');
    bcoff = stats.beta;
    
    printmodel(stats);
    printanova(stats);
    normplot(stats.r);
    
