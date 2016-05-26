function res=filtspec(cut, len, width)
% FILTSPEC( cut, len, width )
% Function for specifying a low-pass filter
% in the fourier domain
% cut - cutoff frequency in terms of the sampling freq
% len - length of the data to be filtered
% width - width of the transition zone
% Copyright (c) 1996 by D. Kaplan, All Rights Reserved

if cut >= .5
  error('Cutoff frequency too high.  Must be < .5');
end
if cut + width >= .5
  error('Width too high.  Cut + width must be < .5');
end

high1=len/2;
high2=len/2-1;
if floor(len/2)~= len/2
  high2 = floor(len/2);
end

q = ( [ 0:high1 high2:-1:1 ]/len)';
if( width ~= 0 )
  t = (cut + width -q)/ width;
  t = t.*(t<.99999).*(t>0.0001);
else
  t = 0*q;
end
res = t + (q<=cut);

