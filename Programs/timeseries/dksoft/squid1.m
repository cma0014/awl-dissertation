function v = squid1( amp, dur )
% v = squid1( amp, dur )
% Stimulates a model of the Squid Giant Axon with
% a single pulse of amplitude <amp> and duration <dur>
% returns the voltage sampled at 100 samples per time unit
% Copyright (c) 1996 by D. Kaplan, All Rights Reserved

a = 5 + dur + 30;
stims=zeros(1,3);
stims(1) = 5;
stims(2) = amp;
stims(3) = dur;
save /tmp/stims1 stims -ascii
eval(['! /ssnd/bin/hh ' num2str(a) ' 1 < /tmp/stims1 > /tmp/res.dat']);
load /tmp/res.dat;
v = res(:,3);





