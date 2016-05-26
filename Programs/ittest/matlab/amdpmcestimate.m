function [TIMES bustran l2miss varargout] =  amdpmcestimate(filename,varargin)
% pmcestimate - Deal with data issues with the PMC counters
    optargs = size(varargin,1);
    if optargs > 0
        sinterval = varargin{1}
    else
        sinterval = 5;
    end
    importcsv(filename);
    a = [time cpu FSB L2miss];
    curTime = 0;
    nextTime = sinterval;
    slotnum = 1;
    numReadings = length(time);
    TIMES = zeros(numReadings,1);
    FSB0 = zeros(numReadings,1);
    FSB1 = zeros(numReadings,1);
    L2_MISS0 = zeros(numReadings,1);
    L2_MISS1 = zeros(numReadings,1);
    for reading = 1:numReadings
        if time(reading) >= nextTime
            slotnum = slotnum + 1;
            curTime = nextTime;
            nextTime = nextTime + sinterval;
            %TIMES(slotnum) = time(reading);
            TIMES(slotnum) = curTime;
        end
        switch cpu(reading)
          case 0
            FSB0(slotnum) = FSB0(slotnum) + FSB(reading);
            L2_MISS0(slotnum) = L2_MISS0(slotnum) + L2miss(reading);
          case 1
            FSB1(slotnum) = FSB1(slotnum) + FSB(reading);
            L2_MISS1(slotnum) = L2_MISS1(slotnum) + L2miss(reading);
          otherwise
            fprintf('Unepxected CPU number %d in reading %d\n',cpu(reading),reading);
        end
    end 
    if slotnum <= numReadings
        TIMES = TIMES(1:slotnum);
        FSB0 = FSB0(1:slotnum);
        FSB1 = FSB1(1:slotnum);
        L2_MISS0 = L2_MISS0(1:slotnum);
        L2_MISS1 = L2_MISS1(1:slotnum);
    end
    varargout{1} = FSB0;
    varargout{2} = FSB1;
    varargout{3} = L2_MISS0;
    varargout{4} = L2_MISS1;
    bustran  = ((FSB0 + FSB1)./2);
    l2miss = ((L2_MISS0 + L2_MISS1)./2);
    bustran = bustran ./ 1e6;
    l2miss = l2miss ./ 1e5;
    

    
    
    
