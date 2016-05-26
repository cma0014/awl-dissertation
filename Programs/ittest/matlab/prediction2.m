% prediction2:  MATLAB script for testing benchmarks
    benchmarks = { 'astar' 'b'; ...
                   'gamess' 'g';...
                   'gobmk', 'r'; ...
                   'zeusmp','k'; ...
                   'idle','r'};
    % Create the model
    basisfilename = input('Enter file name: ','s');
    overall = importcsv2struct(basisfilename);
    [bhat yhat stats t0bhat t0yhat t0stats t1bhat t1yhat t1stats] = sregressp(overall,0);
    for i = 1:size(benchmarks)
        bmname = benchmarks{i,1};
        bmcolor = benchmarks{i,2};
        fprintf('bm: %s\n',bmname);
        location = [pwd '/'  bmname '/' bmname];
        [power data] = buildsp(location);
        [powerhat] = data * bhat;
        [benchmarks{i,3} benchmarks{i,4} benchmarks{i,5} benchmarks{i,6} benchmarks{i,7} ...
         benchmarks{i,8} benchmarks{i,11}] =  test1bm(bmname,power,powerhat);
        benchmarks{i,9} = power;
        benchmarks{i,10} = powerhat;
    end
    prettyprt(benchmarks);
    prterror(benchmarks);
    

    

