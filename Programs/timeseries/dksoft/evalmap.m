function [lin,const] = evalmap(zz,targs,k)
% [lin,const] = EVALMAP(zz,targs,k) finds the
% values of a locally linear map and a locally constant map
% map for targs = f(zz)
% zz - embedding of data
% targs -- the images of zz under the dynamics --- the map will be
%          fit to this.
% k - number of neigbors to use in constructing the map
% RETURNED VALUES
% lin -- values of the locally linear map at each point in zz
% const -- values of the locally contant map at each point
% Copyright (c) 1996 by D. Kaplan, All Rights Reserved
len = length(zz);

lin = zeros(len,1);
const = zeros(len,1);

for j=1:(len)
    % exclude the current point j from the fitting
    [a0,a1,val,mn] = locallin(zz, zz(j,:), k, targs, j);
    lin(j) = val;
    const(j) = mn;
end

