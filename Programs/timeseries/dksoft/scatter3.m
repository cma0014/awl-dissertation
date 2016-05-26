function scatter3(data,tau,symbol)
% SCATTER3 makes a 3dim scatter plot of 
%x(t) versus x(t+tau) vz. x(t+2*tau)
%    scatter3(data,tau,symbol) 
%    scatter3(data) uses tau=1, symbol='.'
%    scatter3(data,tau) uses symbol='.'
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

xdata = data(1:(length(data)-2*tau) );
ydata = data((1+tau):length(data)-tau);
zdata = data((1+2*tau):length(data));

%a = min(xdata);
%b = max(xdata);
%xmin = a - .1*(b-a);
%xmax = b + .1*(b-a);

plot3(xdata,ydata,zdata,symbol)
%axis([xmin xmax xmin xmax])
%axis square