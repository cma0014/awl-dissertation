% aprediction:  MATLAB script for testing
% bm[1] -> bmname
% bm[2] -> bmcolor
% bm[3] -> bmerror
% bm[4] -> errstats
% bm[5] -> pcnterr
% bm[6] -> h
% bm[7] -> p
% bm[8] -> ci
% bm[9] -> power
% bm[10] -> powerhat
    benchmarks={'bzip2.csv' 'b'; ...
            'cactusadm.csv' 'g'; ...
            'gromac.csv' 'c'; ...
            'h264ref.csv' 'm';  ...
            'lbm.csv' 'y';  ...
            'leslie3d.csv' 'g' ; ...
            'omnetpp.csv' 'k' ; ...
            'perlbench.csv' 'b'};
    % Create the model
    basisfilename = input('Enter file name: ','s');
    overall = importcsv2struct(basisfilename);
    [bhat yhat stats] = sregressp(overall,0);
    for i = 1:size(benchmarks)
        bmname = benchmarks{i,1};
        bmcolor = benchmarks{i,2};
        fprintf('bm: %s\n',bmname);
        data = importcsv2struct(bmname);
        [data.powerhat data.est] = addest(data,bhat,bmcolor);
  
        [benchmarks{i,3} benchmarks{i,4} benchmarks{i,5} benchmarks{i,6} benchmarks{i,7} ...
           benchmarks{i,8} benchmarks{i,11}] =  test1bm(bmname,data.ProcPwr,data.powerhat);
        benchmarks{i,9} = data.ProcPwr;
        benchmarks{i,10} = data.powerhat;
        dumppred(bmname,data.ProcPwr,data.powerhat);
    end
    prettyprt(benchmarks);
    prterror(benchmarks);
    
    

    

