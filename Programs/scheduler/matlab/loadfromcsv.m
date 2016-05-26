function [names ule_temps tas_temps ule_rt tas_rt] = loadfromcsv(bm,varargin)
% buildsp - builds the data spreadsheet for a benchmark
    numvarargs = length(varargin);
    optargs = {1};
    if (numvarargs > 0)
        optargs(1:numvarargs) = varargin;
    end
    csvname = strcat(bm,'.csv');
    importcsv(csvname)
    ule_temps = [ ULEcore0 ULEcore1 ULEcore2 ULEcore3];
    ule_rt = ULEruntime;
    tas_temps = [TAScore0 TAScore1 TAScore2 TAScore3]
    tas_rt = TASruntime;
    names = {'Core0' 'Core1' 'Core2' 'Core3' 'Runtime'};
             
     
    
        
    
    
    
    
        
    
    
