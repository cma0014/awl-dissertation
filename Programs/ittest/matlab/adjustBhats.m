function bhat = adjustBhats(bhat)
% adjsutBhats(bhat)
%       Adjust the values of the bhats
varStrings = {' ',...
              'Temp0',  ...
              'Temp1', ...
              'Planar_Temp', ...
              'VRD_0_Temp', ...
              'VRD_1_Temp', ...
              'Fan1', ...
              'Fan2a', ...
              'Fan2b', ...
              'Fan3a', ...
              'Fan3b', ...
              'Fan4a', ...
              'Fan4b', ...
              'Fan5a', ...
              'Fan5b', ...
              'fsbcaled', ...
              'l2miss_scaled' ...
              'disk_read_kbytes' ... 
              'disk_write_kbytes', ...
             };
coeff = 1:length(varStrings);
% fprintf('Before override:\n')
% fprintf('%2d %10.4f + \n',coeff(1),bhat(1));
% for i = 2:size(bhat)
%     fprintf('%2d %10.4f +  %s\n',coeff(i),bhat(i),varStrings{i});    
% end;
% fprintf('Overriding \n');
% bhat(1) = -1.1;
% bhat(2) = 0.9;
% bhat(3) = 0.9
% bhat(4) =-0.7
% bhat(5) = -1.9;
% bhat(6) = 0.4

fprintf('Before adjustment:\n')
fprintf('%2d %10.4f + \n',coeff(1),bhat(1));
for i = 2:size(bhat)
    fprintf('%2d %10.4f +  %s\n',coeff(i),bhat(i),varStrings{i});    
end;

fprintf(['Do you wish to adjust the values of the beta ' ...
          'coefficients? (1 -> Yes, 0 -> No (default)']);
response = input(' Your choice? ');
if (isempty(response) == 0) && (response == 1)
    fprintf(' b0                          (Current value: %10.6f)',bhat(1));
    newvalue = input(' New value? ');
    if isempty(newvalue) == 0
        bhat(1) = newvalue;
    end;
    fprintf('   + b1 * Temp0              (Current value: %10.6f)',bhat(2));
    newvalue = input(' New value? ');
    if isempty(newvalue) == 0
        bhat(2) = newvalue;
    end;
    fprintf('   + b2 * Temp1              (Current value: %10.6f)',bhat(3));
    newvalue = input(' New value? ');
    if isempty(newvalue) == 0
        bhat(3) = newvalue;
    end;
    fprintf('   + b3 * Planar_Temp        (Current value: %10.6f)',bhat(4));
    newvalue = input(' New value? ');
    if isempty(newvalue) == 0
        bhat(4) = newvalue;
    end;
    fprintf('   + b4 * VRD_0_Temp        (Current value: %10.6f)',bhat(5));
    newvalue = input(' New value? ');
    if isempty(newvalue) == 0
        bhat(5) = newvalue;
    end;
    fprintf('   + b5 * VRD_1_Temp         (Current value: %10.6f)',bhat(6));
    newvalue = input(' New value? ');
    if isempty(newvalue) == 0
        bhat(6) = newvalue;
    end;
    fprintf('   + b6 * Fan1               (Current value: %10.6f)',bhat(7));
    newvalue = input(' New value? ');
    if isempty(newvalue) == 0
        bhat(7) = newvalue;
    end;
    fprintf('   + b7 * Fan2a              (Current value: %10.6f)',bhat(8));
    newvalue = input(' New value? ');
    if isempty(newvalue) == 0
        bhat(8) = newvalue;
    end;
    fprintf('   + b8 * Fan2b              (Current value: %10.6f)',bhat(9));
    newvalue = input(' New value? ');
    if isempty(newvalue) == 0
        bhat(9) = newvalue;
    end;
    fprintf('   + b9 * Fan3a             (Current value: %10.6f)',bhat(10));
    newvalue = input(' New value? ');
    if isempty(newvalue) == 0
        bhat(10) = newvalue;
    end;
    fprintf('   + b10* Fan3b              (Current value: %10.6f)',bhat(11));
    newvalue = input(' New value? ');
    if isempty(newvalue) == 0
        bhat(11) = newvalue;
    end;
    fprintf('   + b11* Fan4a              (Current value: %10.6f)',bhat(12));
    newvalue = input(' New value? ');
    if isempty(newvalue) == 0
        bhat(12) = newvalue;
    end;
    fprintf('   + b12* fan4b              (Current value: %10.6f)',bhat(13));
    newvalue = input(' New value? ');
    if isempty(newvalue) == 0
        bhat(13) = newvalue;
    end;
    fprintf('   + b13* Fan5a              (Current value: %10.6f)',bhat(14));
    newvalue = input(' New value? ');
    if isempty(newvalue) == 0
        bhat(14) = newvalue;
    end;
    fprintf('   + b14* Fan_5b            (Current value: %10.6f)',bhat(15));
    newvalue = input(' New value? ');
    if isempty(newvalue) == 0
        bhat(15) = newvalue;
    end;
    fprintf('   + b15* fsb_scaled        (Current value: %10.6f)',bhat(16));
    newvalue = input(' New value? ');
    if isempty(newvalue) == 0
        bhat(16) = newvalue;
    end;
    fprintf('   + b16* l2miss_scaled     (Current value: %10.6f)',bhat(17));
    newvalue = input(' New value? ');
    if isempty(newvalue) == 0
        bhat(17) = newvalue;
    end;
    fprintf('   + b17* disk_read_kbytes   (Current value: %10.6f)',bhat(18));
    newvalue = input(' New value? ');
    if isempty(newvalue) == 0
        bhat(18) = newvalue;
    end;
    fprintf('   + b18* disk_write_kbytes  (Current value: %10.6f)',bhat(19));
    newvalue = input(' New value? ');
    if isempty(newvalue) == 0
        bhat(19) = newvalue;
    end;
    fprintf('After adjustment:\n')
    fprintf('%2d %10.4f + \n',coeff(1),bhat(1));
    for i = 2:size(bhat)
        fprintf('%2d %10.4f +  %s\n',coeff(i),bhat(i),varStrings{i});    
    end;
else
    fprintf('No change in bhat values\n');
end;


