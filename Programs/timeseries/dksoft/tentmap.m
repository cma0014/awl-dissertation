function y = tentmap(x,p)
% TENTMAP(x,p) tent map of x at parameter p.
% p = 1.99999 is the chaotic one
if x > .5
  x = 1-x;
end
y = p*x;

