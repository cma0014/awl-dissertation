uiimport('spectest4.csv')
[X,Y]=meshgrid(Time,cpu0dietemp)
Z=griddata(Time,cpu0dietemp,HTLinkUtil,X,Y)
surfc(X,Y,Z)
