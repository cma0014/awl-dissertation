
/*
 * File:    simulsvr.c
 * Author:  awl8049
 */


#include <stdio.h>
#include <stdlib.h>
#include <stdarg.h>
#include <errno.h>
#include <string.h>
#include <unistd.h>
#include <fcntl.h>
#include <errno.h>
#include <getopt.h>
#include <ctype.h>
#include <time.h>

#define FILENAME_SIZE 1024
#define SENSOR_DELAY 5
#define NCPUS 4

char destfile[FILENAME_SIZE] = "/tmp/reading";
char datafile[FILENAME_SIZE];
FILE *dFile;
unsigned int wdebug = 0;
unsigned int dataDumpInProgress = 1;
unsigned int delay = SENSOR_DELAY;


// Temperature measuresments
unsigned int timestamp;
unsigned int core0temp;
unsigned int core1temp;
unsigned int amb0temp;
unsigned int amb1temp;
// Fan speeds
unsigned int blowerFan0;
unsigned int blowerFan1;
unsigned int axialFan0;
unsigned int axialFan1;
// HT measurements
unsigned int ht0_0;
unsigned int ht0_1;
unsigned int ht0;
unsigned int ht1_0;
unsigned int ht1_1;
unsigned int ht1;
unsigned int ht2_0;
unsigned int ht2_1;
unsigned int ht2;
// cache miss rate
unsigned int cache_sample0;
unsigned int cache_sample1;
unsigned int cache_sample2;
unsigned int cache_sample3;

/*
 * void dbg(cost char *frm, ...)
 * Write debug output to stdout if option has been set
 */
void dbg(const char *fmt, ...)
{
  va_list ap;
  if (wdebug)
  {
    va_start(ap,fmt);
    vfprintf(stderr,fmt,ap);
    va_end(ap);
  }
}

/*
 * void myerror(const char *frm, ...)
 * Write debug output to stdout if option has been set
 */
void myerror(const char *fmt, ...)
{
  va_list ap;
  va_start(ap,fmt);
  vfprintf(stderr,fmt,ap);
  va_end(ap);
}

/*
 * displayHelp():
 * Write a help message to stdout.
 */
void displayHelp()
{
  printf("downloadData <-ii > <-d> <-h> datafile\n");
  printf("Replay a set of measurements from a previous run\n");
  printf("Options:\n");
  printf("-i delay    : Wait delay seconds betwen updates instead of default.\n");
  printf("-d          : Print debug information\n");
  printf("-h          : Display this help message.\n");
}

/*
 * void skipALine()
 * Get a sample from the data file.
 */
void skipALine()
{
  int errCode;
  char buffer[1024];
  char *currentToken;
  char *locationInBuffer;
  memset(buffer,1024,0);
  if ( fgets((char *)buffer,1024, dFile) == NULL)
  {
    if (feof(dFile))
    {
      fclose(dFile);
      dataDumpInProgress = 0;
    }
    else if (ferror(dFile))
    {
      fclose(dFile);
      dataDumpInProgress = 0;
      myerror("%s\n","simulsvr: Error reading input file.");
    }
  }
}

/*
 * void getSample()
 * Get a sample from the data file.
 */
void getSample()
{
  int errCode;
  char buffer[1024];
  char *currentToken;
  char *locationInBuffer;
  memset(buffer,1024,0);
  if ( fgets((char *)buffer,1024, dFile) == NULL)
  {
    if (feof(dFile))
    {
      fclose(dFile);
      dataDumpInProgress = 0;
    }
    else if (ferror(dFile))
    {
      fclose(dFile);
      dataDumpInProgress = 0;
      myerror("%s\n","simulsvr: Error reading input file.");
    }
  }
  else
  {
    locationInBuffer = (char *) buffer;
    // get the first one to skip the timestamp
    currentToken = strtok(locationInBuffer,",");
    // Now repeat the process for rest of the stuff we're interested in
    currentToken = strtok(NULL,",");
    core0temp = atoi(currentToken);
    currentToken = strtok(NULL,",");
    core1temp = atoi(currentToken);
    currentToken = strtok(NULL,",");
    amb0temp = atoi(currentToken);
    currentToken = strtok(NULL,",");
    amb1temp = atoi(currentToken);
    // Get the fan data
    currentToken = strtok(NULL,",");
    blowerFan0 = atoi(currentToken);
    currentToken = strtok(NULL,",");
    blowerFan1 = atoi(currentToken);
    currentToken = strtok(NULL,",");
    axialFan0 = atoi(currentToken);
    currentToken = strtok(NULL,",");
    axialFan1 = atoi(currentToken);
    // Skip the two raw values for HyperTransport
    currentToken = strtok(NULL,",");
    currentToken = strtok(NULL,",");
    currentToken = strtok(NULL,",");
    ht0 = atoi(currentToken);
    currentToken = strtok(NULL,",");
    currentToken = strtok(NULL,",");
    currentToken = strtok(NULL,",");
    ht1 = atoi(currentToken);
    currentToken = strtok(NULL,",");
    currentToken = strtok(NULL,",");
    currentToken = strtok(NULL,",");
    ht2 = atoi(currentToken);
    currentToken = strtok(NULL,",");
    cache_sample0 = atoi(currentToken);
    currentToken = strtok(NULL,",");
    cache_sample1 = atoi(currentToken);
    currentToken = strtok(NULL,",");
    cache_sample2 = atoi(currentToken);
    currentToken = strtok(NULL,",");
    cache_sample3 = atoi(currentToken);
  }
}

