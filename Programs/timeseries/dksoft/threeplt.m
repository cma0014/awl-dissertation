function threeplt(data,tname,tau,nbins,symbol)
% THREEPLT makes a sometimes useful plot of a time series
%    threeplot( data, [tname, tau, nbins, symbol] )
%    tau is the lag to use in the scatter plot
%    nbins is the number of bins in the histogram
%    symbol is the symbol to use in the time series plo
% Copyright (c) 1996 by D. Kaplan, All Rights Reserved

c=fix(clock);

if nargin < 2
   tname=[int2str(c(4)), ':', int2str(c(4)), ':', int2str(c(6))  ];
end

if nargin < 3
   tau=1;
end

if nargin < 4
   nbins=2+ 3*log(length(data)+1);
end

if nargin < 5 
   symbol='-';
end

subplot(2,1,1)
plot(data,symbol)
title(tname)


subplot(2,2,3)
hist(data,nbins)

title('histogram')

subplot(2,2,4)
scatter(data,tau)
xlabel('x(t)')
ylabel(['x(t+',int2str(tau),')']);
subplot;
hold off;




