
ht0dTime = xlsread('longbusy1.xls','HT0DataAnalysis','A5:A110')
ht0dProc0 = xlsread('longbusy1.xls','HT0DataAnalysis','B5:B110')
ht0dProc1 = xlsread('longbusy1.xls','HT0DataAnalysis','C5:C110')

ht0dAmbTemp =  xlsread('longbusy1.xls','HT0DataAnalysis','H5:H110')
ht0dP0dieTemp = xlsread('longbusy1.xls','HT0DataAnalysis','I5:I110')
ht0dP0memTemp = xlsread('longbusy1.xls','HT0DataAnalysis','J5:J110 ')
ht0dP1dieTemp = xlsread('longbusy1.xls','HT0DataAnalysis','K5:K110')
ht0dP1memTemp = xlsread('longbusy1.xls','HT0DataAnalysis','L5:L110')
ht0dNetTemp = xlsread('longbusy1.xls','HT0DataAnalysis','M5:M110')
ht0dDiskTemp = xlsread('longbusy1.xls','HT0DataAnalysis','N5:N110')
ht0dSPTemp = xlsread('longbusy1.xls','HT0DataAnalysis','O5:O110')


[X,Y] = meshgrid(ht0dTime,ht0dP0dieTemp)
Z = griddata(ht0dTime,ht0dP0dieTemp,ht0dProc0,X,Y);

surface(X,Y,Z)
colorbar
