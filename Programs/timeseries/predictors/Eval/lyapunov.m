function exp_avg = lyapunov(data)

N = length(data);

% create return map
next = zeros(N, 1);
for i=1:N-1
    next(i) = data(i+1);
end
next(N) = data(i+1);

% plot return map
figure(1), plot(data(1:N-1), next(1:N-1), '.'), title('Return Map');

% FFT
fftcoeff = fft(data, N);
t = 2:N;

% plot absolute value of FFT coefficients
figure(2), plot(t, abs(fftcoeff(2:N))), title('Fourier Coefficients');

N2 = floor(N/2);
N4 = floor(N/4);
k=N2;
exponent = zeros(N4, 1);
for j=1:N4
    d = abs(data(k+1) - data(k));
    index = k+1;
    for i=2:N-1
        if (i ~= k) && (abs(data(i) - data(k)))<d
            d = abs(data(i) - data(k));
            index = i;
        end
    end
    if (data(k) ~= data(index)) && (data(k+1) ~= data(index+1))
        exponent(j) = log(abs(data(k+1)-data(index+1)))-log(abs(data(k)-data(index)));
    end
    k = k+1;
end

% find the average value for lyapunov exponent
t = 1:N4;
lyapunov = exponent(1:N4);
exp_avg = 0.0;
for (i=1:N4)
    exp_avg = exp_avg + exponent(i);
end

% plut the exponents, average, and the baseline
exp_avg = exp_avg/N4;
figure(3), plot(t, lyapunov, t, 0, t, exp_avg);
end