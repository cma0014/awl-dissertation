function [p d1] = ibuildsp(bm,varargin)
% ibuildsp - builds the data spreadsheet for a benchmark
    numvarargs = length(varargin);
    if (numvarargs > 2)
        error('iprediction: too many optional arguments');
    end
    optargs = {0 0};
    if (numvarargs > 0)
        optargs(1:numvarargs) = varargin;
    end
    [dofigures smooth] = optargs{:};
    if (smooth == 0) 
        [ProcPwr data] = ibuildmodel(bm);
    else
        [ProcPwr data] = ibuildmodel(bm,smooth,dofigures);
    end        

    % Trim the arrays
    psize = size(ProcPwr,1);
    dsize = size(data,1);
    if psize > dsize
        p = ProcPwr;
        d = [ data; zeros(psize-dsize,size(data,2))];
    elseif dsize > psize
        p = [ProcPwr; zeros(dsize-psize,1)];
        d = data;
    else
        p = ProcPwr;
        d = data;
    end
    d1 = [ones(size(d,1),1) d];

    
        
    
    
    
    
        
    
    
