function z = model1(a,b,nu,x0)
% MODEL1 runs model 1 dynamics and measurements
%   given the noise inputs nu
%   x0 is the initial condition
% Copyright (c) 1996 by D. Kaplan, All Rights Reserved

if nargin < 4
  x0 = b/(1-a);
end

if nargin < 3
  nu = randn(10,1);
end

nx = x0;
z = 1:length(nu);

for i = 1:length(nu)
  nx = a*nx + b;
  z(i) = nx + nu(i);
end

end
