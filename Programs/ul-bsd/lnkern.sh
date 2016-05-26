#!/bin/sh
# File:       lnkern.sh
# Author:     awl8049
# Revision:   $Revision: 1.3 $
#
# Purpose:
# Link our changes and additions into the kernel directory tree.
#
cd /usr/src/sys/amd64/conf
ln -s /home/awl8049/dissertation/vmpowermgt/Programs/ul-bsd/sys/amd64/conf/AWLDEV
cd /usr/src/sys/i386/conf
ln -s /home/awl8049/dissertation/vmpowermgt/Programs/ul-bsd/sys/i386/conf/AWLDEV
cd /usr/src/sys/kern
ln -s /home/awl8049/dissertation/vmpowermgt/Programs/ul-bsd/sys/kern/sched_awl.c
ln -s /home/awl8049/dissertation/vmpowermgt/Programs/ul-bad/sys/kern/sched_awl_support.c
cd /usr/src/sys/conf
mv files files.org
ln -s /home/awl8049/dissertation/vmpowermgt/Programs/ul-bsd/sys/conf/files
mv options options.org
ln -s /home/awl8049/dissertation/vmpowermgt/Programs/ul-bsd/sys/conf/options
