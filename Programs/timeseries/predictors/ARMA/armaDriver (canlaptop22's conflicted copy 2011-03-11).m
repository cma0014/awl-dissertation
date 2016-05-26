function armaDriver(model, data)
close all

benchmarks={ ...
            'overall'      ...
            'nbzip2'       ...
            'nh264ref'     ...
            'nomnetpp'     ...
            'bzip2'        ...
            'cactusadm'    ...
            'gromac'       ...
            'h264ref'      ...
            'lbm'          ...
            'leslie3d'     ...
            'mcf'          ...
            'omnetpp'      ...
            'perlbench'};
numBenchmarks = length(benchmarks);
total = 0;
totalPer = 0;

bmname = benchmarks{1};
[error, pctErr] = armaPredict(model, data.A);
title(bmname);
xlabel('Time'), ylabel('ProcPwr');
total = total + error;
totalPer = totalPer + pctErr;
fprintf('Error For %s: %.5f\n', bmname, error);
fprintf('Percent Error For %s: %.5f\n\n', bmname, pctErr);

bmname = benchmarks{2};
[error, pctErr] = armaPredict(model, data.B);
title(bmname);
xlabel('Time'), ylabel('ProcPwr');
total = total + error;
totalPer = totalPer + pctErr;
fprintf('Error For %s: %.5f\n', bmname, error);
fprintf('Percent Error For %s: %.5f\n\n', bmname, pctErr);

bmname = benchmarks{3};
[error, pctErr] = armaPredict(model, data.C);
title(bmname);
xlabel('Time'), ylabel('ProcPwr');
total = total + error;
totalPer = totalPer + pctErr;
fprintf('Error For %s: %.5f\n', bmname, error);
fprintf('Percent Error For %s: %.5f\n\n', bmname, pctErr);

bmname = benchmarks{4};
[error, pctErr] = armaPredict(model, data.D);
title(bmname);
xlabel('Time'), ylabel('ProcPwr');
total = total + error;
totalPer = totalPer + pctErr;
fprintf('Error For %s: %.5f\n', bmname, error);
fprintf('Percent Error For %s: %.5f\n\n', bmname, pctErr);

bmname = benchmarks{5};
[error, pctErr] = armaPredict(model, data.E);
title(bmname);
xlabel('Time'), ylabel('ProcPwr');
total = total + error;
totalPer = totalPer + pctErr;
fprintf('Error For %s: %.5f\n', bmname, error);
fprintf('Percent Error For %s: %.5f\n\n', bmname, pctErr);

bmname = benchmarks{6};
[error, pctErr] = armaPredict(model, data.F);
title(bmname);
xlabel('Time'), ylabel('ProcPwr');
total = total + error;
totalPer = totalPer + pctErr;
fprintf('Error For %s: %.5f\n', bmname, error);
fprintf('Percent Error For %s: %.5f\n\n', bmname, pctErr);

bmname = benchmarks{7};
[error, pctErr] = armaPredict(model, data.G);
title(bmname);
xlabel('Time'), ylabel('ProcPwr');
total = total + error;
totalPer = totalPer + pctErr;
fprintf('Error For %s: %.5f\n', bmname, error);
fprintf('Percent Error For %s: %.5f\n\n', bmname, pctErr);

bmname = benchmarks{8};
[error, pctErr] = armaPredict(model, data.H);
title(bmname);
xlabel('Time'), ylabel('ProcPwr');
total = total + error;
totalPer = totalPer + pctErr;
fprintf('Error For %s: %.5f\n', bmname, error);
fprintf('Percent Error For %s: %.5f\n\n', bmname, pctErr);

bmname = benchmarks{9};
[error, pctErr] = armaPredict(model, data.I);
title(bmname);
xlabel('Time'), ylabel('ProcPwr');
total = total + error;
totalPer = totalPer + pctErr;
fprintf('Error For %s: %.5f\n', bmname, error);
fprintf('Percent Error For %s: %.5f\n\n', bmname, pctErr);

bmname = benchmarks{10};
[error, pctErr] = armaPredict(model, data.J);
title(bmname);
xlabel('Time'), ylabel('ProcPwr');
total = total + error;
totalPer = totalPer + pctErr;
fprintf('Error For %s: %.5f\n', bmname, error);
fprintf('Percent Error For %s: %.5f\n\n', bmname, pctErr);

bmname = benchmarks{11};
[error, pctErr] = armaPredict(model, data.K);
title(bmname);
xlabel('Time'), ylabel('ProcPwr');
total = total + error;
totalPer = totalPer + pctErr;
fprintf('Error For %s: %.5f\n', bmname, error);
fprintf('Percent Error For %s: %.5f\n\n', bmname, pctErr);

bmname = benchmarks{12};
[error, pctErr] = armaPredict(model, data.L);
title(bmname);
xlabel('Time'), ylabel('ProcPwr');
total = total + error;
totalPer = totalPer + pctErr;
fprintf('Error For %s: %.5f\n', bmname, error);
fprintf('Percent Error For %s: %.5f\n\n', bmname, pctErr);

bmname = benchmarks{13};
[error, pctErr] = armaPredict(model, data.M);
title(bmname);
xlabel('Time'), ylabel('ProcPwr');
total = total + error;
totalPer = totalPer + pctErr;
fprintf('Error For %s: %.5f\n', bmname, error);
fprintf('Percent Error For %s: %.5f\n\n', bmname, pctErr);

fprintf('Average Error: %.5f\n', total/numBenchmarks);
fprintf('Average Percent Error: %.5f\n', totalPer/numBenchmarks);
end