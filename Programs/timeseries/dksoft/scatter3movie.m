function scatter3movie(data,taubegin,tauend,symbol);
%SCATTER3MOVIE(data,taubegin,tauend,symbol);
%Makes a 3 dimensional movie of the scatter plots from
%scatter(data,taubegin,symbol) to scatter(data,tauend,symbol) 
%with symbols ('.' '+' '*' '-').
%Optional:  symbol,  if not specified uses '.'
%it plays the movie 5 times


if (nargin<3)|(nargin>5) error(' SCATTER3MOVIE(data,taubegin,tauend,symbol)');
end;
if isstr(data)|isstr(taubegin)|isstr(tauend) 
error(' SCATTERMOVIE(data,taubegin,tauend,symbol)');end;

if nargin==3 symbol='.';end;

taubegin=taubegin-1;
step=tauend-taubegin;

scatter3(data,taubegin+1,symbol); %otherwise getframe error!!

M=moviein(step);

 for j=1:step

     scatter3(data,j+taubegin,symbol);
     xlabel('x(t)');
     ylabel('x(t+tau)');
     zlabel('x(t+2*tau)'); 
     t=num2str(j+taubegin);
     text(max(data),max(data),max(data),['tau = ' t]);
     M(:,j)=getframe;
end;
t1=num2str(taubegin+1);t2=num2str(tauend);
title(['3 dim.scatter plot from tau=' t1 ' to tau=' t2]);
xlabel('x(t)');
ylabel('x(t+tau)');
zlabel('x(t+2*tau)');
movie(M,-5,8)