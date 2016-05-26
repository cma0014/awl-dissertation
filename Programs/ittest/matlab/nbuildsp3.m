function [ProcPwr data] = nbuildsp3(bm,varargin)
% ibuildsp3 - reads the data spreadsheet for a benchmark
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
        [ProcPwr data] = nbuildmodel3(bm);
    else
        [ProcPwr data] = nbuildmodel3(bm,smooth,dofigures);
    end        

    
        
    
    
    
    
        
    
    
