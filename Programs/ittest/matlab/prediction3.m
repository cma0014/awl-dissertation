% prediction2:  MATLAB script for testing benchmarks
    benchmarks = { 'astar' 'b'; ...
                   'gamess' 'g';...
                   'calculix' 'g';...
                   'gobmk', 'r'; ...
                   'zeusmp','k'; ...
                   'idle1','r'};
    % Create the model
    basisfilename = input('Enter file name: ','s');
    overall = importcsv2struct(basisfilename);
    overall.ProcPwr = 0.9*overall.ProcPwr;
    [bhat yhat stats ] = sregressp(overall,0);
%     bhat(1) = bhat(1) - 5; 
    bhat(12) = 1.1*bhat(12);
    bhat(13) = 1.1*bhat(13);
    for i = 1:size(benchmarks)
        bmname = benchmarks{i,1};
        bmcolor = benchmarks{i,2};
        fprintf('bm: %s\n',bmname);
        location = [pwd '/'  bmname '/' bmname];
        [power data] = buildspfromcsv(location);
        [powerhat] = data * bhat;
        [benchmarks{i,3} benchmarks{i,4} benchmarks{i,5} benchmarks{i,6} benchmarks{i,7} ...
         benchmarks{i,8} benchmarks{i,11}] =  test1bm(bmname,power,powerhat);
        benchmarks{i,9} = power;
        benchmarks{i,10} = powerhat;
        dumppred(bmname,power,powerhat);
    end
    prettyprt(benchmarks);
    %prterror(benchmarks);
    

    

