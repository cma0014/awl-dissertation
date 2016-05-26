function [ProcPwr t0 t0data t1 t1data] = itbldmodel(bm,varargin)
% buildsp - builds the data spreadsheet for a benchmark
    numvarargs = length(varargin);
    if (numvarargs > 2)
        error('ibuildmodel: too many optional arguments');
    end
    optargs = {0 0};
    if (numvarargs > 0)
        optargs(1:numvarargs) = varargin;
    end
    [smooth dofigures] = optargs{:};
    bm = [bm '/' bm];
    pmcfile = strcat(bm,'.pmc.csv');
    if (smooth == 0)
        [pmctimes bustran l2miss] = intelpmcestimate(pmcfile);
    else
        [pmctimes bustran l2miss] = intelpmcestimate(pmcfile,5,smooth);
    end
    pmc = [pmctimes bustran l2miss];
    if (dofigures == 1)
        h = figure;
        subplot(2,1,1);
        plot(bustran);
        title(bm);
        xlabel('Time (0.2*s)');
        ylabel('No. Xacts');
        subplot(2,1,2);
        plot(l2miss);
        xlabel('Time (0.2*s)');
        ylabel('No. Last-level Misses');
    end
    impifile = strcat(bm,'.ipmi.txt');
    importcsv(impifile);
    t0 = Temp0
    t0temps = [Time Time1 Planar_Temp VRD_0_Temp VRD_1_Temp];
    t1 = Temp1
    t1temps = [Time Temp0 Planar_Temp VRD_0_Temp VRD_1_Temp];
    %fans = [Time Fan_1 Fan_2A Fan_3A Fan_4A Fan_5A ];
    fans = [Time Fan_1 Fan_2A Fan_2B Fan_3A Fan_3B Fan_4A Fan_4B Fan_5A Fan_5B];

    data = joinmat(temps,pmc,'full outer');
    t0data = joinmat(t0temps,pmc,'full outer');
    t0data = nantozero(t0data);
    t1data = joinmat(t1temps,pmc,'full outer');
    t1data = naxtozero(t1data);

    powerfile = strcat(bm,'.powerdata.txt');
    % Setup the regression variables.
    praw = importdata(powerfile);
    actualW = 0.1*praw.data(:,3);
    InputDCpwr = actualW*0.8;
    AllPwrExtBd = InputDCpwr * 0.75;
    ProcPwr = 0.5*AllPwrExtBd;
    p = [praw.data(:,2)*5 praw.data(:,3:5) InputDCpwr AllPwrExtBd ProcPwr];
    %data = joinmat(data,p,'inner');
    % get disk read/write data
    % assume data file generated from bm.iostat.log using the shell 
    % command:
    % (head -n 2 bm.iostat.log ; grep sd0 bm.iostat.log) > bm.iostat.sd0
    %
    sd0file = strcat(bm,'.iostat.cmdk0');
    draw = importdata(sd0file);
    drawsize = size(draw.data,1)-1;
    dioint = 0:drawsize;
    dioint = dioint * 5;
    dioint = dioint';
    disk_read_kbytes = draw.data(:,4) * 5;
    disk_write_kbytes = draw.data(:,5) * 5;

    diskio = [dioint disk_read_kbytes disk_write_kbytes];
    t0data = joinmat(t0data,diskio, 'full outer');
    t0data = nantozero(t0data);
    t0data = joinmat(t0data,fans,'full outer');
    t0data = nantozero(t0data);
    
    t1data = joinmat(t1data,diskio, 'full outer');
    t1data = nantozero(t1data);
    t1data = joinmat(t1data,fans,'full outer');
    t1data = nantozero(t1data);
    
        
    
    
    
    
        
    
    
