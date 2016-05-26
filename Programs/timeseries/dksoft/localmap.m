function inds = localmap(z, pt, k, exclude )
% inds = LOCALMAP(z, pt, k, exclude ) constructs the
% indices of neighboring points
% z -- matrix of embedded data
% pt -- the point at which to find the neighbors
% k -- the number of nearest neighbors to use
% index (optional) -- exclude this point from the preimages
% Copyright (c) 1996 by D. Kaplan, All Rights Reserved

if nargin == 4
  k = k+1;  %get an extra point
end

[inds, dists] = findneib(z,pt,k);

if nargin == 4
  foo = find( inds ~= exclude );
  inds = inds(foo);
end


