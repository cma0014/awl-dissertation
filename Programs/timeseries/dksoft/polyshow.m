function res = polyshow(pre,post,order)
% POLYSHOW(pre,post,order) fits a polynomial to post vs. pre
% returns the coefficients of the fit
% plots out the polynomial and pre vs. post for convenience.
% Copyright (c) 1996 by D. Kaplan, All Rights Reserved

p = polyfit(pre,post,order);
mx = max(pre);
mn = min(pre);
top = mx + (mx-mn)*.05;
bottom = mn - (mx-mn)*.05;
step=(top-bottom)/100;
x = bottom:step:top;
vals = polyval(p,x);
plot(x,vals);
hold on
plot(pre,post,'+');
res = p;
hold off

