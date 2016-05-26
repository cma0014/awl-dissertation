function scatter(data,tau,symbol)
% SCATTER makes a scatter plot of x(t+tau) versus x(t)
%    scatter(data,tau,symbol) 
%    scatter(data) uses tau=1, symbol='.'
%    scatter(data,tau) uses symbol='.'
% Copyright (c) 1996 by D. Kaplan, All Rights Reserved

if nargin < 2
  tau=1; % default argument
end
if nargin < 3
  symbol='.';
end

% clumbsy error checking
if tau < 0
  error('tau must be > 0');
end

tau=fix(tau);

xdata = data(1:(length(data)-tau) );
ydata = data((1+tau):length(data));

a = min(xdata);
b = max(xdata);
xmin = a - .1*(b-a);
xmax = b + .1*(b-a);

plot(xdata,ydata,symbol)
axis([xmin xmax xmin xmax])
axis square

