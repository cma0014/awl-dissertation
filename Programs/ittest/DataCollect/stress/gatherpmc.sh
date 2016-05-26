#!/bin/bash
#
# File:   gatherpmc.sh
# Auhor:  awl8049
#
RUNTIME=$1
INTERVAL=$2
ARCH=$3
COUNT=$(( RUNTIME / INTERVAL ))
# Define the two PMCs that we're going to track
if [ $ARCH == "intel" ] ; then
	PMC0="pic0=bus_tran_any,umask=0x20"
	PMC1="pic1=l2_rqsts,umask=0x4f"
	echo "pic0: $PMC0"
	echo "pic1: $PMC1"
	cpustat -c $PMC0,$PMC1 $INTERVAL $COUNT
else
	PMC0="pic0=NB_ht_bus1_bandwidth,umask0=0x01"
	PMC1="pic1=NB_ht_bus1_bandwidth,umask=0x02"
	PMC2="pic2=NB_ht_bus1_bandwidth,umask=0x04"
	PMC3="pic3=NB_ht_bus1_bandwidth,umask=0x08,sys"
	echo "pic0: $PMC0"
	echo "pic1: $PMC1"
	echo "pic2: $PMC2"
	echo "pic3: $PMC3"
	cpustat -c $PMC0,$PMC1,$PMC2,$PMC3 $INTERVAL $COUNT
fi
