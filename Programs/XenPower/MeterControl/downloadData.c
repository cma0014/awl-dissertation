/*
 * File:	downloadData.c
 * Purpose:	Download data from the Watts Up? Power Meter
 * Copyright:	(c) 2006, The University of Louisiana at Lafayette, All rights reserved.
 */

#include <stdio.h>
#include <string.h>
#include <unistd.h>
#include <fcntl.h>
#include <errno.h>
#include <termios.h>
#include <getopt.h>

#include "dbfunc.h"

#define WUGETDATA "#D,R,0;"
#define WUSTOPLOG "#L,R,0;"
#define WATTSUP_PORT "/dev/ttyUSB0"

// Header Line contents
int sampleInterval;
int numOfDataLines;

// Data line contents
int watts;
int volts;
int amps;
int wattHrs;
int cost;
int moKwHrs;
int moCost;
int maxWatts;
int maxVolts;
int maxAmps;
int minWatts;
int minVolts;
int minAmps;
int factor;
int dutyCycle;
int powerCycle;

// Trailer Line Contents
int endSampleInterval;

enum states {header, data, trailer, end, error} state = header;
unsigned int dataLines = 0;

//FIXME: file name length can be greater than 255 characters.
char sourceFile[256];
int logToDB = 1;

char runId[256];

/*
 * openMeter():
 * Open the device file where meter is connected.
 */
FILE *openMeter(char *deviceName)
{
  FILE *fd;
  if ((fd = fopen(deviceName,"rb+")) == NULL)
  {
    fprintf(stderr,"openMeter: Open of device %s failed.\n",deviceName);
  }
  return fd;
}
/*
 * closeMeter(int fd):
 * Close the power meter by closing the associated file descriptor.
 */
void closeMeter(FILE *fd)
{
  fclose(fd);
}

/*
 * writeMeter(fd,command)
 * Write a command to the power meter.
 */
int writeMeter(FILE *fd, char *command)
{
  int n = EOF;
  if (fd != NULL)
  {
    n = fputs(command, fd);
    if (n == EOF)
    {
      fputs("writeMeter: Unable to write command to meter",stderr);
    }
  }
  return n;
}

/*
 * logSummaryToDatabase()
 * Use the header information to log summary data about the experiment.
 */
void logSummaryToDatabase()
{
  char queryString[1024];
  memset(queryString, 0, 1024);
  sprintf(queryString,
	  "INSERT INTO experiment_summary (runId, sampleInterval) VALUES (\'%s\',%d)",runId,sampleInterval);
  dbExecute(queryString);
}
/*
 * processHeader(fd):
 * Read and process a header line from the source.
 */
int processHeader(FILE *fd)
{
  int reserve;
  int numItemsRead =
  fscanf(fd,
	 "#n,-,3,%d,%d,%d;\n",
	 &reserve,
	 &sampleInterval,
	 &numOfDataLines
	 );
  if ((numItemsRead == EOF) || (numItemsRead < 3))
  {
    return error;
  }
  if (logToDB == 1)
  {
    logSummaryToDatabase();
  }
  printf("RunId,SeqNum,Watts,Amps,WattHours,Cost,MoKWh,MoCost,MaxWatts,MaxVolts,MaxAmps,MinWatts,MinVolts,MinAmps,Factor,DutyCycle,PowerCycle\n");
  return data;
}

/*
 * logDataToDatabase()
 */
void logDataToDatabase()
{
  char queryString[1024];
  memset(queryString,0,1024);
  sprintf(queryString,"INSERT INTO experiment_data (runid,sequenceNumber,watts,volts,amps,watthrs,cost,moKwHrs,moCost,maxWatts,maxVolts,maxAmps,minWatts,minVolts,minAmps,factor,dutyCycle,powerCycle) VALUES (\'%s\',%d,%d,%d,%d,%d,%d,%d,%d,%d,%d,%d,%d,%d,%d,%d,%d,%d)",
	  runId,
	  dataLines,
	  watts,
	  volts,
	  amps,
	  wattHrs,
	  cost,
	  moKwHrs,
	  moCost,
	  maxWatts,
	  maxVolts,
	  maxAmps,
	  minWatts,
	  minVolts,
	  minAmps,
	  factor,
	  dutyCycle,
	  powerCycle);
  dbExecute(queryString);
}
/*
 * processData(fd)
 * Read and process a data line from the source.
 */
