function res = repeatp( proc, stat, n )
% REPEATP(proc, stat, n) generates realizations
% of a process, and calculates a statistic on each of
% them.
% proc -- the process to use
% stat -- the statistic to use
% n -- the number of realizations
% Copyright (c) 1996 by D. Kaplan, All Rights Reserved

if ~isstr(proc)
  error('Must give proc as string variable (in single quotes)')
end
if ~isstr(stat)
  error('Must give stat as string variable (in single quotes)')
end

res = zeros(n,1);
for k=1:n
  goo = eval(proc);
  res(k) = eval([stat '(goo)']);
end

