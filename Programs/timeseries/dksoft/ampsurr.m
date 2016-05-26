function t = ampsurr(x,y,seed)
% ampsurr(x) generates gaussian amplitude-adjusted surrogate data
% ampsurr(x,y) generates amplitude adjusted surrogate data.
% 	x is the data, y is data from a target histogram.
%       x and y should be single column vectors
% ampsurr(x,n,seed) makes surrogates of x, with a specific distribution
%	by n, with (optional) seed s.
%	n == 1  ==> N(0,1)
%	n == 2  ==> Uniform(0,1) --- this is deterministic
%	n == 3  ==> Triangular(0,2)
% Copyright (c) 1996 by D. Kaplan, All Rights Reserved


if nargin < 2 
	y = 1;
end
if nargin < 3 
	seed = sum(100*clock);
end

trans = histxfrm(x,y,seed);
surr = fftsurr(trans,seed);
t = histxfrm(surr,x);




