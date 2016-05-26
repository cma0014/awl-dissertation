function armaDriver(model)
close all
total = 0;
totalPer = 0;

bench = {   'data/astar.xls', ...
            'data/gamess.xls', ...
            'data/gobmk.xls', ...
            'data/zeusmp.xls'};
bench2 = {  'overall.csv', ...
            'nbzip2.csv', ...
            'nh264ref.csv', ...
            'nomnetpp.csv', ...
            'bzip2.csv', ...
            'cactusadm.csv', ...
            'gromac.csv', ...
            'h264ref.csv', ...
            'lbm.csv', ...
            'leslie3d.csv', ...
            'mcf.csv', ...
            'omnetpp.csv', ...
            'perlbench.csv'};
        
for i=1:length(bench)
    [data hdr] = xlsread(bench{i}, '');
    data = getProcPwr(data, hdr);
    figure(i)
    [error, pctErr] = armaPredict(model, data);
    title(bench{i});
    xlabel('Time'), ylabel('ProcPwr');
    total = total + error;
    totalPer = totalPer + pctErr;
    %fprintf('Error For %s: %.5f\n', bench{i}, error);
    %fprintf('Percent Error For %s: %.5f\n\n', bench{i}, pctErr);
end

%for i=1:length(bench2)
%    [data hdr] = xlsread('data/overall.xls', bench2{i});
%    data = getProcPwr(data, hdr);
%    figure(i+length(bench))
%    [error, pctErr] = armaPredict(model, data);
%    title(bench2{i});
%    xlabel('Time'), ylabel('ProcPwr');
%    total = total + error;
%    totalPer = totalPer + pctErr;
%    %fprintf('Error For %s: %.5f\n', bench2{i}, error);
%    %fprintf('Percent Error For %s: %.5f\n\n', bench2{i}, pctErr);
%end

fprintf('Average Error: %.5f\n', total/(length(bench)+length(bench2)));
fprintf('Average Percent Error: %.5f\n', totalPer/(length(bench)+length(bench2)));
end