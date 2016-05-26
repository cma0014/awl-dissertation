
function [ProcPwr data] = ibuildmodel(bm,varargin)
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
        [pmctimes bustran l2miss fsb0 fsb1 l2_miss0 l2_miss1] = intelpmcestimate(pmcfile);
    else
        [pmctimes bustran l2miss fsb0 fsb1 l2_miss0 l2_miss1] = intelpmcestimate(pmcfile,5,smooth);
    end
    %    pmc = [pmctimes bustran l2miss];
    pmc = [pmctimes fsb0 fsb1 l2_miss0 l2_miss1];
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
    temps = [Time Temp0 Temp1 Planar_Temp VRD_0_Temp VRD_1_Temp];
    %fans = [Time Fan_1 Fan_2A Fan_3A Fan_4A Fan_5A ];
    fans = [Time Fan_1 Fan_2A Fan_2B Fan_3A Fan_3B Fan_4A Fan_4B Fan_5A Fan_5B];

    data = joinmat(temps,pmc,'full outer');
    data = nantozero(data);
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
    data = joinmat(data,diskio, 'full outer');
    data = nantozero(data);
    data = joinmat(data,fans,'full outer');
    data = nantozero(data);
    data = data(:,2:size(data,2));
    
        
    
    
    
    
        
    
    
