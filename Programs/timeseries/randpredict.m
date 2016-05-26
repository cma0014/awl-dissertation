function times = randpredict(n,varargin)
    nv = length(varargin);
    if (nv > 1)
        error('too many variables arguments in randtest');
    end;
    optargs = {10};
    if (nv > 0)
       optargs = varargin;
    end
    [printerval] = optargs{:};
    if (n < 10), error('n must be >= 10'),end;
    pts = 1:100;
    power = rand(100,1)*60;
    powlen = 100;
    hx=median(abs(pts-median(pts)))/0.6745*(4/3/powlen)^0.2;
    hy=median(abs(power-median(power)))/0.6745*(4/3/powlen)^0.2;
    h=sqrt(hy*hx);
    r  = ksrlin(pts,power,h,powlen);
    p = polyfit(r.x,r.f,3);
    times = [0 0];
    for i = 1:n
        xrange = 101:100+i;
        tr(1) = i;
        tic;
            f = polyval(p,xrange);
        tr(2) = toc;
        if (mod(i,printerval) == 0)
            fprintf('i = %d; time = %f\n',tr);
        end;
        times = [times; tr];
    end;

    
