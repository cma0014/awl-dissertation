#!/bin/bash
#
# File:   sysstats.sh
# Auhor:  awl8049
#

kill `ps -ef | grep cpustat | nawk '{print $2}'`
kill `ps -ef | grep iostat | nawk '{print $2}'` 
kill `ps -ef | grep vmstat | nawk '{print $2}'` 
SARLIST=`ps -ef | grep sar | nawk '{print $2}'`
for i in $SARLIST
do
    kill $i
done
