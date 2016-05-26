function res = mapcon(x0,map,a,b,n,mu0,xon,xsize)
% MAPCON(x0,map,a,b,n,xon,xsize) iterates a map using
% linear feedback control
% x0 -- initial condition
% map -- the map to iterate map(x,param)
% a, b -- parameters in the feedback control
% n -- number of iterates
% mu0 -- default value of parameter
% xon, xsize -- turn on control when x is in xon+-xsize
% Copyright (c) 1996 by D. Kaplan, All Rights Reserved

res = zeros(n,1);
x = x0;
for k=1:n
  if abs(x-xon) < xsize
    mu = a*x + b;
  else
    mu = mu0;
  end
  x = eval([map '(x,mu)']);
  res(k) = x;
end

