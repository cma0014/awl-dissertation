function [a0,a1,val,mn] = locallin(z,pt,k,targs,exclude)
% [a0, a1, val] = LOCALLIN( z, pt, k, targs, exclude ) finds a locally linear
% map for z(t+1) based on embedded values
% z -- embedded data
% pt -- the point at which to construct the map
% k  -- how many neighbors to use
% targs -- the actual target values in the time series
% exclude -- don't use the point with this index in the map
% a0 -- constant in map
% a1 -- vector by which to multiply pt
% val -- the value of the map evaluated at pt
% mn -- value of a locally constant map
% Copyright (c) 1996 by D. Kaplan, All Rights Reserved

if nargin == 5
  inds = localmap(z,pt,k,exclude);
else
  inds = localmap(z,pt,k);
end

f= targs(inds,:);
p = z(inds,:);
% construct an augmented matrix for the linear fit
p1 = [ones(length(f),1), p];
foo = p1\f;
a0 = foo(1);
a1 = foo(2:length(foo));
val = a0 + pt*a1;
mn = mean(f);
