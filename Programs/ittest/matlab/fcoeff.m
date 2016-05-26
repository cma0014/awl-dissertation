function [A B C S] = fcoeff(series)
% fcoeff - return fourier coefficents of a time series
    y = series';
    N=length(y);
    if mod(N,2) == 1
        N = N + 1;
        y = [y y(N-1)];
    end;
    % Compute the matrices of trigonometric functions
    p=1:N/2+1;
    n=1:N;
    C=cos(2*pi*n'*(p-1)/N);
    S=sin(2*pi*n'*(p-1)/N);
    
    % Compute Fourier Coefficients
    A=2/N*y*C;
    B=2/N*y*S
    A(N/2+1)=A(N/2+1)/2;        
    
