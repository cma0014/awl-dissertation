function a = fditer(fun, x, p, n )
%  FDEiter iterates a finite-difference equation a given number of times
%  FDEiter( fun, x, p, n )
%  fun is the function, which must be of the form f(x,p)
%  where p is the function parameter
%  returns a column vector of length n
% Copyright (c) 1996 by D. Kaplan, All Rights Reserved
a = zeros(n,length(x));
nx = x;

x
nx
p
n

for k = 1:n
  nx = feval( fun, nx, p);
  a(k,:) = nx;
end