/*
 * char buildTimeStamp()
 * Create the time stamp used by the kernel code for sequencing readings.
 */
char * buildTimeStamp()
{
  struct tm *tmp;
  time_t t;
  char *buffer = (char *) malloc(1024);
  memset(buffer,1024,0);
  t = time(NULL);
  tmp = localtime(&t);
  sprintf(buffer,"%02d%02d%04d%02d%02d%02d",
	  tmp->tm_mday,
	  tmp->tm_mon+1,
	  tmp->tm_year+1900,
	  tmp->tm_hour,
	  tmp->tm_min,
	  tmp->tm_sec);
  return((char *)buffer);
}

/*
 * char *tempstr()
 * Return back a string of temperature readings.
 */
char *tempstr()
{
  int error;
  char *buffer = (char *)malloc(1024);
  memset(buffer,1024,0);
  sprintf(buffer,"T %d %d %d %d",
	    core0temp,
	    core1temp,
	    amb0temp,
	    amb1temp);
  return((char *)buffer);
}

/*
 * char *fanstr()
 * Return a string with fan speeds.
 */
char *fanstr()
{
  char *buffer = (char *)malloc(1024);
  memset(buffer,1024,0);
  sprintf(buffer,"F %d %d %d %d",
	  blowerFan0,
	  blowerFan1,
	  axialFan0,
	  axialFan1);
  return ((char *)buffer);
}

/*
 * char *pmcstr()
 * Return a string with pmc readings.
 */
char *pmcstr()
{
  int i,j,k;
  char *buffer = (char *)malloc(1024);
  memset(buffer,1024,0);
  sprintf(buffer,"H %d %d %d\tC %d %d %d %d",
	  ht0,ht1,ht2,
	  cache_sample0,cache_sample1,cache_sample2,cache_sample3);
  return((char *) buffer);
}

/*
 * char *kstatsr()
 * Return a string with kstat readings.
 */
char *kstatsr()
{
  return(NULL);
}

/*
 * int processArgs(int argc, void *argv[])
 * Process command line arguments.
 */
int processArgs(int argc, char **argv)
{
  char ch;
  while ((ch = getopt(argc,argv, "i:dh")) != -1)
  {
    switch (ch)
    {
    case 'd':
      wdebug = 1;
      break;
    case 'i':
      // User wants to use a diferent delay than the default 5 seconds
      delay = atoi(optarg);
      break;
    case 'h':
      displayHelp();
      return -1;
    }
  }
  argc -= optind;
  argv += optind;
  // Get the run identifier from the command line
  dbg("main(): Getting run id from command line\n");
  if (argc == 0)
  {
    myerror("simulsvr:processArgs(): Error, no run identifier given on the command line.\n");
    return -1;
  }
  else
  {
    memset(datafile,0,FILENAME_SIZE);
    strcpy(datafile,argv[0]);
  }
  return 0;
}

/*
 * main(argc, argv)
 * Server driver program
 */
int
main(int argc, char **argv)
{
  double data;
  FILE * rFile;
  char *stringToPrint;
  int rtnCode = 0;
    if ((rtnCode = processArgs(argc, argv)) == 0) {
      dataDumpInProgress = 1;
      dFile = fopen(datafile,"r");
      if (dFile == NULL)
      {
	myerror("simulsvr: Unable to open data file for reading\n");
	exit(1);
      }
      skipALine(); // deals with the header
      while (dataDumpInProgress) {
	getSample();
	rFile = fopen(destfile,"w");
	if (rFile == NULL)
	{
	  myerror("simulsvr: Unable to open destination file for writing.\n");
	  exit(1);
	}
	// timestamp
	stringToPrint = buildTimeStamp();
	fprintf(rFile,"%s ", stringToPrint );
	printf("%s ", stringToPrint );
	// temperatures
	stringToPrint = tempstr();
	fprintf(rFile,"%s ",stringToPrint);
	printf("%s ", stringToPrint );
	// fan speeds
	stringToPrint = fanstr();
	fprintf(rFile,"%s ",stringToPrint);
	printf("%s ", stringToPrint );
	// performance counters
	stringToPrint = pmcstr();
	fprintf(rFile,"%s ",stringToPrint);
	printf("%s ", stringToPrint );
	// line terminator
	fprintf(rFile,"\n");
	printf("\n");
	fclose(rFile);
	// wait, then lather, rinse, repeat
	sleep(delay);
      }
    }
}
