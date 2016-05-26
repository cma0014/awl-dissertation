function printsp(data,varargin)
% printsp - write the output spreadsheet to csv file
   optargs = size(varargin,1);
   if optargs > 0
        filename = varargin{1};
   else
        filename = 'printsp.csv';
   end
   header = ['Time'...
             'Ambient_Temp0' 'Ambient_Temp1' 'CPU_0_Temp''CPU_1_Temp,' ...
             'HT1Scaled' 'HT2Scaled'...
             'disk_read_kbytes' 'disk_write_kbtyes'...
             'Blower_Fan_0' 'Blower_Fan_1' 'Axial_Fan_0''Axial_Fan_1'];
   dlmwrite(filename,[header;data]);

