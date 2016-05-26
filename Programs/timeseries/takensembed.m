function [xt varargout] = takensembed(xr,w)
% takensembed - apply Takens embedding theorem to a time series
% 
xr = xr(:);
xt = [];
r = [];
for j = 1:w,
    range = length(xr)-j+1:-w:w-j+1;
    r = [r range];
    xt0 = xr(end-j+1:-w:w-j+1);
    xt = [xt0(end:-1:1) xt];
end;
varargout{1} = r;
