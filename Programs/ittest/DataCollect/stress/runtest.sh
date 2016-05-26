#!/bin/bash
#
# File:    runtest.sh
# Author:  awl8049
#
if [ $# == 0 ] ; then
	echo "Usage: runtest RUNID RUNTIME INTERVAL"
        echo "   Make certain that you include the parameters"
        exit
fi
if [ $1 == "-h" ] ; then
	echo "Usage: runtest RUNID RUNTIME INTERVAL"
        echo "   RUNID: where to store data"
        echo "   RUNTIME: time in seconds to collect data"
        echo "   INTERVAL: time between samples"
        exit
fi
RUNID=$1
RUNTIME=$2
INTERVAL=$3
ARCH=$4
#
# Commands for gathering data.
#
EXEDIR=/opt/wattsup
IPMICMD=$EXEDIR/gatheripmi.sh
PMCCMD=$EXEDIR/gatherpmc.sh
#
# Create directory for storing data. Use the RunId as name
#
mkdir -p $RUNID
#
# Tell people what we're doing.
#
START=`date +%H:%M`
echo "Starting data collection for $RUNID at $START" | tee $RUNID/$RUNID.log
#
# Reset power meter
#
echo "Resetting power meter..." | tee -a $RUNID/$RUNID.log
$EXEDIR/resetWU -i $INTERVAL
#
# Starting collection of IPMI data
#
echo "Collection of IPMI data started" | tee -a $RUNID/$RUNID.log
$IPMICMD $RUNTIME $INTERVAL > $RUNID/$RUNID.ipmi.txt &
#
# Starting collection of PMC data
#
echo "Collection of PMC data started" | tee -a $RUNID/$RUNID.log
$PMCCMD $RUNTIME $INTERVAL $ARCH > $RUNID/$RUNID.pmc.txt &
#
# Now sleep until ready get power data
#
echo "Now going to sleep for a bit" | tee -a $RUNID/$RUNID.log
sleep $RUNTIME
echo "Waiting for data collection to catch up." | tee -a $RUNID/$RUNID.log
wait
echo "OK...I'm back." | tee -a $RUNID/$RUNID.log
#
# Downloading data from the power meter
#
FINISH=`date +%H:%M`
$EXEDIR/downloadData $RUNID | tee -a $RUNID/$RUNID.powerdata.txt
echo "Data collection complete at $FINISH" | tee -a $RUNID/$RUNID.log
