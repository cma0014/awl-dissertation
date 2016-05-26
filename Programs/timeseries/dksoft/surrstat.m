function res = surrstat( data, stat, n, type )
% Computes a statistic on surrogate data 
f = fftsurr(data);
res = eval([stat '(f)']);
 