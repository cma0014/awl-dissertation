% Extract ProcPwr column from a xls document
%   Input:
%       data:       Data Set from xls document
%       hdr:        Headers from xls document 
%   Output:
%       ProcPwr:    ProcPwr data
function [ProcPwr, row] = getProcPwr(data, hdr)
% Find ProcPwr Column
for i = 1:length(hdr)
    % Extract ProcPwr Data
    if strcmp(hdr(i), 'ProcPwr')
        ProcPwr = data(:, i);
        row = i;
        break
    end
end
end