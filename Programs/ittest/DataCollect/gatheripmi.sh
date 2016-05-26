#!/bin/bash
IPMICMD="ipmitool -c sdr"
INTERVAL=$1
#
# Run forever until whomever starts us remembers to kill us
COUNT=0
TIMESTAMP=0
FIRST="a"
while true
do
    HDR="Time"
    LINE="$TIMESTAMP"
    # Get values for the temperatures
    for i in `$IPMICMD type temperature | sed 's/ /_/g'`
    do
	DESC=` echo $i | awk -F, '{print $1}' `
	VALUE=` echo $i | awk -F, '{print $2}'`
	HDR=` echo $HDR $DESC `
	LINE=` echo $LINE $VALUE `
    done
    # Get values for the volatages
#   for i in `$IPMICMD type voltage | sed 's/ /_/g' `
#   do
#	DESC=` echo $i | awk -F, '{print $1}'`
#	VALUE=` echo $i | awk -F, '{print $4}'`
#	HDR=` echo $HDR $DESC `
#	LINE=` echo $LINE $VALUE `
#   done
    # Get values for the fans
    for i in `$IPMICMD type fan | grep -i 'fan' | sed 's/ /_/g'`
    do
	DESC=` echo $i | awk -F, '{print $1}'`
	VALUE=` echo $i | awk -F, '{print $2}' `
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
    TIMESTAMP=$(( $TIMESTAMP + $INTERVAL ))
    COUNT=$(( $COUNT + 1 ))
done
