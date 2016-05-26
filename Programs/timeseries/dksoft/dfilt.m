function res = fftfilt( data, filt )
% FFTFILT( data, filt )
% filters in the spectral domain
% data -- the data to be filtered
% filt -- a filter (as made by FILTSPEC)
% Copyright (c) 1996 by D. Kaplan, All Rights Reserved
 
if length(data) ~= length(filt)
  error( 'data and filt must be the same length.');
end
d = fft(data);
d = d.*filt;
res = real( ifft(d) );


