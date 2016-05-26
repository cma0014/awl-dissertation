function r = mod2(a,b,n,sdyn,smeas)
% mod2 generates a realization of model 2
% mod2(a,b,n,sdyn,smeas)
% n - number of points
% sdyn - standard deviation of dynamical noise
% smeas - standard deviation of measurement noise
% Copyright (c) 1996 by D. Kaplan, All Rights Reserved

ndyn = randn(n,1)*sdyn;
nmeas = randn(n,1)*smeas;

r = model2(a,b,ndyn, nmeas, b/(.00001+abs(1-a)));

