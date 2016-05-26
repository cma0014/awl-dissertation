function [ylow,yident,yhigh] = powertest(x,n)
% calculates Q=<(x_{t+1})^n> normalized by <x^2>^{n/2}
% on a vector 
% Copyright (c) 1996 by D. Kaplan, All Rights Reserved

x2 = mean(x .* x )^(n/2);

if x2 == 0 
	y = 0;
	return;
end

d2 = x(2:length(x),1)  + x(1:length(x)-1,1);
ylow = mean(d2 .^ n)/x2;

d2 = x(2:length(x),1)  - x(1:length(x)-1,1);
yhigh = mean(d2 .^ n)/x2;

yident = mean(x .^ n)/x2;



