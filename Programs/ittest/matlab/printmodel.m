function printmodel(m)
%PRINTMODEL(m)
%   Prints model and fit statistics output from regstats
    fprintf('Beta coefficients for linear model:\n');
    fprintf(' i     beta\n');
    fprintf('      %10.6f\n',m.beta);
    
%   M: stats array
    fprintf('\n');
    fprintf('Regression coefficent t-test with dfe = %8.2f\n',m.tstat.dfe);
    fprintf(' i   Beta         SE          t        pval\n');
    fprintf('%10.6f %10.6f %10.06f %10.6f\n',...
        m.tstat.beta, ...
        m.tstat.se, ...
        m.tstat.t, ...
        m.tstat.pval);
    fprintf('R-sq: %5s %10.6f\n',m.rsquare);
    fprintf('Adj R-sq; %10.6f\n',m.adjrsquare);
    fprintf('\n');

    
    
   
