function comphist( data, tname, type )
% COMPHIST overplots a histogram and a probability
% distribution
% Copyright (c) 1996 by D. Kaplan, All Rights Reserved
[yhist,xhist] = hist(data);
[yyhist, xxhist] = bar(xhist,yhist);
% Compute the width of the histogram bars
% so that the pdf plots look visually the same
barwidth = yyhist(4) - yyhist(1);
bar(xhist,yhist);
hold on;
title(tname);

% for a normal distribution
% we're scaling by the barwidth to keep things attractive
m = mean(data);
sigma = std(data);
pts = (-2*barwidth+yyhist(1)):barwidth/10:(2*barwidth+yyhist(length(yyhist)));
gv = barwidth*length(data)*normpdf(pts,m,sigma);
plot( pts, gv );
% uniform distribution
nv = (length(data)/length(xhist))*ones(length(pts));
plot( pts, nv);


hold off;
