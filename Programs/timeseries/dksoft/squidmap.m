function y = squidmap(x,p)
% SQUIDMAP(x,p) makes something that looks like the squidmap
% x -- state
% p -- parameter representing inter-stimulus interval
% Copyright (c) 1996 by D. Kaplan, All Rights Reserved


%symmetric around x=0.5
if x > .5
  x = 1-x;
end

if x < .693/p
  y = (exp(x*p)-1)^3;
else
  y = 1-.05*x;
end
