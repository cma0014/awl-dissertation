#
# File:	 	Makefile
# Author:	Adam Lewis
# Copyright:	(c)2006, The University of Louisiana at Lafayette, All rights reserved.
#
CFLAGS=-g -DSOLARIS
INSTDEST=/opt/wattsup
#CC=gcc
#LFLAGS = lstdc++
#CFLAGS="-O2 -Wall -Wno-format"
#INSTDEST = /usr/local/bin
#LFLAGS = -lpq

all: resetWU downloadData 

resetWU: resetWU.c 
	$(CC) $(CFLAGS) -o $@ resetWU.c

downloadData: downloadData.c 
	$(CC) $(CFLAGS) -o $@ downloadData.c  $(LFLAGS) 

clean:
	rm -f *.o resetWU downloadData 

install:
	mkdir -p $(INSTDEST)
	cp downloadData resetWU $(INSTDEST)
