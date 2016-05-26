function xfershow(input,output)
% XFERSHOW shows the psd of the input and output,
%   as well as the transfer function and the coherence


subplot(2,2,1)
psd(input,256,1);
title('Input');
xlabel(' ');
ylabel('In PSD');

subplot(2,2,2)
psd(output,256,1);
title('Output');
xlabel(' ');
ylabel('Out PSD');

subplot(2,2,3)
tfe(input,output,256,1);
title('Transfer Function');
ylabel('Log Amp');

subplot(2,2,4)
cohere(input,output,256,1);
title('Coherence Function');
ylabel('Coh^2');