function t = randrepeat(n,varargin)
    nv = length(varargin);
    if (nv > 2)
        error('too many variables in randrepeat');
    end
    optargs = {5000,500};
    if (nv > 0)
        optargs = varargin;
    end;
    [maxsample prtinterval] = optargs{:};
    first = 1;
    for i = 1:n
        fprintf('Iteration: %d\n',i);
        rpt = randtest(maxsample,prtinterval);
        if (first == 1)
            t = rpt;
            first = 0;
        else
            t = t + rpt;
        end;
    end;
    t = t ./ n;
    randplot(t);
    
    
    
