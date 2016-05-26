function [benchmarks testmarks overall] = evpmovintel(alpha)
% expmovamd: use exp. weighted moving average for power prediction
    close all;
    testmarks = { 'astar' 'b'; ...
                   'gamess' 'g';...
    %                   'calculix' 'g';...
                   'gobmk', 'r'; ...
                   'zeusmp','k'; ...
                 };
    for i = 1:size(testmarks)
        bmname = testmarks{i,1};
        bmcolor = testmarks{i,2};
        fprintf('bm: %s\n',bmname);
        [power data] = ibuildsp3(bmname);
        [powerhat] = filter(1-alpha,[1,-alpha],power);
        [testmarks{i,3} testmarks{i,4} testmarks{i,5} testmarks{i,6} testmarks{i,7} ...
         testmarks{i,8} testmarks{i,11}] =  test1bm(bmname,power,powerhat);
        testmarks{i,9} = power;
        testmarks{i,10} = powerhat;
        dumppred(bmname,power,powerhat,1);
    end
    %    prettyprt(testmarks);
    prterror(testmarks);
    
    

    

