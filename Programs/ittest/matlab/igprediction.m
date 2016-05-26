function [bhat yhat] = iprediction(varargin)
numvarargs = length(varargin);
if (numvarargs > 2)
    error('iprediction: too many optional arguments');
end
optargs = {0 0};
if (numvarargs > 0)
    optargs(1:numvarargs) = varargin;
end
[dofigures smooth] = optargs{:};
 
benchmarks={ ...
            'bzip2' 'b'; ...
            'cactusadm' 'g'; ...
            'gromacs' 'c'; ...
            'lbm' 'y';  ...
            'mcf' 'r'; ...
            'leslie3d' 'g' ; ...
            'omnetpp' 'k' ; ...
            'perlbench' 'b'};
numBenchmarks = size(benchmarks,1);

procPwrTotal = ones(300,1);
dataTotal = ones(300,19);
for i = 1:numBenchmarks
    fprintf('bm: %s\n',benchmarks{i,1});
    bmname = benchmarks{i,1};
    bmcolor = benchmarks{i,2};
    if (smooth == 0) 
        [ProcPwr{i} data{i}] = ibuildmodel(bmname);
    else
        [ProcPwr{i} data{i}] = ibuildmodel(bmname,smooth,dofigures);
    end        
    % OK, this is MATLAB weirdness required to get array sizes to
    % work in somthing approximating sanity.  See who is larger and
    % reshape accordingly.
    if (dofigures == 1)
        h = figure;
        subplot(2,1,1);
        title('Raw power data');
        t = 5*size(ProcPwr{i},1);
        plot(ProcPwr{i});
        axis([0 650 30 90]);
        xlabel('Time(s)');
        ylabel('Power(w)');
    end
    ppSize = size(ProcPwr{i}, 1);
    dSize = size(data{i},1);
    pptSize = size(procPwrTotal,1);
    dtSize = size(dataTotal,1);
    dCols = size(data{i},2);
    maxrows = max([ppSize dSize pptSize dtSize]);
    % Extend ProcPwr{i}
    if (ppSize < maxrows)
        sizeDiff = maxrows - ppSize;
        ProcPwr{i} = [ ProcPwr{i} ; zeros(abs(sizeDiff),1)];
    end
    % Extend procPwrTotal
    if (pptSize < maxrows)
       sizeDiff = maxrows - pptSize;
       procPwrTotal = [procPwrTotal ;zeros(abs(sizeDiff),1)];
    end
    % Extend dataTotal
    if (dtSize < maxrows)
        sizeDiff = maxrows - dtSize;
        dataTotal = [ dataTotal ; zeros(abs(sizeDiff),dCols)];    
    end
    % Extend data{i}
    if (dSize < maxrows)
        sizeDiff = maxrows - dSize;
        data{i} = [data{i};zeros(abs(sizeDiff),dCols)];
    end
    if (dofigures == 1)
        t = data{i}(:,1);
        subplot(2,1,2);
        plot(t,ProcPwr{i});
        title('Conditioned data');
        ylabel('power (w)');
        xlabel('time (0.2*s)');
        axis([0 3500 30 90]);
    end
    procPwrTotal = procPwrTotal .* ProcPwr{i};
    dataTotal = dataTotal .* data{i};
    csvname = [bmname '.analysis.csv'];
    csvdata = [ProcPwr{i} data{i}];
    csvwrite(csvname,csvdata);
end
overall.ProcPwr = procPwrTotal .^ (1/numBenchmarks);
overall.Data = dataTotal .^ (1/ numBenchmarks);
csvname = 'overall.analysis.csv';
csvdata = [overall.ProcPwr overall.Data];
csvwrite(csvname,csvdata);
[bhat yhat] = dregressp(overall.ProcPwr,overall.Data,0);
% Now we do the comparison
testmarks = { 'idle2', 'y';...
              'astar', 'b'; ...
              'gamess', 'g';...
              'gobmk', 'r'; ...
              'povray','b'; ...
              'zeusmp','k'};
% Create the model
fprintf('Testing model against benchmarks');
for i = 1:size(testmarks)
    bmname = testmarks{i,1};
    bmcolor = testmarks{i,2};
    fprintf('bm: %s\n',bmname);
    if (smooth == 0) 
        [power data] = ibuildsp(bmname);
    else
        [power data] = ibuildsp(bmname,smooth,dofigures);
    end        
    [powerhat] = data * bhat;

    [testmarks{i,3} testmarks{i,4} testmarks{i,5} testmarks{i,6} testmarks{i,7} ...
     testmarks{i,8}] =  test1bm(bmname,power,powerhat);
    testmarks{i,9} = power;
    testmarks{i,10} = powerhat;
end
prettyprt(testmarks);



