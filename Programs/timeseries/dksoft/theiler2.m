function y = theilerQ(x)
% theilerQ calculates Q=<(x_t + x_{t+1})^3> normalized by <x^2>^{3/2}
% on a vector 
% Copyright (c) 1996 by D. Kaplan, All Rights Reserved

x2 = mean(x .* x )^(3/2);

if x2 == 0 
	y = 0;
	return;
end

d2 = x(2:length(x),1) + x(1:length(x)-1,1);
y = mean(d2 .^ 3)/x2;


