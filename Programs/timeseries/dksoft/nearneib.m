function y = nearNeib( emb, p, k, time, lockout )
% nearNeib finds the k nearest neighbors of a point in a set of vectors
% nearNeib( emb, p, k ) <emb> is the list of vectors (embedded points?)
%			<p> is the reference point
%			<k> is the number of neighbors
% nearNeib( emb, p, k, time, lockout ) uses a lockout to exclude points 
%			that are nearby in time
% Copyright (c) 1996 by D. Kaplan, All Rights Reserved

tmp = size(p);
tmp2 = size(emb);

if tmp(2) != tmp2(2)
	error("nearNeib: <p> and <emb> must have same number of rows");
	return;
end