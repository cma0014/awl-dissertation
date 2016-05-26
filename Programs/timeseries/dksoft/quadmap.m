function nx = quadmap(x,p)
% QUADMAP does one iteration of the quadratic map:  p x (1-x)
%     quadmap(x,p) -- x is state, p is parameter
%     quadmap(x) -- default value of p == 4

if nargin < 2 
  p = 4;
end

nx = p * x * (1-x);
