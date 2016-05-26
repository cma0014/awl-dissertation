function dumppred(name, power,powerhat,varargin)
    numvarargs = length(varargin);
    if (numvarargs > 2)
        error('ibuildmodel: too many optional arguments');
    end
    optargs = {0};
    if (numvarargs > 0)
        optargs(1:numvarargs) = varargin;
    end
    [smooth]  = optargs{:};  
    a = abs(power - powerhat);
    r = a ./ power;
    p = [power  powerhat  a r];
    csvname = strcat(name,'compare.csv');
    csvwrite(csvname,p);
    a = a(30:length(a));
    r = r(30:length(r));
    n = length(a);
    if (smooth == 1)
        fprintf('%s :  comparsion spreadsheet\n',name);
        fprintf('Average pcn error: %6.3f Max pcnt error: %6.3f RMSE:%6.3f\n',...
                 mean(r), ...
                 max(r),...
                 std(a)/sqrt(n));
        % fprintf('\n%s ->\n time: (power,powerhat) -> abs error pcnt error\n',name);
        % for i= 1:length(p)
        %     fprintf('%4d:(%6.2f,%6.2f) -> %6.2f %6.2f\n',...
        %             5*i,p(i,1),p(i,2),p(i,3),p(i,4));
        % end;
    end;