int processData(FILE *fd)
{
  int numItemsRead =
    fscanf(fd,
	   "#d,-,16,%d,%d,%d,%d,%d,%d,%d,%d,%d,%d,%d,%d,%d,%d,%d,%d;\n",
	   &watts,
	   &volts,
	   &amps,
	   &wattHrs,
	   &cost,
	   &moKwHrs,
	   &moCost,
	   &maxWatts,
	   &maxVolts,
	   &maxAmps,
	   &minWatts,
	   &minVolts,
	   &minAmps,
	   &factor,
	   &dutyCycle,
	   &powerCycle);
  if ((numItemsRead == EOF) || (numItemsRead < 16))
  {
    return error;
  }
  if (logToDB == 1)
  {
    logDataToDatabase();
  }
  printf(
    "%s,%d,%d,%d,%d,%d,%d,%d,%d,%d,%d,%d,%d,%d,%d,%d,%d,%d;\n",
    runId,
    dataLines,
    watts,
    volts,
    amps,
    wattHrs,
    cost,
    moKwHrs,
    moCost,
    maxWatts,
    maxVolts,
    maxAmps,
    minWatts,
    minVolts,
    minAmps,
    factor,
    dutyCycle,
    powerCycle);
  dataLines++;
  if (dataLines == numOfDataLines)
  {
    return trailer;
  }
  return data;
}

/*
 * processTrailer(fd)
 * Read and process a trailer line from the source.
 */
int processTrailer(FILE *fd)
{
  int reserve;
  int numItemsRead =
  fscanf(fd,
	 "#l,-,2,%d,%d;",
	 &reserve,
	 &endSampleInterval);
  if ((numItemsRead == EOF) || (numItemsRead < 2))
  {
    return error;
  }
  return end;
}


/*
 * readFromMeter(fd)
 * Read the data from the power meter.
 */
void readFromMeter(FILE *fd)
{
  do
  {
    switch (state)
    {
    case header:
      state = processHeader(fd);
      break;
    case data:
      state = processData(fd);
      break;
    case trailer:
      state = processTrailer(fd);
      break;
    case error:
      fputs("readFromMeter: data read error",stderr);
      break;
    case end:
      break;
    default:
      fputs("readFromMeter: Something really bad has happened",stderr);
      state = error;
    }
  }
  while ((state != error) && (state != end));
  printf("Processed %d lines from power meter\n",dataLines);
}

/*
 * displayHelp():
 * Write a help message to stdout.
 */
void displayHelp()
{
  printf("downloadData <s device_name> <-n> <-h> runName\n");
  printf("Download data from the WattsUp Power Meter\n");
  printf("Options:\n");
  printf("-s filename : Read data from this device.\n");
  printf("-n          : Do not log data to PostgreSQL databse.\n");
  printf("-h          : Display this help message.\n");
}

/*
 * main(argc, argv):
 * Main driver for program.
 */
int main(int argc, char **argv)
{
  int nc = -1;
  FILE *fd;
  int ch;
  // Process command line options to see how to modify what we do
  memset(sourceFile,0,256);
  strcpy(sourceFile,WATTSUP_PORT);
  while ((ch = getopt(argc,argv, "s:nh")) != -1)
  {
    switch (ch)
    {
    case 's':
      // User wants to use a different device that the default USB serial port
      // So, we have to clear the file name and get the new name from the cmd line.
      memset(sourceFile,0,256);
      strcpy(sourceFile,optarg);
      break;
    case 'n':
      logToDB = 0;
      break;
    case 'h':
      displayHelp();
      return -1;
    }
  }
  argc -= optind;
  argv += optind;
  // Get the run identifier from the command line
  if (argc == 0)
  {
    fprintf(stderr,"downloadData.main(): Error, no run identifier given on the command line.\n");
    return -1;
  }
  else
  {
    memset(runId,0,256);
    strcpy(runId,argv[0]);
  }
  // Now we get the data from the power meter.
  fd = openMeter(sourceFile);
  if (fd != NULL)
  {
    nc = writeMeter(fd,WUGETDATA);
    if (nc != EOF)
    {
      readFromMeter(fd);
    }
  }
  return(0);
}
