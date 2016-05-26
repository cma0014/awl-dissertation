function res = polycv(pre,post,order)
% POLYCV(pre,post,order) calculates the residuals of
% a polynomial fit of post vs pre using leave-one-out
% cross validation
% Copyright (c) 1996 by D. Kaplan, All Rights Reserved

npts = length(pre);
inds = 1:npts;
res = zeros(npts,1);
% loop over all points
for k=1:npts
  foo = find(inds ~= k);
  ppre = pre( foo );
  ppost = post( foo );
  p = polyfit(ppre,ppost,order);
  val = polyval(p,pre(k));
  res(k) = (val - post(k));
end






