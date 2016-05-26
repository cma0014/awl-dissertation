function [benchmarks testmarks] = polypredict(arch)
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
    benchmarks={'bzip2' 'b'; ...
            'cactusadm' 'g'; ...
            'gromacs' 'c'; ...
    %'h264ref' 'm';  ...
            'lbm' 'y';  ...
            'leslie3d' 'g' ; ...
    %'omnetpp' 'k' ; ...
            'perlbench' 'b'...
               };
    % Create the model
    dointel = strcmp(arch,'intel');
    if (dointel == true)
        depvarsize = 18;
    else
        depvarsize = 16;
    end
    smooth = 0;
    dofigures = 0;
    withinter = 0;
    numBenchmarks = size(benchmarks,1);
    procPwrTotal = zeros(300,1);
    dataTotal = zeros(300,depvarsize);
    counts = zeros(300,1);
    fprintf('PHASE 1: CONSOLIDATE DATA FROM BENCHMARKS ===>\n');
    for i = 1:numBenchmarks
        bmname = benchmarks{i,1};
        bmcolor = benchmarks{i,2};
        if (dointel == 1)
            [ProcPwr{i} data{i}] = ibuildmodel3(bmname);
        else
            [ProcPwr{i} data{i}] = buildspfromcsv(bmname,0);
        end;
        if (dofigures == 1)
            h = figure;
            title('Raw power data');
            t = 5*(1:length(ProcPwr{i}));
            plot(t,ProcPwr{i});
            axis([0 max(t) 30 90]);
            xlabel('Time(s)');
            ylabel('Power(w)');
        end
        ppSize = size(ProcPwr{i}, 1);
        dSize = size(data{i},1);
        pptSize = size(procPwrTotal,1);
        dtSize = size(dataTotal,1);
        dCols = size(data{i},2);
        countSize = length(counts);
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
        % Extend counts
        if (countSize < maxrows)
            s = [s ' and counts'];
            sizeDiff = maxrows - countSize;
            counts = [counts;zeros(abs(sizeDiff),1)];
        end;
        fprintf(' %s\n',s);
        procPwrTotal = procPwrTotal + ProcPwr{i};
        dataTotal = dataTotal + data{i};
        counts = counts + 1;
    end
    for i= 1:length(counts)
        if counts(i) == 0
            overall.ProcPwr(i) = 0;
            overall.Data(i,:) = 0;
        else
            overall.ProcPwr(i) = procPwrTotal(i)./counts(i);
            overall.Data(i,:) = dataTotal(i,:) ./counts(i);
        end;
    end;
    % Regression stuff goes here eventually
    overallLen = length(overall.ProcPwr);
    overallTS = 1:overallLen;
    hx=median(abs(overallTS-median(overallTS)))/0.6745*(4/3/overallLen)^0.2;
    hy=median(abs(overall.ProcPwr-median(overall.ProcPwr)))/0.6745*(4/3/overallLen)^0.2;
    h=sqrt(hy*hx);
    overallKSR = ksrlin(overallTS,overall.ProcPwr,h,overallLen);
    fprintf('\n\nPHASE 2: Check model against benchmarks used.\n');
    for i = 1:size(benchmarks)
        bmname = benchmarks{i,1};
        bmcolor = benchmarks{i,2};
        if (dointel == true)
            [power data] = ibuildsp3(bmname);
        else
            [power data] = buildspfromcsv(bmname);
        end;
        powlen = length(power);
        pts = 5*(1:powlen);
        hx=median(abs(pts-median(pts)))/0.6745*(4/3/powlen)^0.2;
        hy=median(abs(power-median(power)))/0.6745*(4/3/powlen)^0.2;
        h=sqrt(hy*hx);
        
        r = ksrlin(pts, power, h, powlen);
        powerhat = transpose(r.f);
        [benchmarks{i,3} benchmarks{i,4} benchmarks{i,5} benchmarks{i,6} benchmarks{i,7} ...
         benchmarks{i,8} benchmarks{i,11}] =  testcbm(bmname,power,powerhat);
        benchmarks{i,9} = power;
        benchmarks{i,10} = powerhat;
        dumppred(bmname,power,powerhat);
        hurst = hurst_estimate(power,'absval',0,1);
        fprintf('bm: %s hurst parameter = %6.5d \n',bmname, hurst);
    end
    %prettyprt(benchmarks);
    prterror(benchmarks);
    
    testmarks = { 'astar' 'b'; ...
                   'gamess' 'g';...
    %'calculix' 'g';...
                   'gobmk', 'r'; ...
                   'zeusmp','k'; ...
    %'idle1','r'...
                 };
    for i = 1:size(testmarks)
        bmname = testmarks{i,1};
        bmcolor = testmarks{i,2};
        fprintf('bm: %s',bmname);
        if (dointel == true)
            [power data] = ibuildsp3(bmname);
        else
            location = [pwd '/'  bmname '/' bmname];
            [power data] = buildspfromcsv(location);
        end
        hurst = hurst_estimate(power,'absval',0,1);
        fprintf(' Hurst parameters = %6.5d \n',hurst);
        powlen = length(power);
        pts = 5*(1:powlen);
        hx=median(abs(pts-median(pts)))/0.6745*(4/3/powlen)^0.2;
        hy=median(abs(power-median(power)))/0.6745*(4/3/powlen)^0.2;
        h=sqrt(hy*hx);
        r = ksrlin(pts,power,h,powlen);
        powerhat = transpose(r.f);
        [testmarks{i,3} testmarks{i,4} testmarks{i,5} testmarks{i,6} testmarks{i,7} ...
         testmarks{i,8} testmarks{i,11}] =  testcbm(bmname,power,powerhat);
        testmarks{i,9} = power;
        testmarks{i,10} = powerhat;
        dumppred(bmname,power,powerhat);
    end
    prettyprt(testmarks);
    prterror(testmarks);
    
    

    

