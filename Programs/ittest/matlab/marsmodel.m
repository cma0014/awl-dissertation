function [model params maxY] = marsmodel(X,Y)
% marsmodel
% Normalize the data
[xRows xCols] = size(X);
for i = 1:xCols
    maxCol = max(X(:,i));
    X(:,i) = X(:,i) / maxCol;
end
maxY = max(Y);
Y = Y / maxY;
% Parameters to use for guidling the model.  
% default values:
% 21,3,true,2,1,1,1e-4,true,1,1,Inf.
maxFuncs = 121;
gcv = 0;
cubic = true;
cubicFastLevel=2;
selfInteractions=1;
maxInteractions=1;
threshold=1e-4;
prune=true;
useMinSpan=-1;
useEndSpan=-1;
maxFinalFuncs=Inf;
params = aresparams(maxFuncs, ...
                    gcv, ...
                    cubic, ...
                    cubicFastLevel, ...
                    selfInteractions, ...
                    maxInteractions, ...
                    threshold, ...
                    prune, ...
                    useMinSpan, ...
                    useEndSpan, ...
                    maxFinalFuncs);
% Create the model.
model = aresbuild(X,Y,params);

