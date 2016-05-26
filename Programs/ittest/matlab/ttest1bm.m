function [bmerror errstats pcnterr varargout] = ttest1bm(bm,temp, temphat)
% test1bm: Do a t-test and error stats for a benchmark 
    bmerror = abs(temphat - temp);
    fprintf('\nPaired t-test between actual and estimated power\n');
    fprintf('h: Accept/Reject p: p-value ci: conf interval');
    [h p ci] = ttest2(temp,temphat);
    varargout(1)={h}; varargout(2)={p}; varargout(3)={ci};
    fprintf(': h = %8.2f p = %8.2f ci = [%8.2f %8.2f]\n',h,p, ...
            ci);
    errstats = [mean(bmerror) ...
                median(bmerror) ...
                std(bmerror) ...
                var(bmerror)];
    pcnterr = mean(bmerror)/mean(temp);
    

