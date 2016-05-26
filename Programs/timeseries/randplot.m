function randplot(times)
    n = times(:,1); t = times(:,2);
    hold on;
    plot(n,t,'b');
    xlabel('# obs (n)');
    ylabel('t (s)');
    hold off;
    
