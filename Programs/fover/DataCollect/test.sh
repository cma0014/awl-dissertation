#!/bin/bash
#TESTPLAN="./vmpowermgt.jmx"
TESTPLAN="./vpm2.jmx"
RRDLOC="/usr/local/share/ganglia/canvmpower"
#MACHINS="canv20z01.cacs.louisiana.edu canv20z02.cacs.louisiana.edu canv20z03.cacs.louisiana.edu canpe01.cacs.louisiana.edu"
MACHINES="canv20z01.cacs.louisiana.edu canv20z02.cacs.louisiana.edu canpe01.cacs.louisiana.edu"
SENSORS="ambienttemp.rrd cpu0.dietemp.rrd cpu1.dietemp.rrd cpu0.memtemp.rrd cpu3.memtemp.rrd gbeth.temp.rrd hddbp.temp.rrd"
SYSTEM="bytes_in.rrd bytes_out.rrd cpu_aidle.rrd cpu_idle.rrd cpu_nice.rrd cpu_num.rrd cpu_system.rrd cpu_user.rrd load_fifteen.rrd load_five.rrd load_one.rrd mem_cached.rrd mem_shared.rrd mem_total.rrd"
echo "DATA COLLECTION RUN: $1" | tee $1/runinfo.txt
echo Now resetting power meters on each test server
for i in $MACHINES ;
do
    echo "	Resetting power meter on $i"
    ssh $i resetWU
done
mkdir $1
START=`date +%H:%M`
echo Starting jmeter test run at $START | tee -a $1/runinfo.txt
jmeter -n -t $TESTPLAN -l $1/jmeterout.txt
FINISH=`date +%H:%M`
echo $FINISH | tee -a $1/runinfo.txt
echo "jmeter test run finished at $FINISH" | tee -a $1/runinfo.txt
echo "Downloading power meter data"
for i in $MACHINES ;
do
    ( ssh $i downloadData $1 ) > $1/$i.powerdata.txt
done
echo "Extracting data from Ganglia RRD datafiles" | tee -a $1/runinfo.txt
for i in $MACHINES ;
do
  if [ "$i" != "canpe01.cacs.louisiana.edu" ] ; then
      for j in $SENSORS ;
      do
	  echo "	Dumping sensor data from $i from log $j" | tee -a $1/runinfo.txt
	  echo ./dumprrd.sh $RRDLOC $i $j $START $FINISH | tee -a $1/runinfo.txt
	  ./dumprrd.sh $RRDLOC $i $j $START $FINISH >> $1/summary.txt
      done
  fi
  for j in $SYSTEM ;
  do
    echo "	Dumping system data from $i from log $j" | tee -a $1/runinfo.txt
    echo ./dumprrd.sh $RRDLOC $i $j $START $FINISH | tee -a $1/runinfo.txt
    ./dumprrd.sh $RRDLOC $i $j $START $FINISH >> $1/summary.txt
  done
done
