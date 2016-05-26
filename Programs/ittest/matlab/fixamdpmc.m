function fixamdpmc(time, cpu, ht0, ht1, ht2, cmiss)
% fixamdpmc - Deal with data issues with the PMC counters
    ltime = length(time);
    lht0 = length(ht0);
    lht1 = length(ht1);
    lht2 = length(ht2);
    lcmiss = length(cmiss);
    tlength = ltime + lht0 + lht1 + lht2 + lcmiss;
    ltimex5 = 5*ltime;
    if (tlength ~= ltimex5) 
        fprintf('Error: lengths do not match');
    else
        t = time(1);
        h0 = ht0(1);
        h1 = ht1(1);
        h2 = ht2(1);
        miss = [0 0 0 0];
        lastm = miss;
        miss(cpu(1)+1) = cmiss(1);
        lasth0 = h0;
        lasth1 = h1;
        lasth2 = h2;
        count = 1;
        fprintf('time , HT0, HT1, HT2, c1c2missC0,c1c2missC1,c1c2missC2,c1c2missC3\n');
        for sample = 2:ltime
            if t ~= time(sample)
                h0 = h0 / count;
                if (h0 == 0) 
                    h0 = lasth0; 
                end;
                h1 = h1 / count;
                if (h1 == 0) 
                    h1 = lasth1; 
                end;
                h2 = h2 / count;
                if (h2 == 0) 
                    h2 = lasth2; 
                end;
                miss = miss ./ count;
                for proc = 1: 4
                    if miss(proc) == 0
                        miss(proc) = lastm(proc);
                    end;
                end;
                fprintf('%d , %d , %d , %d , %d , %d, %d , %d\n', t, h0, h1, h2, ...
                        miss);
                lasth0 = h0;
                lasth1 = h1;
                lasth2 = h2;
                lastm = miss;
                % fprintf('DBG-A--> %d %d %d %d %d %d %d\n\n',lasth0,lasth1,lasth2,miss);
                h0 = 0;
                h1 = 0;
                h2 = 0;
                count = 0;
                miss = [0 0 0 0];
            end;
            t = time(sample);
            h0 = h0 + ht0(sample);
            h1 = h1 + ht1(sample);
            h2 = h2 + ht2(sample);
            miss(cpu(sample)+1) = miss(cpu(sample)+1) + cmiss(sample);
            count = count + 1;
        end;
    end
    
    

    
    
    
