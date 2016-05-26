function prettyprt0(results)
    % Now pretty print things
    fprintf('\nError statistics:\n');
    numbm = size(results,1);
    fprintf('\nbm mean median std var pcterr\n');
    maxpower = max([cell2mat(results(:,17));cell2mat(results(:,18))])+ 10;
    minpower = min([cell2mat(results(:,17));cell2mat(results(:,18))])- 10 ;
    if (minpower < 0)
        minpower = 25;
    end
    maxtime = 0;
    for i = 1:size(results(:,9),1)
        newsize = size(cell2mat(results(i,9)),1)
        if (newsize > maxtime)
            maxtime = newsize
        end
    end
    maxtime = 5*maxtime;
    for i = 1:numbm
        h = figure;
        %subplot(2,2,i);
        bmname = results{i,1};
        bmerror = results{i,11};
        errstats = results{i,12};
        pcnterr = results{i,13};
        h = results{i,14};
        p = results{i,15};
        ci = results{i,16};
        power = results{i,17};
        powerhat = results{i,18};
        fprintf('%s\t%8.2f\t%8.2f\t%8.2f\t%8.2f\t%8.2f\n',...
            bmname, ...
            errstats, ...
            pcnterr);
        t = 5*(1:size(power,1));
        plot(t,power,'b',t,powerhat,'r-');
        textx = maxtime - 350;
        texty = maxpower - 6;
        [textstr , errmsg] = sprintf('Avg error = %2d%%',round(pcnterr*100));
        text(textx, texty, textstr);
        axis([0 maxtime minpower maxpower]);
        title(bmname);
        ylabel('Temp(degC)');
        xlabel('Time(s)');
        legend('Actual','Estimated');
%         switch i
%           case {1}
%             set(gca,'YTickMode','auto');
%             set(gca,'XTick',[]);
%             % ylabel('Power(watts)');
%           case {2}
%             set(gca,'YTickMode','auto');
%             set(gca,'XTick',[]);
%           case {3}
%             set(gca,'XTickMode','auto');
%             set(gca,'YtickMode','auto');
%             xlabel('Time(s)');
%             % ylabel('Power(watts)');
%           case {4}  
%             set(gca,'YTickMode','auto');
%             xlabel('Time(s)');
%           otherwise
%             set(gca,'XTick',[],'YTick',[]);
%         end
    end
   
