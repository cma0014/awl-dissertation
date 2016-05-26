function prettyprt(results)
    % Now pretty print things
    fprintf('\nBenchmark statistics:\n');
    numbm = size(results,1);
    fprintf(['\nbm mix max | mean(p) median(p) std(p) var(p) | '...
             'mean(phat) median(phat) std(phat) var(phat)\n']);
    for i = 1:numbm
        h = figure;
        bmname = results{i,1};
        bmerror = results{i,3};
        errstats = results{i,4};
        power = results{i,9};
        powerhat = results{i,10};
        minpower = min(min(power),min(powerhat)) - 2;
        maxpower = max(max(power),max(powerhat)) + 2;
        rmse =norm(bmerror) / sqrt(length(bmerror));
        fprintf(['%s | %8.4f %8.4f | %8.4f %8.4f %8.4f %8.4f | ' ...
            '%8.4f %8.4f %8.4f %8.4f\n'],...
                bmname, ...
                min(power), max(power), ...
                mean(power),median(power),std(power),var(power), ...
                mean(powerhat),median(powerhat), ...
                      std(powerhat),var(powerhat) ...
                );
        t = 5*(1:size(power,1));
        maxtime = max(t);
        % hold on;
        % plot(t,power,'-k',t,powerhat,'-r');
        % axis([0 maxtime minpower maxpower]);
        % %title(bmname);
        % ylabel('Power (watts)');
        % xlabel('Time(s)');
        % legend('Actual','Estimated');
        % hold off;
    end
    fprintf('\nError statistics for each benchmark:\n');
    fprintf(['\nbm mix max | mean(p) median(p) std(p) var(p) | '...
             '%%error mean(relerr) median(relerr) max(relerror)'...
             ' |  rmse\n']);
    for i = 1:numbm
        bmname = results{i,1};
        bmerror = results{i,3};
        errstats = results{i,4};
        pcnterr = results{i,5};
        power = results{i,9};
        powerhat = results{i,10};
        pcnterr = results{i,5};
        relerr = results{i,11};
        rmse = norm(bmerror) / sqrt(length(bmerror));
        fprintf(['%s | %8.4f %8.4f | ' ...
            '%8.4f %8.4f %8.4f %8.4f | %8.4f\n'],...
                bmname, ...
                min(power), max(power), ...
                pcnterr, mean(relerr), median(relerr), ...
                      max(relerr),rmse ...
                );
    end;
    
    fprintf('\nPaired t-test between actual and estimated power\n');
    fprintf('h: Accept/Reject p: p-value ci: conf interval\n');
    for i = 1:numbm
        bmname = results{i,1};
        h = results{i,6};
        p = results{i,7};
        ci = results{i,8};
        fprintf('%s | h = %8.4f p = %8.4f ci = [%8.4f %8.4f] \n',...
                bmname, ...
                h,p, ...
                ci);
    end
   
