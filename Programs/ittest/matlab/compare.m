%
% File:    prediction.m
% Author:  awl8049
% Revision:$Revision: 1.2 $
%
% Prompt for the name of the CSV file containing the condensed data
% and then do a linear regression of the data.
%
benchmarks={'bzip2.csv' 'b'; ...
            'cactusadm.csv' 'g'; ...
            'gromac.csv' 'c'; ...
            'h264ref.csv' 'm';  ...
            'lbm.csv' 'y';  ...
            'leslie3d.csv' 'g' ; ...
            'omnetpp.csv' 'k' ; ...
            'perlbench.csv' 'b'};

models={'overall.csv' 'b';...
        'integer.csv','g';...
        'floating.csv','b'};

overall = importcsv2struct(models{1,1});
[over.bhat over.yhat over.stats ]=sregressp(overall,0);
over.sse = over.stats.fstat.sse;

intbm = importcsv2struct(models{2,1});
[ibm.bhat ibm.yhat ibm.stats] = sregressp(intbm,0);
ibm.sse = ibm.stats.fstat.sse;

floatbm = importcsv2struct(models{3,1});
[flbm.bhat flbm.iyhat flbm.stats] = sregressp(floatbm,0);
flbm.sse = flbm.stats.fstat.sse;

itest = ((over.sse - ibm.sse)/13)/(ibm.sse/(413-14));
fprintf(...
    'Test statistic for comparing overall model vs integer is %10.6f\n',...
    itest);

ftest = ((over.sse - flbm.sse)/13)/(ibm.sse/(413-14));
fprintf(...
    'Test statistic for comparing overall model vs integer is %10.6f\n',...
    itest);

fval = finv(0.05,13,(413-14));
fprintf('The value of the F-pdf for this case is %10.6f\n',fval);






