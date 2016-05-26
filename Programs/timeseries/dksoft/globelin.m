function [a0, a1, preds] = globelin( data, targ )
% GLOBELIN(data, targ )
% Fit a globally linear model of how targ depends on data
% data - the domain of the linear model
% targ - the range of the model
% outputs --- 
% a0 -- the constant in the model
% a1 -- parameters of the linear part of the fit
% preds -- the predictions made by the model
% Copyright (c) 1996 by D. Kaplan, All Rights Reserved

% construct an augmented matrix for the linear fit
p1 = [ones(length(data),1), data];
foo = p1\targ;
a0 = foo(1);
a1 = foo(2:length(foo));
preds = a0 + data*a1;
