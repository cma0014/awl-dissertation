function acf(data,lag)
% ACF plots the autocovariance function
% acf( data, maxlag )
% maxlag defaults to length(data)/2
% up to a given lag, showing the
% 95 percent confidence intervals for white noise
% Copyright (c) 1996 by D. Kaplan, All Rights Reserved

if nargin < 2
  lag = length(data)/2;
end

foo = xcov(data,'coeff'); % normalized autocovariance
goo = foo( length(data)+ (0:lag) );
plot(0:lag, goo, '+');

% plot out the 95 percent confidence intervals for
% white noise

hold on
x = [0, lag]';
y = [2, 2]'/sqrt(length(data));
plot(x,y,'--',x,-y,'--');
hold off



