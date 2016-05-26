function aresdriver(data)
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
        
% Pre-Scale data to [0,1]
data.A = data.A./max(data.A);
%data.B = data.B./max(data.B);
%data.C = data.C./max(data.C);
%data.D = data.D./max(data.D);
%data.E = data.E./max(data.E);
%data.F = data.F./max(data.F);
%data.G = data.G./max(data.G);
%data.H = data.H./max(data.H);
%data.I = data.I./max(data.I);
%data.J = data.J./max(data.J);
%data.K = data.K./max(data.K);
%data.L = data.L./max(data.L);
%data.M = data.M./max(data.M);

numBenchmarks = length(benchmarks);
total = 0;

% Generate Model using MARS Technique
params = aresparams(41, 10, true, [], [], 15);
model = aresbuild((1:413)'./413, data.A, params);

bmname = benchmarks{1};
error = MARSpredict(model, data.A);
title(bmname), xlabel('Time'), ylabel('ProcPwr');
total = total + error;
fprintf('Error For %s: %.5f\n', bmname, error);

bmname = benchmarks{2};
error = MARSpredict(model, data.B);
title(bmname), xlabel('Time'), ylabel('ProcPwr');
total = total + error;
fprintf('Error For %s: %.5f\n', bmname, error);

bmname = benchmarks{3};
error = MARSpredict(model, data.C);
title(bmname), xlabel('Time'), ylabel('ProcPwr');
total = total + error;
fprintf('Error For %s: %.5f\n', bmname, error);

bmname = benchmarks{4};
error = MARSpredict(model, data.D);
title(bmname), xlabel('Time'), ylabel('ProcPwr');
total = total + error;
fprintf('Error For %s: %.5f\n', bmname, error);

bmname = benchmarks{5};
error = MARSpredict(model, data.E);
title(bmname), xlabel('Time'), ylabel('ProcPwr');
total = total + error;
fprintf('Error For %s: %.5f\n', bmname, error);

bmname = benchmarks{6};
error = MARSpredict(model, data.F);
title(bmname), xlabel('Time'), ylabel('ProcPwr');
total = total + error;
fprintf('Error For %s: %.5f\n', bmname, error);

bmname = benchmarks{7};
error = MARSpredict(model, data.G);
title(bmname), xlabel('Time'), ylabel('ProcPwr');
total = total + error;
fprintf('Error For %s: %.5f\n', bmname, error);

bmname = benchmarks{8};
error = MARSpredict(model, data.H);
title(bmname), xlabel('Time'), ylabel('ProcPwr');
total = total + error;
fprintf('Error For %s: %.5f\n', bmname, error);

bmname = benchmarks{9};
error = MARSpredict(model, data.I);
title(bmname), xlabel('Time'), ylabel('ProcPwr');
total = total + error;
fprintf('Error For %s: %.5f\n', bmname, error);

bmname = benchmarks{10};
error = MARSpredict(model, data.J);
title(bmname), xlabel('Time'), ylabel('ProcPwr');
total = total + error;
fprintf('Error For %s: %.5f\n', bmname, error);

bmname = benchmarks{11};
error = MARSpredict(model, data.K);
title(bmname), xlabel('Time'), ylabel('ProcPwr');
total = total + error;
fprintf('Error For %s: %.5f\n', bmname, error);

bmname = benchmarks{12};
error = MARSpredict(model, data.L);
title(bmname), xlabel('Time'), ylabel('ProcPwr');
total = total + error;
fprintf('Error For %s: %.5f\n', bmname, error);

bmname = benchmarks{13};
error = MARSpredict(model, data.M);
title(bmname), xlabel('Time'), ylabel('ProcPwr');
total = total + error;
fprintf('Error For %s: %.5f\n', bmname, error);

fprintf('Average Error: %.5f\n', total/numBenchmarks);
[MSE, RMSE, RRMSE, R2] = arestest(model,(1:413)',data.M)
end