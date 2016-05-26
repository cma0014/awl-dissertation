function eplot(ibm,abm)
    h = figure;
    hold on;
    color = {':k',':k',':k',':k'};
    icolor = {'-k','-k','-k','k'};
    for i = 1:(size(ibm,1) - 1)
        subplot(3,1,i);
        bmname = ibm{i,1};
        err =100* abm{i,11};
        l = 5*(1:length(err));
        ierr = 100*ibm{i,11};
        il = 5*(1:length(ierr));
        plot(l,err,color{i},il,ierr,icolor{i},'LineWidth',2);
        title(bmname);
        axis([0 1500 0 15]);
        if (i == 2) 
            ylabel('Error percentage (%)','fontsize',12,'fontweight','b');
        end;
        if (i == 3)
            xlabel('Time (in sec.)','fontsize',12,'fontweight','b');
        end;
        
    end;
    legend('Intel','AMD');
    
    hold off;

    
    
