#!/bin/bash

IPMICMD="ipmitool -c sdr"

for i in `$IPMICMD type temperature | sed 's/ /_/g'`
do
    DESC=` echo $i | awk -F, '{print $1}' `
    VALUE=` echo $i | awk -F, '{print $2}'`
    HDR=` echo $HDR $DESC `
    LINE=` echo $LINE $VALUE `
done

for i in `$IPMICMD type voltage | sed 's/ /_/g' `
do
    DESC=` echo $i | awk -F, '{print $1}'`
    VALUE=` echo $i | awk -F, '{print $4}'`
    HDR=` echo $HDR $DESC `
    LINE=` echo $LINE $VALUE `
done

for i in `$IPMICMD type fan | grep -i '^fan' | sed 's/ /_/g'`
do
    DESC=` echo $i | awk -F, '{print $1}'`
    VALUE=` echo $i | awk -F, '{print $2}' `
    HDR=` echo $HDR $DESC `
    LINE=` echo $LINE $VALUE `
done

#echo $HDR
echo $LINE

