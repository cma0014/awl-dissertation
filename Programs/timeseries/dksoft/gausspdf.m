function p = gausspdf(x,mean,sigma)
% GAUSSPDF(x,mean,sigma) gives the gaussian distribution
%  evaluated at x
p = sqrt(1/(2*pi))*(1/sigma)*exp( -(x-mean).*(x-mean)/(2*(sigma.^2)) );

