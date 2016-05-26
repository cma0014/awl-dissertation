function errorplot(results)
    fprintf('\nPlotting error bar information');
    numbm = size(results,1);
    for i = 1:numbm
        h = figure;
        bmname = results{i,1};
        bmerror = results{i,3};
        errstats = results{i,4};
        pcnterr = results{i,5};
        power = results{i,9};
        powerhat = results{i,10};
        errpcnt = results{i,11};
        minpower = min(power) - 5;
        maxpower = max(power) + 5;
        t = 5*(1:size(power,1));
        errorbar(t,power,errpcnt);
        xlabel('Actual Power (watts)');
        ylabel('Predicted Power (watts)');
        title(bmname);
    end
