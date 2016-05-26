fig1=figure()
dep=[bzip2.ProcPwr cactusadm.ProcPwr gromac.ProcPwr lbm.ProcPwr  omnetpp.ProcPwr perlbench.ProcPwr];
plot(bzip2.Time,dep);
legend('bzip2','cactusadm','gromac','lbm','omnetpp','perlbench');
axis([0 2100 60 75]);
xlabel('Time (s)');
ylabel('Processor Power (w)');
%
fig2=figure();
depw=[bzip2.Watts cactusadm.Watts gromac.Watts lbm.Watts omnetpp.Watts perlbench.Watts];
plot(bzip2.Time,depw);
legend('bzip2','cactusadm','gromac','lbm','omnetpp','perlbench');
xlabel('Time (s)');
ylabel('System Power Consumption (w)');
axis([0 2100 200 245]);
%
tempc0=[bzip2.CPU_0_Temp cactusadm.CPU_0_Temp gromac.CPU_0_Temp lbm.CPU_0_Temp  omnetpp.CPU_0_Temp perlbench.CPU_0_Temp];
tempc1=[bzip2.CPU_1_Temp cactusadm.CPU_1_Temp gromac.CPU_1_Temp lbm.CPU_1_Temp  omnetpp.CPU_1_Temp perlbench.CPU_1_Temp];
fig3=figure();
plot(bzip2.Time,tempc0);
legend('bzip2','cactusadm','gromac','lbm','omnetpp','perlbench');
xlabel('Time (s)');
ylabel('CPU 0 Temperature (degC)');
legend('bzip2','cactusadm','gromac','lbm','omnetpp','perlbench');
axis([0 2100 35 55]);
%
fig4=figure();
plot(bzip2.Time,tempc1);
legend('bzip2','cactusadm','gromac','lbm','omnetpp','perlbench');
xlabel('Time (s)');
ylabel('CPU 1 Temperature (degC)');
legend('bzip2','cactusadm','gromac','lbm','omnetpp','perlbench');
axis([0 2100 35 55]);

fig5=figure();
dc=[overall.ProcPwr overall.CPU_0_Temp overall.CPU_1_Temp];
plot(overall.Time,dc);
xlabel('Time (s)');
ylabel('CPU 1 Temperature (degC)');
legend('ProcPwr','CPU0 Temp','CPU1 Temp');
axis([0 2100 30 80]);

fig6=figure();
dc=[overall.ProcPwr overall.Ambient_Temp0 overall.Ambient_Temp1];
plot(overall.Time,dc);
xlabel('Time (s)');
ylabel('Temperature (degC) & Proc. Power (w)');
legend('ProcPwr','Ambient Temp0','Ambient Temp1');
axis([0 2100 30 80]);

