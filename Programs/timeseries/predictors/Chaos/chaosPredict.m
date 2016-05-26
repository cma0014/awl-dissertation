% Input:
%   Data: Time series data set.
%
function chaosPredict(data)
close all

sc=data;
tsc=(1:length(data))';
sigma_l=std(diff(sc(1:end-388))); %sigma for the learn set (to normalize prediction error)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%for j=1:100,
  Y=diff(sc)/sigma_l;%difference removes trend and systematic error in data
  figure;subplot(211);plot(tsc,sc);ylabel('Composite')
  subplot(212);
 plot(tsc(2:end),Y);ylabel('Differences')
 
 w=3;%dimension
  Ft=[];Fe=[]; 
for k=389:-1:0,
      n=0;  
 y0=fs01(Y(1:end-k),w);
     
  
  yy0=((([Y(1:end-k);y0])*sigma_l));%
  try
  yyt=((([Y(1:end-k+1)])*sigma_l));%
catch
    %disp('last point')
    yyt=0;
  
end

Ft=[Ft yyt(end)];%
Fe=[Fe yy0(end)];

end%for
%disp('Average normalized prediction error')
%ET=std(Ft(1:end-1)-Fe(1:end-1))/sigma_l
figure;plot(tsc(end-388:end),Ft(1:end-1),'-k.',[tsc(end-388:end); 413],Fe,'-bo')
ylabel('Difference');legend('Actual','Predicted')
xlabel('Years')
%disp('correlation in differences')
%Cd=corrcoef(Ft(1:end-1),Fe(1:end-1))
figure;plot(tsc(end-388:end),sc(end-388:end),'g.',[tsc(end-388:end); 413],sc(end-389:end)+Fe(1:end)','b-')
ylabel('ProcPwr');legend('Actual','Predicted')
xlabel('Time')
    
    x = sc(end-388:end);
    est = sc(end-389:end)+Fe(1:end)';
    
    error = 0;
MEAN = 0;
MEDIAN = 0;
STD = 0;
VAR = 0;
PERR = 0;
    error = abs(est(end-389:end) - mean(x));
    MEAN = MEAN + mean(error)
    MEDIAN = MEDIAN + median(error)
    STD = STD + std(error)
    VAR = VAR + var(error)
    PERR = PERR + (abs(mean(x) - mean(est)))/mean(x)
%disp('correlation in values')
%Cv=corrcoef(sc(end-388:end),sc(end-389:end-1)+Fe(1:end-1)')
end