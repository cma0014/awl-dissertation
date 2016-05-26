function [TIMES bustran l2miss varargout] =  intelpmcestimate(filename,varargin)
% pmcestimate - Deal with data issues with the PMC counters
    numvarargs = length(varargin);
    if (numvarargs > 2)
        error('intelpmcestimate: too many optional arguments');
    end
    optargs = {5 0};
    if (numvarargs > 0) 
        optargs(1:numvarargs) = varargin;
    end
    [sinterval,smooth] = optargs{:};
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
    lastfsb = [0 0];
    lastl2 = [0 0];
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
            r = FSB(reading);
            if ((smooth == 1) && (r == 0))
                r = lastfsb(1);
            end;
            FSB0(slotnum) = FSB0(slotnum) + r;
            r = L2miss(reading);
            if ((smooth == 1) && (r == 0))
                r = lastl2(1);
            end;
            L2_MISS0(slotnum) = L2_MISS0(slotnum) + r;
            if (smooth == 1) 
                lastfsb(1) = FSB(reading);
                lastl2(1) = L2miss(reading);
            end
          case 1
            r = FSB(reading);
            if ((smooth == 1) && (r == 0))
                r = lastfsb(2);
            end;
            FSB1(slotnum) = FSB1(slotnum) + r;
            r = L2miss(reading);
            if ((smooth == 1) && (r == 0))
                r = lastl2(2);
            end;
            L2_MISS1(slotnum) = L2_MISS1(slotnum) + r;
            if (smooth == 1)
                lastfsb(2) = FSB(reading);
                lastl2(2) = L2miss(reading);
            end;
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
    %     bustran = bustran ./ 1e6;
    %     l2miss = l2miss ./ 1e5;
    

    
    
    
