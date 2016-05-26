function res = rho(x, k)
% RHO(x, k) calculates the correlation coefficient
% between x(t) and x(t-k)
% rho(x) has k=1 by default
% Copyright (c) 1996 by D. Kaplan, All Rights Reserved

if nargin < 2
 k = 1;
end

if length(x) <= k
 error( 'x must have length > k');
end

[a,b] = size(k);
if b ~= 1
  error('x must be a column vector');
end

if k == 0
 res = 1;
 return;
end

if k < 0
 k = -k;
end

foo = lagembed(x,2,k);
goo = corrcoef(foo);
res = goo(1,2);

