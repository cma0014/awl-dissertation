function res = boxdim(data,doinfo)
% BOXDIM(data) returns two columns, 
% log of the box resolution
% and log of the number of occupied boxes at that resolution.
% data --- a matrix of embedded data
% do-info --- flag return the information rather than the count
% Copyright (c) 1996 by D. Kaplan, All Rights Reserved

res = zeros(25,2);

for nc=1:25
  bins = nc*2;
  res(nc,1) = - log(2*bins);
  if nargin < 2 
    res(nc,2) = log(length(boxcount(data,bins))+.0000001);
  else
    res(nc,2) = boxinfo(boxcount(data,bins));
  end
end


  