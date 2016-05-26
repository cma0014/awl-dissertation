function res = boxcount( data, nbins )
% BOXCOUNT( data, nbins) counts the number of
% boxes that a matrix occupies.
% Copyright (c) 1996 by D. Kaplan, All Rights Reserved
scale = 1;
sum = zeros(length(data),1);

for x = data
  mx = max(x);
  mn = min(x);
  bs = 1.00001*(mx-mn)/nbins;
  sum = sum+ scale*floor( (x-mn)/bs);
  scale = scale*nbins;
end
sum = sort(sum);
s1 = sum(2:length(sum));
s2 = sum(1:(length(sum)-1));
s3 = [ (s1 -s2); 1];
% find the indices that mark the divisions between boxes
s4 = find(s3>0);
s5 = [0; s4(1:(length(s4)-1) ) ];

res = s4-s5;
