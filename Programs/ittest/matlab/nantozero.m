function data = nantozero(m)
% NANTOZERO - convert NaNs in matrix to zero
    [rows cols] = size(m);
    for i = 1:rows
        r = m(i,:);
        if (sum(isnan(r)) > 0)
            for j = 1:cols
                if isnan(m(i,j))
                    data(i,j) = 0;
                else
                    data(i,j) = m(i,j);
                end
            end
        else
            data(i,:) = r;
        end
    end
    
