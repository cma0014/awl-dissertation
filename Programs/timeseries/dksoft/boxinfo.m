function res = boxinfo( bcounts )
% BOXINFO( bcounts ) calculates the information
% given the bcounts as produced by boxcount
% Copyright (c) 1996 by D. Kaplan, All Rights Reserved
n = sum(bcounts);
p = bcounts/n;
res = -sum(p.* log(p) )/log(2);
