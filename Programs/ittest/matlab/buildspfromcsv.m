function [p d] = buildspfromcsv(bm,varargin)
% buildsp - builds the data spreadsheet for a benchmark
    numvarargs = length(varargin);
    optargs = {1};
    if (numvarargs > 0)
        optargs(1:numvarargs) = varargin;
    end
    [addones] = optargs{:};
    csvname = strcat(bm,'.csv');
    importcsv(csvname)
    data = [Ambient_Temp0 Ambient_Temp1 CPU_0_Temp CPU_1_Temp ...
            HT1Scaled HT2Scaled ...
            cmiss_core0_scaled cmiss_core1_scaled ...
            cmiss_core2_scaled cmiss_core3_scaled ...
            disk_read_kbytes disk_write_kbytes ...
            Axial_Fan_0 Axial_Fan_1 Blower_Fan_0  Blower_Fan_1 ...
            ];
    if addones == 1
        d = [ones(size(data,1),1) data];
    else
        d = data;
    end
    %p = ProcPwr;
    p = InputDCPwr;
    
        
    
    
    
    
        
    
    
