function powronly(results)
    % Now pretty print things
    fprintf('\nBenchmark statistics:\n');
    numbm = size(results,1);
    for i = 1:numbm
        bmname = results{i,1};
        bmerror = results{i,3};
        errstats = results{i,4};
        power = results{i,9};
        powerhat = results{i,10};
        minpower = min(min(power),min(powerhat)) - 2;
        maxpower = max(max(power),max(powerhat)) + 2;
        t = 5*(1:size(power,1));
        maxtime = max(t);
        h = figure('Name',bmname,'NumberTitle','off');
        hold on;
        plot(t,power,'-k');
        axis([0 maxtime minpower maxpower]);
        %title(['Power Trace for ' bmname]);
        ylabel('Power (watts)','fontsize',12,'fontweight','b');
        xlabel('Time(s)','fontsize',12,'fontweight','b');
        hold off;
    end
    fprintf('\nError statistics for each benchmark:\n');
   
