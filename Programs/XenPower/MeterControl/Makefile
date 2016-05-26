#
# File:	 	Makefile
# Author:	Adam Lewis
# Copyright:	(c)2006, The University of Louisiana at Lafayette, All rights reserved.
#
CC     = gcc
#LFLAGS = lstdc++
#CFLAGS = -O2 -Wall -Wno-format
CFLAGS = -g -Wall -Wno-format
LFLAGS = -lpq

all: resetWU downloadData 

resetWU: resetWU.c 
	$(CC) $(CFLAGS) -o $@ resetWU.c

downloadData: downloadData.c dbfunc.c dbfunc.h
	$(CC) $(CFLAGS) -o $@ downloadData.c dbfunc.c $(LFLAGS)

clean: 
	rm -f *.o resetWU downloadData dbfunc.o
