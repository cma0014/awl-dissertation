function mregressall
%MREGRESSALL
Y = {};
X = {};
files = dir('*.csv');
for i = 1:size(files)
    fprintf('Importing: %s\n',files(i).name);
    importcsv(files(i).name);
    Y{i} = ProcPwr;
    x1 = Ambient_Temp0;
    x2 = Ambient_Temp1;
    x3 = CPU_0_Temp;
    x4 = CPU_1_Temp;
    x6 = HT1Scaled;
    x7 = HT2Scaled;
    x8 = cmiss_core0_scaled;
    x9 = cmiss_core1_scaled;
    x10 = cmiss_core2_scaled;
    x11 = cmiss_core3_scaled;
    
    X{i} = [ x1 x2 x3 x4 x6 x7 x8 x9 x10 x11]';
end;
[b,sigma, resid,covb] = mvregress(X,Y);
