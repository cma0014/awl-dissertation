function [de,desurrs] = dode(ts,dim,lag,nsurrs)
% [de,desurrs] = dodeltaeps(ts,dim,lag,nsurrs)
% run deltaeps on some data and surrogates
% Copyright (c) 1996 by D. Kaplan, All Rights Reserved

de = quickde(ts,dim,lag);
desurrs = zeros(nsurrs,1);
for k=1:nsurrs
  ys = ampsurr(ts);
  desurrs(k) = quickde(ys,dim,lag);
end
