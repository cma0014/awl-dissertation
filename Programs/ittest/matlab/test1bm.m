function [abserror errstats pcnterr h p ci relerr] = test1bm(bm,power, powerhat)
% test1bm: Do a t-test and error stats for a benchmark 
    [h p ci] = ttest2(power,powerhat);
    abserror = abs(powerhat - power);
    relerr = abserror ./ power;
    pcnterr = mean(relerr) * 100;
    errstats = [mean(abserror) ...
                median(abserror) ...
                std(abserror) ...
                var(abserror)];
    

