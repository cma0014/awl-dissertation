function a = fditer(fun, x, p, n )
%  FDITER( fun, x, p, n ) iterates a finite-difference 
%   equation a given number of times
%
%  fditer( fun, x, p, n )
%  fun is the function, which must be of the form f(x,p)
%  where p is the function parameter
%  returns a column vector of length n
% 
%  Example: fditer('quadmap', 0.32323, 4, 100);
%  calculates 100 iterations of the quadratic map
%  starting from 0.32323 with parameter value 4
%  Note: quadmap has the syntax quadmap(x,p) ---
%  all functions to be iterated must have this syntax.
%  Copyright (c) 1996 by D. Kaplan, All Rights Reserved

a = zeros(n,length(x));
nx = x;

for k = 1:n
  nx = feval( fun, nx, p);
  a(k,:) = nx;
end