function [times powerhat] = polytime(power)
    fprintf('Doing setup for prediction\n');
    powlen = length(power);
    pts = 5*(1:powlen);
    hx=median(abs(pts-median(pts)))/0.6745*(4/3/powlen)^0.2;
    hy=median(abs(power-median(power)))/0.6745*(4/3/powlen)^0.2;
    h=sqrt(hy*hx);
    fprintf('Starting timings\n');
    incre = powlen / 10;
    times = [0 0];
    for i = 10: incre: 1000
        resulttime(1) = i
        tic;
            cputimeStart = cputime;
            r = ksrlin(pts,power,h,powlen);
            cputimeEnd = cputime;
            elaspecputime = abs(cputimeEnd - cputimeStart);
            powerhat = transpose(r.f);
            error = mean(powerhat - power);
        resulttime(2) = toc;
        times = [times; resulttime];
        fprintf('size = %3.0f\terror = %8.8f\ttime = %6.2f\tcputime=%3.2f\n', ...
                i, ...
                error, ...
                resulttime, ...
                elaspecputime);
    end;
