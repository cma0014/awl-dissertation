function [TIMESf HT0_AV HT1_AV HT2_AV c1c2missC0 c1c2missC1 c1c2missC2 c1c2missC3] =  pmcestimate(filename,varargin)
% pmcestimate - Deal with data issues with the PMC counters
    optargs = size(varargin,1);
    if optargs > 0
        sinterval = varargin{1}
    else
        sinterval = 5;
    end
    importcsv(filename);
    a = [time cpu HT0 HT1 HT2 L2miss];
    numsamples = round(max(time) / sinterval);
    TIMES = zeros(1,numsamples);
    HT0_ALL = zeros(4,numsamples);
    HT1_ALL = zeros(4,numsamples);
    HT2_ALL = zeros(4,numsamples);
    L2_MISS = zeros(4,numsamples);
    for i=1:length(time)
        slot = round(time(i) / sinterval);
        cput = cpu(i)+1;
        TIMES(slot) = time(i);
        HT0_ALL(cput,slot) = HT0(i);
        HT1_ALL(cput,slot) = HT1(i);
        HT2_ALL(cput,slot) = HT2(i);
        L2_MISS(cput,slot) = L2miss(i);
    end
    TIMESf = TIMES';
    HT0_AV = mean(HT0_ALL)';
    HT1_AV = mean(HT1_ALL)';
    HT2_AV = mean(HT2_ALL)';
    HT0_AV = HT0_AV ./ 1e6;
    HT1_AV = HT1_AV ./ 1e6;
    HT2_AV = HT2_AV ./ 1e6;
    c1c2missC0 = L2_MISS(1,:)';
    c1c2missC1 = L2_MISS(2,:)';
    c1c2missC2 = L2_MISS(3,:)';
    c1c2missC3 = L2_MISS(4,:)';
    c1c2missC0 = c1c2missC0 ./ 1e5;
    c1c2missC1 = c1c2missC1 ./ 1e5;
    c1c2missC2 = c1c2missC2 ./ 1e5;
    c1c2missC3 = c1c2missC3 ./ 1e5;
    

    
    
    
