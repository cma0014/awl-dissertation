function prettyprt0(results)
    % Now pretty print things
    fprintf('\nError statistics:\n');
    numbm = size(results,1);
    fprintf('\nbm mean median std var pcterr\n');
    maxtemp = max([cell2mat(results(:,25));cell2mat(results(:,26))])+ 10;
    mintemp = min([cell2mat(results(:,25));cell2mat(results(:,26))])- 10 ;
    if (mintemp < 0)
        mintemp = 25;
    end
    maxtime = 0;
    for i = 1:size(results(:,25),1)
        newsize = size(cell2mat(results(i,25)),1)
        if (newsize > maxtime)
            maxtime = newsize
        end
    end
    maxtime = 5*maxtime;
    for i = 1:numbm
        h = figure;
        %subplot(2,2,i);
        bmname = results{i,1};
        bmerror = results{i,19};
        errstats = results{i,20};
        pcnterr = results{i,21};
        h = results{i,22};
        p = results{i,23};
        ci = results{i,24};
        temp = results{i,25};
        temphat = results{i,26};
        fprintf('%s\t%8.2f\t%8.2f\t%8.2f\t%8.2f\t%8.2f\n',...
            bmname, ...
            errstats, ...
            pcnterr);
        t = 5*(1:size(temp,1));
        plot(t,temp,'b',t,temphat,'r-');
        textx = maxtime - 350;
        texty = maxtemp - 6;
        [textstr , errmsg] = sprintf('Avg error = %2d%%',round(pcnterr*100));
        text(textx, texty, textstr);
        axis([0 maxtime mintemp maxtemp]);
        title(bmname);
        ylabel('Temp(degC)');
        xlabel('Time(s)');
        legend('Actual','Estimated');
%         switch i
%           case {1}
%             set(gca,'YTickMode','auto');
%             set(gca,'XTick',[]);
%             % ylabel('Temp(watts)');
%           case {2}
%             set(gca,'YTickMode','auto');
%             set(gca,'XTick',[]);
%           case {3}
%             set(gca,'XTickMode','auto');
%             set(gca,'YtickMode','auto');
%             xlabel('Time(s)');
%             % ylabel('Temp(watts)');
%           case {4}  
%             set(gca,'YTickMode','auto');
%             xlabel('Time(s)');
%           otherwise
%             set(gca,'XTick',[],'YTick',[]);
%         end
    end
   
