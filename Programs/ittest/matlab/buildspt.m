function [p d] = buildspt(cpuid, bm,varargin)
% buildsp - builds the data spreadsheet for a benchmark

    
    pmcfile = strcat(bm,'.pmc.csv');
    [pmctimes HT0Scaled HT1Scaled HT2Scaled cmiss_core0_scaled cmiss_core1_scaled ...
    cmiss_core2_scaled cmiss_core3_scaled] = pmcestimate(pmcfile);
    pmc = [pmctimes HT1Scaled HT2Scaled];
    l2miss = [pmctimes cmiss_core0_scaled cmiss_core1_scaled cmiss_core2_scaled ...
              cmiss_core3_scaled];
    impifile = strcat(bm,'.ipmi.txt');
    importcsv(impifile);
    temps = [Time Ambient_Temp0 Ambient_Temp1];
    if (cpuid == 0)
        temps = [temps CPU_1_Temp];
    else
        temps = [temps CPU_0_Temp];
    end
    
    fans = [Time Blower_Fan_0  Blower_Fan_1 Axial_Fan_0 Axial_Fan_1];

    data = joinmat(temps,pmc,'inner');
    data = joinmat(data,l2miss,'inner');
    powerfile = strcat(bm,'.powerdata.txt');
    % p = [praw.data(:,2)*5 praw.data(:,3:5) InputDCpwr AllPwrExtBd ProcPwr];
    % data = joinmat(data,p,'inner');
    % get disk read/write data
    % assume data file generated from bm.iostat.log using the shell 
    % command:
    % (head -n 2 bm.iostat.log ; grep sd0 bm.iostat.log) > bm.iostat.sd0
    %
    sd0file = strcat(bm,'.iostat.sd0');
    draw = importdata(sd0file);
    drawsize = size(draw.data,1)-1;
    dioint = 0:drawsize;
    dioint = dioint * 5;
    dioint = dioint';
    disk_read_kbytes = draw.data(:,4) * 5;
    disk_write_kbytes = draw.data(:,5) * 5;

    diskio = [dioint disk_read_kbytes disk_write_kbytes];
    data = joinmat(data,diskio, 'inner');
    data = joinmat(data,fans,'inner');
    % Setup the regression variables.
    % Trim the arrays
    if (cpuid == 0)
        c = CPU_0_Temp;
    else
        c = CPU_1_Temp;
    end
    psize = size(c,1);
    dsize = size(data,1);
    if psize > dsize
        p = c(1:dsize,:);
        d = data(:,2:size(data,2));
    elseif dsize > psize
        p = c;
        d = data(1:psize,2:size(data,2));
    else
        p = c;
        d = data(:,2,size(data,2));
    end
    d = [ones(size(d,1),1) d];
    
        
    
    
    
    
        
    
    
