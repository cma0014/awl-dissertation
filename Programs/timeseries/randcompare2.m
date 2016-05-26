function randcompare2(tdat)
    n = tdat(:,1);
    t = tdat(:,2);
    nsquare = 1e-8*n.^2;
    ncube = 1e-11*n.^3;
    nquad = 1e-14*n.^4;
    hf = figure;
    hl1 = line(n,t,'LineWidth',1,...
                   'Color', 'k',...
                   'LineStyle','-');
%     hl2 = line(n,nsquare,'LineWidth',2,...
%                    'Color', 'b',...
%                    'LineStyle',':');
%     hl3 = line(n,ncube,'LineWidth',2,...
%                    'Color', 'k',...
%                    'LineStyle',':');
%     hl4 = line(n,nquad,'LineWidth',2,...
%                    'Color', 'r',...
%                    'LineStyle',':');
%     legend([hl1 hl2 hl3 hl4], {'t','1e-8*n^2','1e-11*n^-3','1e-14*n^4'});
    legend boxoff;
    xlabel('p','FontSize',14,'FontWeight','b');
    ylabel('t (in sec.)','FontSize',14,'FontWeight','b');
    axis([0 5000 0 0.0015]);
    %title('CAP performance vs. number of future observations');
    tdatsize = length(tdat);
    for i = 100:1000:tdatsize
        s = sprintf('(%d, %d)',tdat(i,:));
        text(tdat(i,1)+60,tdat(i,2),s,'FontSize',14,'FontWeight','b');
    end
    
    
    
    
