#!/bin/bash
#
# File:   sysstats.sh
# Auhor:  awl8049
#
INTERVAL=$1
RUNID=$2
echo "Now starting to log iostat data" | tee -a $RUNID/$RUNID.log
iostat -xtc 5 > $RUNID/$RUNID.iostat.log &
echo "Now starting to log vmstat data" | tee -a $RUNID/$RUNID.log
vmstat  5 > $RUNID/$RUNID.vmstat.log &
echo "Now starting to log page fault data" | tee -a $RUNID/$RUNID.log
sar -g 5 1000 > $RUNID/$RUNID.pgfalut.log &
echo "Now starting to log krenel memory allocation data" | tee -a $RUNID/$RUNID.log
sar -k 5 1000 > $RUNID/$RUNID.kmemalloc.log &
echo "Now starting to log disk data" | tee -a $RUNID/$RUNID.log
sar -d 5 1000 > $RUNID/$RUNID.disk.log &
