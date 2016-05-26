function rs = arresid(data,armod)
% ARRESID(data,armod) calculates the residuals of data
% from the specified AR model "armod" produced in the 
% format from lpc().  Returns the residuals.
% Copyright (c) 1996 by D. Kaplan, All Rights Reserved

p = length(armod)-1;
tmp = -armod(2:length(armod));
goo = filter(tmp,1,data);
hoo = data((2):length(data)) - goo((1):(length(data)-1));
rs = hoo(p:length(hoo));

