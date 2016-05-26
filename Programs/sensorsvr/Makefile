#
# File:	 	Makefile
# Author:	Adam Lewis
# Copyright:	(c)2009, The University of Louisiana at Lafayette, All rights reserved.
#
CC     = cc
CFLAGS = -g
IPMILIB= -lipmi
CPCLIB = -lcpc
KSLIB = -lkstat

all: sensorsvr simulsvr

sensorsvr: sensorsvr.c temps.c temps.h pmcfuncs.c strtoset.c pmcfuncs.h
	$(CC) $(CFLAGS) $(IPMILIB) $(CPCLIB) -o $@ sensorsvr.c temps.c pmcfuncs.c strtoset.c 

simulsvr: simulsvr.c 
	$(CC) $(CFLAGS) -o $@ simulsvr.c 

clean: 
	rm -f *.o simulsvr sensorsvr

install:
	cp simulsvr sensorsvr /usr/local/bin
