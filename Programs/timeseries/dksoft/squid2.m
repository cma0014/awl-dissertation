function v = squid2( amp1, dur1, interval, amp2, dur2 )
% v = squid2( amp1, dur1, interval, amp2, dur2 )
% does 2-pulse stimulation of the squid model
% amp1, dur1 --- amplitude, duration  of the first pulse
% interval --- interval between the start of the two pulses
% amp2, dur2 --- amplitude, duration  of the second pulse
% Copyright (c) 1996 by D. Kaplan, All Rights Reserved

a = 5 + dur1 + dur2 + interval + 30;
stims=zeros(2,3);
stims(1,1) = 5;
stims(1,2) = amp1;
stims(1,3) = dur1;
stims(2,1) = 5 + interval;
stims(2,2) = amp2;
stims(2,3) = dur2;
save /tmp/stims2 stims -ascii
eval(['! /ssnd/bin/hh ' num2str(a) ' 1 < /tmp/stims2 > /tmp/res.dat']);
load /tmp/res.dat;
v = res(:,3);


