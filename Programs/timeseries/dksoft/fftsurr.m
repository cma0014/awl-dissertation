function y = fftsurrogate(x, seed)
% fftsurrogate calculates phase randomized surrogate data from a time series x
% fftsurrogate(x,seed) uses the specified seed
% Copyright (c) 1996 by D. Kaplan, All Rights Reserved

if nargin == 1
	rand('seed', sum(100*clock) );
	randn('seed', sum(100*clock) );
end

% Convert x to a column 
[xr,xc] = size(x);
if xr == 1
	x = x';
end



% take the fft
z = fft(x);
% randomize the phases
ph = 2*pi*rand(length(z)/2 - 1, 1);
if rem(length(z),2) == 0 
	ph = [ 0; ph; 0; -flipud(ph) ];
else
	ph = [ 0; ph; -flipud(ph) ];
end
z = z .* exp(j*ph);
y = real(ifft(z));

