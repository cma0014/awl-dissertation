function [error, pctErr] = armaPredict(model, data)
pctErr = 0;
N = length(data);
ARp = model.na;
MAp = model.nc;
ARparam = model.A;
MAparam = model.C;
steps = 5;
p = max(ARp, MAp);

% Initialize Estimates
for i = 1:p
   est(i) = data(i); 
end
% Perform Estimates
X = floor(N/(steps+1));
for x = 1:X+1
    t = (p+1)+((steps+1)*(x-1));
    total = 0;
    if t > N
        break;
    end
    for i = 1:ARp
        total = total + (ARparam(i+1)*data(t-i));
    end
    for i = 1:MAp
        total = total + (MAparam(i+1)*data(t-i));
    end
    est(t) = abs(total);
    
    for n = 1:steps
        if t+n > N
            break;
        end
        total = 0;
        for i = 1:ARp
            total = total + (ARparam(i+1)*est((t+n)-i));
        end
        for i = 1:MAp
            total = total + (MAparam(i+1)*est((t+n)-i));
        end
        est(t+n) = abs(total);
    end
end

error = mean(abs(est - mean(data)));
pctErr = (abs(sum(est)-sum(data))./sum(data))*100;
rmse = sqrt(sum((data(:)-est(:)).^2)/numel(data))
plot((steps:N),data(steps:N),'g-',(steps:N),est(steps:N),'b-'), legend('Actual', 'Estimate');
end