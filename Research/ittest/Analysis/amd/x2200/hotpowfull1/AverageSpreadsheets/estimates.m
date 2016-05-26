function yhat=estimates(b,struct)
    x0 = ones(size(struct.Ambient_Temp0));
    x1 = struct.Ambient_Temp0;
    x2 = struct.Ambient_Temp1;
    x3 = struct.CPU_0_Temp;
    x4 = struct.CPU_1_Temp;
    x6 = struct.HT1Scaled;
    x7 = struct.HT2Scaled;
    x8 = struct.cmiss_core0_scaled;
    x9 = struct.cmiss_core1_scaled;
    x10 = struct.cmiss_core2_scaled;
    x11 = struct.cmiss_core3_scaled;

    X = [ x0 x1 x2 x3 x4 x6 x7 x8 x9 x10 x11]; 
    yhat = X*b;
    