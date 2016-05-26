#!/bin/bash
IPMICMD="ipmitool -c sdr"
RUNTIME=$1
INTERVAL=$2
#START=$(( 10#$(date +%H)*3600 + 10#$(date +%m) * 60 + 10#$(date +%S) ))
#END=$(( $START + $RUNTIME ))
#TIME=$(( 10#$(date +%H)*3600 + 10#$(date +%m) * 60 + 10#$(date +%S) ))
NSAMPLES=$(( $RUNTIME / $INTERVAL ))
COUNT=0
FIRST="a"
while [ $COUNT -lt $NSAMPLES ]
do
    HDR=""
    LINE=""
    # Get values for the temperatures
    for i in `$IPMICMD type temperature | sed 's/ /_/g'`
    do
	DESC=` echo $i | awk -F, '{print $1}' `
	VALUE=` echo $i | awk -F, '{print $2}'`
	HDR=` echo $HDR $DESC `
	LINE=` echo $LINE $VALUE `
    done
    # Now deal with  output and loop stuff
    if [ $FIRST == "a" ]
    then
    	echo $HDR
    	FIRST="nope"
    fi
    #echo $HDR
    echo $LINE
    sleep $INTERVAL
    #TIME=$(( 10#$(date +%H)*3600 + 10#$(date +%m) * 60 + 10#$(date +%S) ))
    COUNT=$(( $COUNT + 1 ))
done
