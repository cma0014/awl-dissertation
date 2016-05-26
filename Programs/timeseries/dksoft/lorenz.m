function yprime = dklorenz(t,state)
% Lorenz differential equation for use in ode45
x = state(1);
y = state(2);
z = state(3);
yprime = [10*(y-x), x*(28-z)-y, x*y- 8*z/3];

