function times = randtest(n,varargin)
    nv = length(varargin);
    if (nv > 1)
        error('too many variables arguments in randtest');
    end;
    optargs = {100};
    if (nv > 0)
       optargs = varargin;
    end
    [printerval] = optargs{:};
    if (n < 100), error('n must be >= 100'),end;
    times = [0 0];
    for i = 100:10:n
        tr(1) = i;
        pts = 1:i;
        power = rand(i,1)*60;
        powlen = i;
        hx=median(abs(pts-median(pts)))/0.6745*(4/3/powlen)^0.2;
        hy=median(abs(power-median(power)))/0.6745*(4/3/powlen)^0.2;
        h=sqrt(hy*hx);
        tic;
            r  = ksrlin(pts,power,h,powlen);
        tr(2) = toc;
        if (mod(i,printerval) == 0)
            fprintf('i = %d; time = %f\n',tr);
        end;
        times = [times; tr];
    end;

    
