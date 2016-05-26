function prterror(results)
    numbm = size(results,1);
    for i = 1:numbm
        bmname = results{i,1};
        bmerror = results{i,3};
        pcnterr = results{i,5};
        p = results{i,9};
        prev = p(1);
        phat = results{i,10};
        % p = p(1:2:size(p));
        % phat = phat(1:2:size(phat)); 
        minpower = min(min(p),min(phat)) - 2;
        maxpower = max(max(p),max(phat)) + 2;
        for i = 1:length(p)
            if p(i) < phat(i) 
                lower(i) = p(i);
            else
                lower(i) = phat(i);
            end;
            upper(i) = lower(i) + bmerror(i);
        end;
        t = 5*(1:size(p));
        maxtime = max(t);
        hf1 = figure('Name',bmname,'NumberTitle','off');
        hold on;
        % hfill = jbfill(t,upper,lower,'b','w',1,0.7);
        hl1 = line(t,p,'LineWidth',2, ...
                       'Color','k',...
                       'LineStyle','-');
        hl2 = line(t,phat,'LineWidth',2,...
                           'Color','k',...
                           'LineStyle',':');
        % legend([hl1 hl2 hfill],{'Actual','Predicted','Error'})
        legend([hl1 hl2],{'Actual','Predicted'})
        legend boxoff;
        %plot(t,p,'-g',t,phat,'-r','LineWidth',2);
        axis([0 maxtime minpower maxpower]);
        xlabel('Time (in sec.)', 'fontsize', 12, 'fontweight','b');
        ylabel('Power (watts)', 'fontsize',12,'fontweight','b');
        %title(bmname);
        %applyhatch_pluscolor(hf1,'/',1);
        hold off;
        clear lower upper;
    end
    
