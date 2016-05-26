function plotde(delta,epsilon,pargs)
% plotde(delta,epsilon,pargs)
% pargs --- optional plotting commands: goes in third slot of plot(x,y)
% makes a cumulative plot of epsilon vs delta
% that is useful for picking length scales and
% and for comparing to surrogate data
% Copyright (c) 1996 by D. Kaplan, All Rights Reserved

if nargin < 3
  pargs = 'b';
end

% sort delta and epsilon
[d,inds] = sort(delta);
e = epsilon(inds);

ee = cumsum(e);
ee = ee./((1:length(e))');
plot(d,ee,pargs);
