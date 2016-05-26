function t = histxform(x,y,seed)
% histxform(x,y) transforms x so that it has the same histogram as y
%       while maintaining the order of the ranks in x
%       x and y should be single column vectors
% histxform(x,n,s) transforms x to have a histogram of the type specified
%	by n, with (optional) seed s.
%	n == 1  ==> N(0,1)
%	n == 2  ==> Uniform(0,1) --- this is deterministic
%	n == 3  ==> Triangular(0,2)
% Copyright (c) 1996 by D. Kaplan, All Rights Reserved

% Make sure there are some contents
if any([ length(x) == 0 , length(y) == 0 ])
	t = NaN;
	error('Empty time series given to histxform')
end

% see if we want a to specify a specific distribution
if any([length(y) == 1,nargin==3])
	if nargin==3
		randn('seed', seed);
		rand('seed', seed);
	else
		randn('seed', sum(100*clock));
		rand('seed', sum(100*clock));
	end
	if y == 1
		y = randn(size(x));
	elseif y == 2
		y = 0:1/length(x):1;
	elseif y == 3 
		y = rand(size(x)) + rand(size(x));
	end
end

% convert everything to column vectors
[xr,xc] = size(x);
[yr,yc] = size(y);
if yr == 1
	y = y';
end
if xr == 1
	x = x';
end

% make sure that y is long enough
while length(x) > length(y) 
	y = [y;y];
end

% Here's the meat of the algorithm
% sort x into ascending order
[z,zi] = sort(x);
% same with y
ys = sort(y(1:length(x)));
% ii will find the original indices in x of each point in sorted x
[z,ii] = sort(zi);
% x would be z(ii), but we want the values from ys so
t = ys(ii);

% if the original was a single row, return a single row
if( xr == 1 )
	t = t';
end