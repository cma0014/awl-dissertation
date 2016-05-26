function error = MARSpredict(model, data)
N = length(data);

est = arespredict(model, data);
error = mean(abs(est - mean(data)));
est = est./max(est);

figure, plot((1:N)./N,data./max(data),'g',(1:N)./N,est,'b-'), legend('Actual', 'Estimate');
end