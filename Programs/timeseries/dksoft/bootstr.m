function r = bootstr( data, stat, n )
% BOOTSTR estimates the standard error of a statistic
% using bootstrapping.
%
% bootstr( data, stat, n )
% data is a matrix containing the data --- sampling
% is done row-by-row
% stat is the statistic to use.  It should have
% the form
% res = stat(data)
% where res is a scalar
% n is the number of bootstrap samples to take
% example bootstr( randn(100,1), 'mean', 50 );
% returns 50 realizations of the bootstrap
% Copyright (c) 1996 by D. Kaplan, All Rights Reserved

s = size(data); if s(1)<s(2) data=data'; end;

r = zeros(n,1);
len = length(data);
for k=1:n
  foo = ceil(len*rand(len,1) );
  goo = data(foo,:);
  r(k) = eval([stat '(goo)']);
end
