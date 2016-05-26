function phat = fpredict(series,A,B,C,S)
% fpredict - predict time series values based on DFT
% Reconstruct Signal - pmax is number of frequencies used in
% increasing order
        pmax = 13;
        phat = A(1)/2+C(:,2:pmax)*A(2:pmax)'+S(:,2:pmax)*B(2:pmax)';
    
