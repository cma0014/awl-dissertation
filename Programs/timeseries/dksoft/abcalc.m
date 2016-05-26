function [a,b] = abcalc(alpha0, beta0, alpha1, beta1, p0, p1)
% [a,b] = ABCALC(alpha0, beta0, alpha1, beta1, p0, p1) calculates
% a and b for feedback control of one-dimensional maps
% for the definitions of the arguments, see the Squid Lab instructions
% Copyright (c) 1996 by D. Kaplan, All Rights Reserved

gamma = (beta1-beta0)/(p1-p0);
a = -alpha0 /(gamma - alpha0 * gamma);
b = (alpha0*beta0 + gamma*p0 - alpha0*gamma*p0)/(gamma - alpha0*gamma);

