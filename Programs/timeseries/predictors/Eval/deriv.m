function deriv(data)
N = length(data.A);
LARGE = zeros(N*12);
NN =length(LARGE);
length(1:N)
t = 2:NN;
LARGE(1:N) = data.B;
LARGE(N+1:(N*2)) = data.C;
LARGE((N*2)+1:(N*3)) = data.D;
LARGE((N*3)+1:(N*4)) = data.E;
LARGE((N*4)+1:(N*5)) = data.F;
LARGE((N*5)+1:(N*6)) = data.G;
LARGE((N*6)+1:(N*7)) = data.H;
LARGE((N*7)+1:(N*8)) = data.I;
LARGE((N*8)+1:(N*9)) = data.J;
LARGE((N*9)+1:(N*10)) = data.K;
LARGE((N*10)+1:(N*11)) = data.L;
LARGE((N*11)+1:(N*12)) = data.M;

for i = 1:NN-1
    dX(i) = LARGE(i+1) - LARGE(i);
end

% Convert data to polar coordinates
%[TH, R] =cart2pol(data(2:N), dX'); 
%polar(TH, R, '--b');
plot(LARGE(t), dX)
min(LARGE);
end