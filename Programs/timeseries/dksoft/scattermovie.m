function scattermovie(data,taubegin,tauend,symbol);
%SCATTERMOVIE(data,taubegin,tauend,symbol);
%makes a movie of the scatter plots from
%scatter(data,taubegin) to scatter(data,tauend) with symbols ('.' '+' '*' '-')
%Optional: taubegin, if not specified  starts with taubegin=1;
%	   symbol,  if not specified uses '.'
%it plays the movie 5 times


if (nargin<3)|(nargin>5) 
error(' SCATTERMOVIE(data,taubegin,tauend,symbol)');end;
if isstr(data)|isstr(taubegin)|isstr(tauend) 
error(' SCATTERMOVIE(data,taubegin,tauend,symbol)');end;

if nargin<4 symbol='.';end;

taubegin=taubegin-1;
step=tauend-taubegin;

scatter(data,taubegin+1,symbol); %otherwise getframe error!!

M=moviein(step);

 for j=1:step

     scatter(data,j+taubegin,symbol);
     t=num2str(j+taubegin);
     text(min(data)+(max(data)-min(data))/2,min(data),['tau = ' t]);
     M(:,j)=getframe;
end;
t1=num2str(taubegin+1);t2=num2str(tauend);
title(['Scatter plot from tau=' t1 ' to tau=' t2]);
xlabel('x(t)');
ylabel('x(t+tau)');
movie(M,-5,8) 
