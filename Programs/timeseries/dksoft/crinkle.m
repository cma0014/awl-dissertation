function y = crinkle(x)
% crinkle(x)  calculates the "crinkle statistic" on a vector x
% 	<(x_{t-1}-2*x_t+x_{t+1})^4> / < ( x_t^2 ) >^2
%	as proposed by James Theiler
% Copyright (c) 1996 by D. Kaplan, All Rights Reserved

% subtract out the mean 
x = x - mean(x);
x2 = mean(x .* x )^2;

if x2 == 0 
	y = 0;
	return;
end

d2 = 2*x(2:length(x)-1 ,1) - x(1:length(x)-2,1) - x(3:length(x),1);
y = mean(d2 .^ 4)/x2;
