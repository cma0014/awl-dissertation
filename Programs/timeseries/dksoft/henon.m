function nx = henon(x,p)
%  HENON is the henon map
%  henon([x,y],p) gives a single iteration

nx = [1.4 + 0.3 * x(2) - x(1)*x(1), x(1) ];

