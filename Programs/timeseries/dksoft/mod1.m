function x = mod1(a,b,n,sigma)
% mod1(a,b,n,sigma) generates a realization of model 1 with
% gaussian measurement noise with standard deviation
% sigma
% Copyright (c) 1996 by D. Kaplan, All Rights Reserved

foo = randn(n,1)*sigma;
x = model1(a,b,foo,b/(.00001+abs(1-a)));

