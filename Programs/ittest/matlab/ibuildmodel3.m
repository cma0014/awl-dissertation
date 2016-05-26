function [pwr data] = ibuildmodel3(bm,varargin)
% buildsp - builds the data spreadsheet for a benchmark
    numvarargs = length(varargin);
    if (numvarargs > 2)
        error('ibuildmodel: too many optional arguments');
    end
    optargs = {0 0};
    if (numvarargs > 0)
        optargs(1:numvarargs) = varargin;
    end
    [smooth dofigures] = optargs{:};
    bm = [bm '/' bm];
    csvfile = strcat(bm,'.csv');
    importcsv(csvfile);
    %pwr = ProcPwr;
    pwr = InputDCPwr ./ 10;
    temps = [Temp0 Temp1 Planar_Temp VRD_0_Temp VRD_1_Temp];
    fans = [Fan_1 Fan_2A Fan_2B Fan_3A Fan_3B Fan_4A Fan_4B Fan_5A ...
            Fan_5B];
    pmcs = [fsb_scaled l2miss_scaled];
    disk = [disk_read_kbytes disk_write_kbytes];
    data = [temps pmcs fans disk];
%    data = [temps pmcs fans];
    
        
    
    
    
    
        
    
    
