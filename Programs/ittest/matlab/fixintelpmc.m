function fixintelpmc(time, cpu, ht0, cmiss)
% fixamdpmc - Deal with data issues with the PMC counters
    ltime = length(time);
    t = time(1);
    h0 = ht0(1);
    miss = [0 0];
    lastm = miss;
    miss(cpu(1)+1) = cmiss(1);
    lasth0 = h0;
    count = 1;
    fprintf('time , FSB, c1c2missC0,c1c2missC1\n');
    for sample = 2:ltime
        if t ~= time(sample)
            h0 = h0 / count;
            if (h0 == 0) 
                h0 = lasth0; 
            end;
            miss = miss ./ count;
            for proc = 1: 2
                if miss(proc) == 0
                    miss(proc) = lastm(proc);
                end;
            end;
            fprintf('%d , %d , %d , %d \n', t, h0, miss);
            lasth0 = h0;
            lastm = miss;
            h0 = 0;
            miss = [0 0];
        end;
        t = time(sample);
        h0 = h0 + ht0(sample);
        miss(cpu(sample)+1) = miss(cpu(sample)+1) + cmiss(sample);
        count = count + 1;
    end;
    
    

    
    
    
