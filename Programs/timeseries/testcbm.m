function [abserror errstats pcnterr h p ci relerr] = testcbm(bm,power, powerhat)
% test1bm: Do a t-test and error stats for a benchmark 
    h = 0;  p = 0 ; ci= [0 0];
    abserror = abs(powerhat - power);
    relerr = abserror ./ power;
    pcnterr = mean(relerr) * 100;
    errstats = [mean(abserror) ...
                median(abserror) ...
                std(abserror) ...
                var(abserror)];
    
    

