function [ProcPwr data] = abuildmodel4(bm,varargin)
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
    %bm = [bm '/' bm];
    csvfile = strcat(bm,'.csv');
    importcsv(csvfile);
    % Unused stuff but kept for reference purposes
    htbuss = [HT1 HT2];
    l2miss = [c1c2missC0 c1c2missC1  c1c2missC2 c1c2missC3];
    disk_counts = [disk_read_count disk_write_count];
    disk_bytes = [disk_read_kbytes disk_read_bytes];
    % Build the model
    temps = [ Ambient_Temp0 Ambient_Temp1 CPU_0_Temp CPU_1_Temp];
    pmcs = [ HT1Scaled HT2Scaled];
    l2missScaled = [cmiss_core0_scaled cmiss_core1_scaled cmiss_core2_scaled cmiss_core3_scaled];
    disk_kbytes = [disk_write_kbytes disk_read_kbytes];
    fans = [ Axial_Fan_0 Axial_Fan_1 Blower_Fan_0 Blower_Fan_1];
    data =[temps pmcs l2missScaled fans];
    
        
    
    
    
    
        
    
    
