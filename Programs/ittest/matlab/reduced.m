%
% File:     reduced.m
% Author:   awl8049
% Revision: $Revision: 1.1 $
%
% Decide if we can use reduced models and compare prediction using
% arithmetic mean vs. geometric mean.
%
overall = importcsv2struct('overall.csv');
[ofull.bcoff ofull.err ofull.stats] = sregressp(overall,1);
[oreduced.bcoff oreduced.err oreduced.stats] = sregressp(overall,0);
geomean = importcsv2struct('geomean.csv');
[geofull.bcoff geofull.err geofull.stats] = sregressp(geomean,1);
[greduced.bcoff greduced.err greduced.stats] = sregressp(geomean,0);
% Calculate the F-test statistic for comparing full vs. reduced model
% for arithmetic mean.
of_sse = ofull.stats.fstat.sse;
or_sse = oreduced.stats.fstat.sse;
otest = ((or_sse-of_sse)/13)/(of_sse/(413-72));
fprintf(...
    'The value of the test statistic for overall vs. full is %10.6f\n',...
    otest);
% Calculate the F-test statistic for comparing full vs. reduced model
% for arithmetic mean.
gf_sse = geofull.stats.fstat.sse;
gr_sse = greduced.stats.fstat.sse;
gtest = ((gr_sse-gf_sse)/13)/(gf_sse/(413-72));
fprintf(...
    'The value of the test statistic for overall vs. full is %10.6f\n',...
    gtest);
fprintf('The value of the F-pdf for this case is %10.6f\n',finv(0.05,13,(413-72)));
    