function [range,image] = midcast(z)
% [range,image] = midcast(z)
% Similar to getimage() but for 'midcasting'
% z -- embedded data
% range -- the 'from' part of the mapping
% image -- the 'to' part of the mapping
% image is set to be a column from the middle of z
% while range is the other columns
% Copyright (c) 1996 by D. Kaplan, All Rights Reserved

[x,y] = size(z);
if y <= 2 
  error( 'z must have at least 3 columns');
end

col = round(.51 + y/2);
image = z(:,col);
foo = 1:y;
foo = find(foo ~= col);
range = z(:,foo);
