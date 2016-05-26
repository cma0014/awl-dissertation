function bhat = adjustAmdBhats(bhat)
% adjsutBhats(bhat)
%       Adjust the values of the bhats
varStrings = {' ',...
              'Ambient_Temp0',...
              'Ambient_Temp1',...
              'CPU_0_Temp',  ...
              'CPU_1_Temp', ...
              'HT1Scaled', ...
              'HT2Scaled', ...
              'cmiss_core0_scaled', ...
              'cmiss_core1_scaled', ...
              'cmiss_core2_scaled', ...
              'cmiss_core3_scaled' ...
              'disk_read_kbytes' ... 
              'disk_write_kbytes', ...
              'Axial_Fan_0',...
              'Axial_Fan_1', ...
              'Blower_Fan_0', ...
              'Blower_Fan_1'};
coeff = 1:length(varStrings);
fprintf('\nOverriding...\n');
bhat(1) = 0.1;
bhat(4) = 0.489;
bhat(5) = 0.501;
bhat(12)=0.014;
bhat(13)=0.007;
bhat(14)=0.0012;
bhat(15)=0.0007;
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
    fprintf('   + b1 * Ambient_Temp0      (Current value: %10.6f)',bhat(2));
    newvalue = input(' New value? ');
    if isempty(newvalue) == 0
        bhat(2) = newvalue;
    end;
    fprintf('   + b2 * Ambient_Temp1      (Current value: %10.6f)',bhat(3));
    newvalue = input(' New value? ');
    if isempty(newvalue) == 0
        bhat(3) = newvalue;
    end;
    fprintf('   + b3 * CPU_0_Temp         (Current value: %10.6f)',bhat(4));
    newvalue = input(' New value? ');
    if isempty(newvalue) == 0
        bhat(4) = newvalue;
    end;
    fprintf('   + b4 * CPU_1_Temp        (Current value: %10.6f)',bhat(5));
    newvalue = input(' New value? ');
    if isempty(newvalue) == 0
        bhat(5) = newvalue;
    end;
    fprintf('   + b5 * HT1Scaled         (Current value: %10.6f)',bhat(6));
    newvalue = input(' New value? ');
    if isempty(newvalue) == 0
        bhat(6) = newvalue;
    end;
    fprintf('   + b6 * HT2Scaled          (Current value: %10.6f)',bhat(7));
    newvalue = input(' New value? ');
    if isempty(newvalue) == 0
        bhat(7) = newvalue;
    end;
    fprintf('   + b7 * cmiss_core_scaled0 (Current value: %10.6f)',bhat(8));
    newvalue = input(' New value? ');
    if isempty(newvalue) == 0
        bhat(8) = newvalue;
    end;
    fprintf('   + b8 * cmiss_core_scaled1 (Current value: %10.6f)',bhat(9));
    newvalue = input(' New value? ');
    if isempty(newvalue) == 0
        bhat(9) = newvalue;
    end;
    fprintf('   + b9 * cmiss_core_scaled2 (Current value: %10.6f)',bhat(10));
    newvalue = input(' New value? ');
    if isempty(newvalue) == 0
        bhat(10) = newvalue;
    end;
    fprintf('   + b10* core_core_scaled3  (Current value: %10.6f)',bhat(11));
    newvalue = input(' New value? ');
    if isempty(newvalue) == 0
        bhat(11) = newvalue;
    end;
    fprintf('   + b11* disk_read_kbytes   (Current value: %10.6f)',bhat(12));
    newvalue = input(' New value? ');
    if isempty(newvalue) == 0
        bhat(12) = newvalue;
    end;
    fprintf('   + b12* disk_write_kbytes  (Current value: %10.6f)',bhat(13));
    newvalue = input(' New value? ');
    if isempty(newvalue) == 0
        bhat(13) = newvalue;
    end;
    fprintf('   + b13* Axial_Fan_0        (Current value: %10.6f)',bhat(14));
    newvalue = input(' New value? ');
    if isempty(newvalue) == 0
        bhat(14) = newvalue;
    end;
    fprintf('   + b14* Axial_Fan_1       (Current value: %10.6f)',bhat(15));
    newvalue = input(' New value? ');
    if isempty(newvalue) == 0
        bhat(15) = newvalue;
    end;
    fprintf('   + b15* Blower_Fan_0      (Current value: %10.6f)',bhat(16));
    newvalue = input(' New value? ');
    if isempty(newvalue) == 0
        bhat(16) = newvalue;
    end;
    fprintf('   + b16* Blower_Fan_1     (Current value: %10.6f)',bhat(17));
    newvalue = input(' New value? ');
    if isempty(newvalue) == 0
        bhat(17) = newvalue;
    end;
else
    fprintf('No adjustments made\n');
end;
fprintf('After adjustment:\n')
fprintf('%2d %10.4f + \n',coeff(1),bhat(1));
for i = 2:size(bhat)
    fprintf('%2d %10.4f +  %s\n',coeff(i),bhat(i),varStrings{i});
end;



