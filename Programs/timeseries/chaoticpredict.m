function [xhat indices] = chaoticpredict(Xt,g,w)
% chaoticregress - Regression analysis of chaotic time series
% Use local linear first order polynomials to predict a chaotic time
% series. 
% The algorithm has three steps:
% Step 1: Change over to a vector space using Takens embedding
% 	theorem
% Step 2: Use the nearest neighbors algorithm in the reconsturcted
% 	space to identify the attractors.
% Step 3: Solve the resulting constrained linear least squares
% 	problem using lsqlin
% Input:
% Xt - time sereis
% w  - the lengt of the analog attractor
% Output:
% Xhat - set of predictors 
% g    = coefficients
%
% --- Step 1: do the Takens embedded
[xr indices] = takensembed(Xt,w);
% --- Step 2: find nearest analogs
xs0 = xr(end,:); c=[];c0=[];
for j=1:w,
  c1=((xr(1:end-1,j)-xs0(j))).^2;%calculates squared distances,  
  c=[c c1];%collects the matrix of squared distances
end
cmetr=c';%this matrix contains also metric information 
[o,ini]=sort((mean(cmetr)));%sorts the squared distances to find min
ini=ini(1:w+1);%w+1 is a minimum number, it works better for the time series of the limited length
A=xr(ini,:);%a matrix of nearest analogs
Xf=xr(ini+1,1);%next point of nearest analogs
% --- Step 3: Solve the constratined linear least squares problem
[g,rn,res] = lsqlin(A,Xf,[],[],[],[],-1*ones(1,w),1*ones(1,w));


