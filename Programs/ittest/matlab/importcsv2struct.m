function dataByColumn1 = importcsv2struct(fileToRead1)
%databyColumn1 = IMPORTCSV2STRUCT(FILETOREAD1)
%  Imports data from the specified file
%  FILETOREAD1:  file to read
%  databyColumn1: structure with data read from file

% Import the file
newData1 = importdata(fileToRead1);

% Break the data up into a new structure with one field per column.
colheaders = genvarname(newData1.colheaders);
for i = 1:length(colheaders)
    dataByColumn1.(colheaders{i}) = newData1.data(:, i);
end


