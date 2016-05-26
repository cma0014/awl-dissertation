function err = prederr(x)
% err = prederr(x) returns the nonlinear prediction
% error for time series x 
% SET THE GLOBAL VARIABLES 
% nlplag -- embedding lag (default 1)
% nlpdim -- embeddin dime (default 3)
% IMPORTANT: to set nlplag and nlpdim do the following
% global nlplag nlpdim
% nlplag = 4; or whatever lag you want
% nlpdim = 3; or whatever dimension you want
% then run prederr(x)
% Copyright (c) 1996 by D. Kaplan, All Rights Reserved


global nlplag nlpdim

if length(nlplag) == 0
  nlplag = 1;
end

if length(nlpdim) == 0
  nlpdim = 3;
end

k=20;
if nlpdim > (k-1)
  k = nlpdim + 1;
end


foo = lagembed(x,nlpdim, nlplag);
[data2, images] = getimage(foo, nlplag);
[lin, const] = evalmap( data2, images, k );

err = std(images-lin);

