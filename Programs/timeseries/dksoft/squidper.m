function [v,stim] = squidper( isi, amp, dur, num )
% [v,stim] = squidper( isi, amp, dur, num )
% Stimulates a model of the Squid Giant Axon with
% a single pulse of amplitude <amp> and duration <dur>
% returns the voltage sampled at 100 samples per time unit
% Copyright (c) 1996 by D. Kaplan, All Rights Reserved

stims=zeros(num,3);
for k=1:num
stims(k,1) = 5 + k*isi;
stims(k,2) = amp;
stims(k,3) = dur;
end
save /tmp/stims1 stims -ascii

a = stims(num,1) + 20;
eval(['! /ssnd/bin/hh ' num2str(a) ' 1 < /tmp/stims1 > /tmp/res.dat']);
load /tmp/res.dat;
v = res(:,3);
stim = res(:,2);




