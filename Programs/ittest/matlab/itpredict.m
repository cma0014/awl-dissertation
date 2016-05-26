function [bhat yhat] = itpredict(varargin)
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

procPwrTotal = zeros(300,1);
t0dataTotal = zeros(300,1);
t1dataTotal = zeros(300,1);
for i = 1:numBenchmarks
    fprintf('bm: %s\n',benchmarks{i,1});
    bmname = benchmarks{i,1};
    bmcolor = benchmarks{i,2};
    if (smooth == 0) 
        [ProcPwr{i} t0{i} t0data{i} t1{i} t1data{i}] = itbldmodel(bmname);
    else
        [ProcPwr{i} t0{i} t0data{i} t1{i} t1data{i}] = ...
            itbldmodel(bmname,smooth,dofigures);
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
    t0size = size(t0{i},1);
    t1size = size(t1{i},1);
    t0dsize = size(t0data{i},1);
    t0dcols = size(t0data{i},2);
    t1dsize = size(t1data{i},1);
    t1dcols = size(t1data{i},2);
    maxrows = max([ppSize dSize pptSize dtSize t0size t0dsize t1size t1dsize]);
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
    if (t0size < maxrows)
        sizeDiff = maxrows - t0size;
        t0{i} = [t0{i}; zeros(abs(sizeDiff),1)];
    end
    if (t0dstize < maxrows)
        sizeDiff = maxrows - t0size;
        t0data{i} = [t0data{i}; zeros(abs(sizeDiff),t0dcols)];
    end
    if (t1size < maxrows)
        sizeDiff = maxrows - t1size;
        t1{i} = [t1{i}; zeros(abs(sizeDiff),1)];
    end
    if (t1dstize < maxrows)
        sizeDiff = maxrows - t1size;
        t1data{i} = [t1data{i}; zeros(abs(sizeDiff),t1dcols)];
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
    procPwrTotal = procPwrTotal + ProcPwr{i};
    dataTotal = dataTotal + data{i};
    t0total = t0total + t0{i};
    t0datatotal = t0datatotal + t0data{i};
    t1total = t1total + t1{i};
    t1datatotal = t1datatotal + t1data{i};
end
overall.t0 = t0total ./ numBenchmarks ;
overall.t0Data = t0datatotal ./ numBenchmarks;
[t0bhat t0yhat] = dregressp(overall.t0,overall.t0Data,0);
overall.t1 = t1total ./ numBenchmarks ;
overall.t1Data = t1datatotal ./ numBenchmarks;
[t1bhat t1yhat] = dregressp(overall.t1,overall.t1Data,0);
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
    [power data] = ibuildsp(bmname);
    [powerhat] = data * bhat;

    [testmarks{i,3} testmarks{i,4} testmarks{i,5} testmarks{i,6} testmarks{i,7} ...
     testmarks{i,8}] =  test1bm(bmname,power,powerhat);
    testmarks{i,9} = power;
    testmarks{i,10} = powerhat;
end
prettyprt(testmarks);



