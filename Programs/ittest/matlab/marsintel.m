function [bhat yhat] = marsintel(varargin)
numvarargs = length(varargin);
if (numvarargs > 3)
    error('iprediction: too many optional arguments');
end
optargs = {0 0 0};
if (numvarargs > 0)
    optargs(1:numvarargs) = varargin;
end
[dophase3 dofigures smooth] = optargs{:};

benchmarks={ ...
    'bzip2' 'b'; ...
    'cactusadm' 'g'; ...
    'gromacs' 'c'; ...
    'lbm' 'y';  ...
    'mcf' 'r'; ...
    'leslie3d' 'g' ; ...
%'omnetpp' 'k' ; ...
    'perlbench' 'b'};
numBenchmarks = size(benchmarks,1);
depvarsize = 18;
%depvarsize = 20;
procPwrTotal = zeros(300,1);
dataTotal = zeros(300,depvarsize);
fprintf('PHASE 1: CONSOLIDATE DATA FROM BENCHMARKS ===>\n');
for i = 1:numBenchmarks
    bmname = benchmarks{i,1};
    bmcolor = benchmarks{i,2};
    if (smooth == 0) 
        [ProcPwr{i} data{i}] = ibuildmodel3(bmname);
    else
        [ProcPwr{i} data{i}] = ibuildmodel3(bmname,smooth,dofigures);
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
    fprintf('bm: %s\t%4d\t%4d\t%4d\t%4d',...
            benchmarks{i,1},...
            ppSize, ...
            dSize,...
            pptSize, ...
            dtSize);
    maxrows = max([ppSize dSize pptSize dtSize]);
    s = 'add to ';
    % Extend ProcPwr{i}
    if (ppSize < maxrows)
        s = [s  'ProcPwr'];
        sizeDiff = maxrows - ppSize;
        ProcPwr{i} = [ ProcPwr{i} ; zeros(abs(sizeDiff),1)];
    end
    % Extend procPwrTotal
    if (pptSize < maxrows)
        s = [s ' ProcPwrTotal'];
        sizeDiff = maxrows - pptSize;
        procPwrTotal = [procPwrTotal ;zeros(abs(sizeDiff),1)];
    end
    % Extend dataTotal
    if (dtSize < maxrows)
        s = [s ' dataTotal'];
        sizeDiff = maxrows - dtSize;
        dataTotal = [ dataTotal ; zeros(abs(sizeDiff),dCols)];    
    end
    % Extend data{i}
    if (dSize < maxrows)
        s = [s ' data'];
        sizeDiff = maxrows - dSize;
        data{i} = [data{i};zeros(abs(sizeDiff),dCols)];
    end
    fprintf(' %s\n',s);
    if (dofigures == 1)
        t = data{i}(:,1);n
        subplot(2,1,2);
        plot(t,ProcPwr{i});
        title('Conditioned data');
        ylabel('power (w)');
        xlabel('time (0.2*s)');
        axis([0 3500 30 90]);
    end
    procPwrTotal = procPwrTotal + ProcPwr{i};
    dataTotal = dataTotal + data{i};
end
overall.ProcPwr = procPwrTotal ./ numBenchmarks;
overall.Data = dataTotal ./ numBenchmarks;
fprintf('\n\nPHASE 2: CREATE REGRESSION MODEL ===>\n');
[model params pwradjust] = marsmodel(overall.Data, overall.ProcPwr);
% Cross check against sel
% Now build an error table and plot the error per each benchmark
fprintf(['\n\nPHASE 3: CHECK MODEL AGAINST BENCHMARKS USED TO CREATE MODEL ' ...
         '===>\n']);
    for i = 1:size(benchmarks)
        bmname = benchmarks{i,1};
        bmcolor = benchmarks{i,2};
        if (smooth == 0) 
            [power data] = ibuildsp3(bmname);
        else
            [power data] = ibuildsp3(bmname,smooth,dofigures);
        end;        
        
        powerhat = marspredict(model, data,pwradjust);
        [benchmarks{i,3} benchmarks{i,4} benchmarks{i,5} benchmarks{i,6} benchmarks{i,7} ...
         benchmarks{i,8} benchmarks{i,11} ] =  test1bm(bmname,power,powerhat);
        benchmarks{i,9} = power;
        benchmarks{i,10} = powerhat;
        dumppred(bmname,power,powerhat,1);
    end
prettyprt(benchmarks);

fprintf('\n\nPHASE 4: TEST MODEL AGAINST OTHER BENCHMARKS ===>\n');
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
        [power data] = ibuildsp3(bmname);
    else
        [power data] = ibuildsp3(bmname,smooth,dofigures);
    end        
    powerhat = marspredict(model,data,pwradjust);

    [testmarks{i,3} testmarks{i,4} testmarks{i,5} testmarks{i,6} testmarks{i,7} ...
     testmarks{i,8} testmarks{i,11}] =  test1bm(bmname,power,powerhat);
    testmarks{i,9} = power;
    testmarks{i,10} = powerhat;
    dumppred(bmname,power,powerhat,1);
end
prettyprt(testmarks);
prterror(testmarks);



