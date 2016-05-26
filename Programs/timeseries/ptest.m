function ptest(results)
    numbm = size(results,1);
    for i = 1:numbm
        bmname = results{i,1};
        bmerror = results{i,3};
        pcnterr = results{i,5};
        power = results{i,9};
        pactual = results{i,12};
        thalf = 5*(1:size(power));
        t = 5*(1:size(pactual));
        maxtime = max(t);
        phat = results{i,10};
        winsize = length(power)
        maxfuture = 15;
        in = 1;
        for futurepts=100:25:winsize
            newN = winsize+futurepts;
            tnew = 5*(futurepts:newN);
            p = pactual(futurepts:newN);
            hx=median(abs(tnew-median(tnew)))/0.6745*(4/3/winsize)^0.2;
            hy=median(abs(p-median(p)))/0.6745*(4/3/winsize)^0.2;
            h=sqrt(hy*hx);
            r = ksrlin(tnew,p,h,winsize);
            uhatsave{i} = r.f(winsize-futurepts:winsize);
            in = in + 1;
        end
        % Now we draw the results.
        minpower = min(min(p),min(phat)) - 2;
        maxpower = max(max(p),max(phat)) + 2;
        hf1 = figure('Name',bmname,'NumberTitle','off');
        hold on;
        % hfill = jbfill(t,upper,lower,'b','w',1,0.7);
        tact = 1:(length(power)+maxfuture);
        hl0 = line(5*tact,pactual(tact),...
                             'LineWidth',2, ...
                             'Color','b',...
                             'LineStyle','-');
        hl1 = line(thalf,power,'LineWidth',2, ...
                       'Color','k',...
                       'LineStyle','-');
        in = 1;
        for index = 100:25:250
            hl{in} = line(5*((1:(index+1))+winsize) ,uhatsave{in}, ...
                                 'LineWidth',2, ...
                                 'Color','r',...
                                 'LineStyle',':');
            in = in + 1;
        end
        % legend([hl1 hl2 hfill],{'Actual','Predicted','Error'})
        %legend([hl0,hl1 hl2],{'Actual','Actual', 'Predicted'})
        %legend boxoff;
        %plot(t,p,'-g',t,phat,'-r','LineWidth',2);
        axis([0 maxtime minpower maxpower]);
        xlabel('Time (in sec.)', 'fontsize', 12, 'fontweight','b');
        ylabel('Power (watts)', 'fontsize',12,'fontweight','b');
        %title(bmname);
        %applyhatch_pluscolor(hf1,'/',1);
        hold off;
        clear lower upper;
    end
    
