#!/bin/bash
WORKLOADLOCATION=$PWD
REPORTLOCATION=$PWD/reports
RUNSTART=`date +%m%d%Y.%H%M.%S`
REPORTNAME="$REPORTLOCATION/Workload$1.$RUNSTART"
NAMEOFRUN=$1.$RUNSTART
METERCONTROL=$PWD/../MeterControl
DBSCRIPTS=$PWD/../DBScripts
# Need to note the location of the file as the silly SPEC benchmarks have to be
# run from their install directory.
WORKLOADFILE=$PWD/$1

echo "Run of simulated workload $1 started at $RUNSTART" | tee $REPORTNAME

cd /local/software/SPEC_CPU2000
#$METERCONTROL/resetWU
echo "#R,W,0;">/dev/ttyUSB0
echo "#L,W,3,I,0,1;">/dev/ttyUSB0
source shrc
# each benchmark file will be of the form
#     machine_name test
#     machine_name test2
#     machine_name test3
#     machine_name test4
#
numberofworkloads=1
while read machine program; do
    case $machine in
    debug)
     echo "Calling debug statement" | tee -a $REPORTNAME
     /usr/bin/time -f %e echo $machine $program 2>/tmp/${numberofworkloads}.out 
     ;;
    canpe)
     echo "Starting $program benchmark" | tee -a $REPORTNAME
     nohup ${WORKLOADLOCATION}/runlocal.sh $numberofworkloads $program  &
     ;;
    *)
     echo "Starting ${i[$j+1]} benchmark" | tee -a $REPORTNAME
     nohup ${WORKLOADLOCATION}/runremote.sh $numberofworkloads $machine $program &
    ;;
    esac
  let numberofworkloads=numberofworkloads+1
done < $WORKLOADFILE

echo "Waiting for benchmarks to complete"
wait
RUNEND=`date +%m%d%Y.%H%M.%S`
echo "Run of simulated workload $1 completed at $RUNEND" | tee -a $REPORTNAME
$METERCONTROL/downloadData $NAMEOFRUN | tee -a $REPORTNAME
# Insert the process runtime into the database
workload=1
while [ $workload -lt $numberofworkloads ] ;
 do
    cat $DBSCRIPTS/insertruntime.sql | sed "s/%RUNID%/$NAMEOFRUN/g;s/%WORKLOAD%/${workload}/g;s/%RUNTIME%/`cat /tmp/${workload}.out`/g" | psql -d xenpower -U xenpower | tee -a $REPORTNAME
    let workload=workload+1
done
# Update the runstats summary table
# A template PostgreSQL UPDATE command is kept in the collectstats script.
cat $DBSCRIPTS/collectstats.sql | sed "s/%RUNNAME%/$NAMEOFRUN/g" | psql -d xenpower -U xenpower | tee -a $REPORTNAME
#
# Cleanup
#rm /tmp/1.out /tmp/2.out /tmp/3.out /tmp/4.out
