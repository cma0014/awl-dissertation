function [ProcPwr data] = nbuildmodel3(bm,varargin)
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
    pmcs = [offcore_req_scaled ...
            l2_cache_miss_scaled];
    temps = [Temp0	Temp1	Temp2	...
             Ambient_Temp0	Temp3	Ambient_Temp1	Ambient_Temp2 ...
             Planar_Temp	Temp4	Temp5	Temp6];
    fans = [FAN_MOD_1A_RPM	FAN_MOD_2A_RPM	...
            FAN_MOD_3A_RPM	...
            FAN_MOD_4A_RPM	...
            FAN_MOD_5A_RPM  ...
            FAN_MOD_6A_RPM	...
            FAN_MOD_1B_RPM	FAN_MOD_2B_RPM ...
            FAN_MOD_3B_RPM	FAN_MOD_4B_RPM ...
            FAN_MOD_5B_RPM	FAN_MOD_6B_RPM];
    disk = [disk_read_kbytes disk_write_kbytes];
    data = [temps pmcs fans disk];
    %data = [temps pmcs fans];

    
    
    
        
    
    
