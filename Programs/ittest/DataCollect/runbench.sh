#!/bin/bash
#
# File:    runbench.sh
# Author:  awl8049
#
if [ $# == 0 ] ; then
	echo "Usage: $0 RUNID INTERVAL ARCHITECTURE BENCHMARK"
        echo "   Make certain that you include the parameters"
        exit
fi
if [ $1 == "-h" ] ; then
	echo "Usage: $0 RUNID INTERVAL ARCHITECTURE BENCHMARK"
        echo "   RUNID: where to store data"
        echo "   INTERVAL: time between samples"
	echo "   ARCHITECTURE: Which set of perf. counters to use (intel or amd)"
	echo "   BENCHMARK: SPEC CPU2006 benchmark to execute"
        exit
fi
RUNID=$1
INTERVAL=$2
ARCH=$3
BENCHMARK=$4
#
# Commands for gathering data.
#
EXEDIR=/opt/wattsup
IPMICMD=$EXEDIR/gatheripmi.sh
PMCCMD=$EXEDIR/gatherpmc.sh
SYSSTATCMD=$EXEDIR/sysstats.sh
BENCHCMD=$EXEDIR/benchcmd.sh
CLEANCMD=$EXEDIR/cleanup.sh
#
# Sleep intervals.
#
PRESLEEP=300
POSTSLEEP=600
#
# Create directory for storing data. Use the RunId as name
#
mkdir -p $RUNID
#
# Tell people what we're doing.
#
START=`date +%H:%M`
echo "Starting data collection for $RUNID at $START" | tee $RUNID/$RUNID.log
echo "This data is for $BENCMARK on the $ARCH architecture."| tee $RUNID/$RUNID.log
echo "The sample interval is $INTERVAL seconds" | tee $RUNID/$RUNID.log
#
# Reset power meter
#
echo "Resetting power meter..." | tee -a $RUNID/$RUNID.log
$EXEDIR/resetWU -i $INTERVAL
#
# Starting collection of IPMI data
#
echo "Collection of IPMI data started" | tee -a $RUNID/$RUNID.log
$IPMICMD $INTERVAL > $RUNID/$RUNID.ipmi.txt &
IMPICMDPID=$!
#
# Starting collection of PMC data
#
echo "Collection of PMC data started" | tee -a $RUNID/$RUNID.log
$PMCCMD $INTERVAL $ARCH > $RUNID/$RUNID.pmc.txt &
PMCCMDPID=$!
#
# Starting collection of system statistics
#
echo "Collection of system statistics started" | tee -a $RUNID/$RUNID.log
$SYSSTATCMD $INTERVAL $RUNID  > $RUNID/$RUNID.sysstat.txt &
SYSSTATPID=$!
#
# So, let's sleep for a pre-determined amount of time to let
# machine stablize at a certain temperature
#
echo "Sleeping for ${PRESLEEP} seconds to let everyone settle" | tee -a $RUNID/$RUNID.log
sleep $PRESLEEP
#
# Run the benchmark
#
BSTART=`date +%H:%M`
echo "And now we start the $BENCHMARK benchmark at $BSTART" | tee -a $RUNID/$RUNID.log
$BENCHCMD $BENCHMARK
BEND=`date +%H:%M`
echo "The $BENCHMARK benchmark has completed at $BEND" | tee -a $RUNID/$RUNID.log
#
# Now we sleep again for a bit to allow the machine to cool down.
#
echo "Sleeping for ${POSTSLEEP} secondsto allow the machine to cool down." | tee -a $RUNID/$RUNID.log
sleep $POSTSLEEP
echo "Now shutdowning the data collection utilities." | tee -a $RUNID/$RUNID.log
kill $IMPICMDPID >> $RUNID/$RUNID.log
kill $PMCCMDPID >> $RUNID/$RUNID.log
kill $SYSSTATPID >> $RUNID/$RUNID.log
#
# Explicitly kill cpustat and/or cputrack in case above kill failed
#
$CLEANCMD | tee -a $RUNID/$RUNID.log
#echo "OK...I'm back, and now I'm downloading the power data" | tee -a $RUNID/$RUNID.log
#
# Downloading data from the power meter
#
FINISH=`date +%H:%M`
#echo $EXEDIR/downloadData $RUNID | tee -a $RUNID/$RUNID.powerdata.txt
echo "Data collection complete at $FINISH" | tee -a $RUNID/$RUNID.log
