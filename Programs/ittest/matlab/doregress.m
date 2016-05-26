function [bcoff yhat stats] = doregress(Y,X,withinter)
        % Now do the regression
    if withinter == 1
        fprintf('Linear regression with interaction terms:\n');
        stats = regstats(Y,X,'interaction');
    else
        fprintf('Linear regression without interaction terms:\n');
        stats = regstats(Y,X);
    end;
    bcoff = stats.beta;
    yhat = stats.yhat;
    varargout(1) = {stats};
    
    printmodel(stats);
    printanova(stats);
