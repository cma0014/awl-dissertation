function z = model2(a,b,omega,nu,x0)
% MODEL2 runs model 2 dynamics and measurements
%   given the noisy dynamics omega
%   and measurement inputs nu
%   x0 is the initial condition
% Copyright (c) 1996 by D. Kaplan, All Rights Reserved
 
if nargin < 5
  x0 = b/(1-a);
end

if nargin < 4
  if nargin == 3
     nu = randn(length(omega),1);
  else
     nu = randn(10,1);
  end
end

if nargin < 3
  omega = randn(length(nu),1);
end

nx = x0;
z = 1:length(nu);

for i = 1:length(nu)
  nx = a*nx + b + omega(i);
  z(i) = nx + nu(i);
end

end
