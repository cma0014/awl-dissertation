#!/bin/bash
#
# File:   gatherpmc.sh
# Auhor:  awl8049
#
INTERVAL=$1
ARCH=$2
# Define the two PMCs that we're going to track
if [ $ARCH == "intel" ] ; then
	PMC0="pic0=bus_tran_any,umask=0x20"
	PMC1="pic1=l2_rqsts,umask=0x4f"
	echo "pic0: $PMC0"
	echo "pic1: $PMC1"
	cpustat -c $PMC0,$PMC1 $INTERVAL
else
	PMC0="pic0=NB_ht_bus0_bandwidth,umask0=0x07"
	PMC1="pic1=NB_ht_bus1_bandwidth,umask=0x07"
	PMC2="pic2=NB_ht_bus2_bandwidth,umask=0x07"
 	PMC3="pic3=DC_refill_from_L2,sys"
#	PMC0="pic0=NB_ht_bus0_bandwidth,umask0=0x0f"
#	PMC1="pic1=NB_ht_bus1_bandwidth,umask=0x0f"
#	PMC2="pic2=NB_ht_bus2_bandwidth,umask=0x0f,sys"
# 	PMC3="pic3=NB_ht_bus1_bandwidth,umask=0x08,sys"
	echo "pic0: $PMC0"
	echo "pic1: $PMC1"
	echo "pic2: $PMC2"
	echo "pic3: $PMC3"
	cpustat -c $PMC0,$PMC1,$PMC2,$PMC3 $INTERVAL 
fi
