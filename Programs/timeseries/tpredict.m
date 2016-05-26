function tpredict(results,maxfuture)
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
        winsize = length(power);
        newN = winsize+maxfuture;
        tnew = 5*(maxfuture:newN)
        tnew2= 5*(2*maxfuture:winsize+2*maxfuture)
        p = pactual(maxfuture:newN);
        hx=median(abs(t-median(t)))/0.6745*(4/3/winsize)^0.2;
        hy=median(abs(p-median(p)))/0.6745*(4/3/winsize)^0.2;
        h=sqrt(hy*hx);
        r = ksrlin(tnew,p,h,winsize);
        uhatsave = r.f(winsize-maxfuture:winsize);
        newN2 = winsize+(2*maxfuture);
        p2 = pactual(2*maxfuture:newN2);
        hy=median(abs(p2-median(p2)))/0.6745*(4/3/winsize)^0.2;
        h=sqrt(hy*hx);
        r = ksrlin(tnew,p2,h,winsize);
        uhatsave2 = r.f(winsize-2*maxfuture:winsize);
        p2predict = [pactual(2*maxfuture+1:newN); uhatsave'];
        hy=median(abs(p2predict-median(p2predict)))/0.6745*(4/3/winsize)^0.2;
        h=sqrt(hy*hx);
        r = ksrlin(tnew,p2predict,h,winsize);
        uhatsave3 = r.f(winsize-2*maxfuture:winsize)
        % Now we draw the results.
        minpower = min(min(p),min(phat)) - 2;
        maxpower = max(max(p),max(phat)) + 2;
        hf1 = figure('Name',bmname,'NumberTitle','off');
        hold on;
        tact = winsize:(winsize+2*maxfuture);
         hl0 = line(5*tact,pactual(tact),...
                              'LineWidth',2, ...
                              'Color','k',...
                              'LineStyle',':');
        hl1 = line(thalf,power,'LineWidth',2, ...
                       'Color','k',...
                       'LineStyle',':');
        x = 5*((1:length(uhatsave3)) + winsize);
        hl4 = line(x ,uhatsave3, ...
                                 'LineWidth',2, ...
                                 'Color','b',...
                                 'LineStyle','-');
        x = 5*((1:length(uhatsave2)) + winsize);
        hl3 = line(x ,uhatsave2, ...
                                 'LineWidth',2, ...
                                 'Color','g',...
                                 'LineStyle','-');
        x = 5*((1:length(uhatsave)) + winsize);
        hl2 = line(x ,uhatsave, ...
                                 'LineWidth',2, ...
                                 'Color','r',...
                                 'LineStyle','-');
        legend([hl1 hl2 hl3 hl4],{'Actual','p=5,Start', 'p=5,Continued', 'p=10'})
        %legend boxoff;
        %plot(t,p,'-g',t,phat,'-r','LineWidth',2);
        axis([600 5*(winsize+2*maxfuture) minpower maxpower]);
        xlabel('Time (in sec.)', 'fontsize', 12, 'fontweight','b');
        ylabel('Power (watts)', 'fontsize',12,'fontweight','b');
        %title(bmname);
        %applyhatch_pluscolor(hf1,'/',1);
        hold off;
        clear lower upper;
    end
    
