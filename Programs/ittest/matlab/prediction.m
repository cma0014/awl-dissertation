%
% File:    prediction.m
% Author:  awl8049
% Revision:$Revision: 1.4 $
%
% Prompt for the name of the CSV file containing the condensed data
% and then do a linear regression of the data.
%
benchmarks={'bzip2.csv' 'b'; ...
            'cactusadm.csv' 'g'; ...
            'gromac.csv' 'c'; ...
            'h264ref.csv' 'm';  ...
            'lbm.csv' 'y';  ...
            'leslie3d.csv' 'g' ; ...
            'omnetpp.csv' 'k' ; ...
            'perlbench.csv' 'b'};


filenamestr = input('Enter file name: ','s');
overall = importcsv2struct(filenamestr);
[bhat yhat stats] = sregressp(overall,0);
[overall.powerhat overall.err] = addest(overall,bhat,'o');

h1 = figure();
hold on;
fprintf(['\nPaired t-test between actual and estimated power per ' ...
         'benchmark\n']);

for i = 1:size(benchmarks)
    fprintf('bm: %s',benchmarks{i,1});
    bmname = benchmarks{i,1};
    bmcolor = benchmarks{i,2};
    data = importcsv2struct(bmname);
    [data.powerhat data.err ] = addest(data,bhat,bmcolor);
    
    [h p ci] = ttest(data.ProcPwr, data.powerhat);
    fprintf(': h = %10.6f p = %10.6f ci = [%10.6f %10.6f]\n',h,p, ...
            ci);
    bm{i}=data;
end
% Now add a plot for the estimate
plot(overall.Time,yhat,'r');
title('Predicted Power vs. Time');
xlabel('Time(s)');
ylabel('Power(watts)');
axis([0 2100 55 85]);
hold off;
for i=1:size(benchmarks)
    h3=figure();
    bmname=benchmarks{i,1};
    data = bm{i};
    boxplot([data.ProcPwr data.powerhat]);
    [fpath,fname,fext]=fileparts(bmname);
    title(fname);
end
% Now build an error table and plot the error per each benchmark
h2=figure();
fprintf('Benchmark\tMean\tMedian\tStd\tVar\tPercentErr\n');
for i = 1:size(benchmarks)
    bmname = benchmarks{i,1};
    bmcolor = benchmarks{i,2};
    data = bm{i};
    bmerror = data.err;
    errstats = [mean(bmerror) ...
            median(bmerror) ...
            std(bmerror) ...
            var(bmerror)];
    pcnterr = mean(bmerror)/mean(data.ProcPwr);

end
prettyprt(benchmarks);
for i=1:size(benchmarks)
    h3=figure();
    bmname = benchmarks{i,1};
    bmcolor = benchmarks{i,2};
    data = bm{i};
    bmerror = data.err;
    errstats = [mean(bmerror) ...
            median(bmerror) ...
            std(bmerror) ...
            var(bmerror)];
    pcnterr = mean(bmerror)/mean(data.ProcPwr);
    plot(data.Time,data.err,'b-');
    axis([0 2100 0 10]);
    [fpath,fname,fext]=fileparts(bmname);
    title(fname);
    ylabel('Abs Error (watts)');
    xlabel('Time(s)');
end    
 
% % Now do the same for CPU 0 temperature
% for i = 1:size(benchmarks)
%     fprintf('bm: %s',benchmarks{i,1});
%     bmname = benchmarks{i,1};
%     bmcolor = benchmarks{i,2};
%     data = importcsv2struct(bmname);
%     [data.tempc0hat data.t0err ] = taddest(data.CPU_0_Temp, data,t0bhat, bmcolor);
    
%     [h p ci] = ttest(data.CPU_0_Temp, data.tempc0hat);
%     fprintf(': h = %10.6f p = %10.6f ci = [%10.6f %10.6f]\n',h,p, ...
%             ci);
%     bm{i}=data;
% end
% % Now add a plot for the estimate
% plot(overall.Time,yhat,'r');
% title('Predicted CPU 0 Temperature vs. Time');
% xlabel('Time(s)');
% ylabel('Temp (deg C)');
% axis([0 2100 55 85]);
% hold off;
% for i=1:size(benchmarks)
%     h3=figure();
%     bmname=benchmarks{i,1};
%     data = bm{i};
%     boxplot([data.CPU_0_Temp data.tempc0hat]);
%     [fpath,fname,fext]=fileparts(bmname);
%     title(fname);
% end
% % Now build an error table and plot the error per each benchmark
% h2=figure();
% fprintf('Benchmark\tMean\tMedian\tStd\tVar\tPercentErr\n');
% for i = 1:size(benchmarks)
%     bmname = benchmarks{i,1};
%     bmcolor = benchmarks{i,2};
%     data = bm{i};
%     bmerror = data.t0err;
%     errstats = [mean(bmerror) ...
%             median(bmerror) ...
%             std(bmerror) ...
%             var(bmerror)];
%     pcnterr = mean(bmerror)/mean(data.CPU_0_Temp);
%     fprintf('%s\t%10.6f\t%10.6f\t%10.6f\t%10.6f\t%10.6f\n',...
%             bmname,...
%             errstats, ...
%             pcnterr);
%     %errh = figure();
%     subplot(4,2,i);
%     plot(data.Time,data.CPU_0_Temp,'b-',data.Time,data.tempc0hat,'g');
%     axis([0 2100 20 60]);
%     [fpath,fname,fext]=fileparts(bmname);
%     title(fname);
%     switch i
%       case {1,5}
%         set(gca,'YTickMode','auto');
%         set(gca,'XTick',[]);
%       case {3}
%         set(gca,'YTickMode','auto');
%         set(gca,'XTick',[]);
%         ylabel('Power(watts)');
%       case {7}
%         set(gca,'XTickMode','auto');
%         set(gca,'YtickMode','auto');
%         xlabel('Time(s)');
%       case {8}
%         set(gca,'XTickMode','auto');
%         set(gca,'Ytick',[]);
%         xlabel('Time(s)');
%       otherwise
%         set(gca,'XTick',[],'YTick',[]);
%     end
%     % text(1600,80,'blue: actual');
%     % text(1600,78,'green: predicted');
% end



