function importfile(fileToRead1)
%IMPORTFILE(FILETOREAD1)
%  Imports data from the specified file
%  FILETOREAD1:  file to read

%  Auto-generated by MATLAB on 11-Jun-2008 21:31:01

% Import the file
newData1 = importdata(fileToRead1);

% Break the data up into a new structure with one field per column.
colheaders = genvarname(newData1.colheaders);
for i = 1:length(colheaders)
    dataByColumn1.(colheaders{i}) = newData1.data(:, i);
end

% Create new variables in the base workspace from those fields.
vars = fieldnames(dataByColumn1);
for i = 1:length(vars)
    assignin('base', vars{i}, dataByColumn1.(vars{i}));
end
assignin('base','dslength',length(vars{i}))
%%
%% Main
importfile('perlbench.csv')
CPU0Matrix = [ones(275,1) Time fan1 fan2 fan3 fan4 fan5 fan6 cpu0ht1lu]
[C0b,C0sigma,C0resid,C0covb] = mvregress(X,cpu0dietemp)
CPU1Matrix = [ones(275,1) Time fan1 fan2 fan3 fan4 fan5 fan6 cpu1ht1lu]
[C1b,C1sigma,C1resid,C1covb] = mvregress(X,cpu0dietemp)
