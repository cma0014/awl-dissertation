function fuzzytime(filename)
%FUZZyTIME
% Use the functions in the Fuzzy Logic Toolbox to do analyze the data from
% a run
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
    x12 = disk_read_bytes;
    x13 = disk_write_bytes;

    X = [ x1 x2 x3 x4 x6 x7 x8 x9 x10 x11 x12 x13]; 
    % Now do the regression
    data = [X Y];
    fismat = genfis1(data);
    figure(1);
    subplot(2,2,1)
    plotmf(fismat, 'input', 1)
    subplot(2,2,2)
    plotmf(fismat, 'input', 2)
    subplot(2,2,3)
    plotmf(fismat, 'input', 3)
    subplot(2,2,4)
    plotmf(fismat, 'input', 4)
