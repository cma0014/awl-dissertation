function estimate = marspredict(model,data,maxY)
% marsmodel
[xRows xCols] = size(data);
for i = 1:xCols
    maxCol = max(data(:,i));
    data(:,i) = data(:,i) / maxCol;
end
estimate = arespredict(model,data);
estimate = maxY * estimate;



