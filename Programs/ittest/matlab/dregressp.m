function [bcoff yhat varargout] = dregressp(Y,X,withinter)
%dregressp
%  Use the Stat Toolbox regstats function to do linear regression
%  on a data set collected for the HPCA paper
%

    % Now do the regression
    if withinter == 1
        fprintf('Linear regression with interaction terms:\n');
        stats = regstats(Y,X,'interaction');
    else
        fprintf('Linear regression without interaction terms:\n');
        stats = regstats(Y,X);
    end;

    if withinter == 1
        fprintf('+ interaction terms\n');
    end;
    bcoff = stats.beta;
    yhat = stats.yhat;
    varargout(1) = {stats};
    
    printmodel(stats);
    printanova(stats);
    %h=figure();
    %normplot(stats.r);
    %title('Normal plots of residuals of model');
    %h2=figure();
    %scatter(stats.yhat,stats.r);
    %title('Scatterplot of estimates vs. residuals');
   
