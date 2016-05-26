/*
 * File:	downloadData.c
 * Purpose:	Download data from the Watts Up? Power Meter
 * Copyright:	(c) 2006, The University of Louisiana at Lafayette, All rights reserved.
 */

#include <stdio.h>
#include <stdlib.h>
#include <stdarg.h>
#include <errno.h>
#include <string.h>
#include <unistd.h>
#include <fcntl.h>
#include <errno.h>
#include <termios.h>
#include <getopt.h>

/* #include "dbfunc.h" */

#define WUGETDATA "#D,R,0;"
#define WUSTOPLOG "#L,R,0;"

#define WUCLEARMEM "#R,W,0;"
#define WUSTART "#L,W,3,I,0,10;"

/*
 * Communication parameters
 * The communciation paramters vary between Solaris and Linux.  Setup the
 * default speed depending upon whether we have an older meter connected
 * serially to Solaris or a newer meter connected to a Linux box on the USB
 * port
 */
#ifdef SOLARIS
#define WATTSUP_PORT "/dev/term/a"
int portSpeed = B9600;
enum mtypes {serial,usb} metertype = serial;
unsigned int numItems = 16;
#else
#define WATTSUP_PORT "/dev/ttyUSB0"
int portSpeed = B115200;
enum mtypes {serial,usb} metertype = usb;
unsigned int numItems = 18;
#endif
int flowControl = ~CRTSCTS;

/*
 * The buffer size tells you how many characters to get from the serial port.
 */
unsigned int bufsize = 1024;

/*
 * Processing the data from the data is implemented using a state machine
 * implemented using an enum.   We aslo keep track of the number of data lines
 * read from the meter.
 */
enum states {header, data, trailer, end, error, formatProblem} state = header;
unsigned int dataLines = 0;
unsigned int numOfDataLines = 0;
unsigned int headerItems = 2;

/*
 * Here's where we define the source of the data and the tag for the data.
 */
char sourceFile[256];
char runId[256];

unsigned int wudebug = 0;


/*
 * In this section, we define the exact data read from the meter.
 *
 * Header Line contents
 */
int sampleInterval;
int num;
/*
 * Data line contents
 */
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
int hertz;
int va;
/*
 * Trailer Line Contents
 */
int endSampleInterval;

/*
 * dbg(string)
 * Write debug output to stdout if option has been set
 */
void dbg(const char *fmt, ...)
{
  va_list ap;
  if (wudebug)
  {
    va_start(ap,fmt);
    vfprintf(stderr,fmt,ap);
    va_end(ap);
  }
}

/*
 * openMeter():
 * Open the device file where meter is connected.
 */
FILE *openMeter(char *deviceName)
{
  int fd;
  FILE *pfd = NULL;
  // Open the port using the low level functions and condition the line.
  dbg("openMeter(): Opening power meter on device %s \n",deviceName);
  struct termios tios;
  if ((fd = open(deviceName, O_RDWR)) == -1)
  {
    fprintf(stderr,"openMeter: Open of device %s failed.\n",deviceName);
  }
  // Now here's where we do the communications black magic to get to the serial port.
  dbg("openMeter(): Using tc functions to condition serial line\n");
  memset(&tios,0,sizeof(tios));
  tcgetattr(fd,&tios);
  // Have to do the following by hand because Solaris doesn't have
  // cfmakeraw.
  //
  // cfmakeraw(&tios);
  dbg("openMeter(): Setup the serial port for raw output\n");
  tios.c_iflag &= ~(IGNBRK | BRKINT | PARMRK | ISTRIP
                          | INLCR | IGNCR | ICRNL | IXON);
  tios.c_oflag &= ~OPOST;
  tios.c_lflag &= ~(ECHO | ECHONL | ICANON | ISIG | IEXTEN);
  tios.c_cflag &= ~(CSIZE | PARENB);
  tios.c_cflag |= CS8;
  cfsetispeed(&tios, portSpeed);
  cfsetospeed(&tios, portSpeed);
  tcflush(fd, TCIFLUSH);
  // Setup the serial line to ignore parity, no stop bit, and be 8 data bits
  dbg("openMeter(): Setting up line to ignore parity, no stop bit, and be 8 data bits\n");
  tios.c_iflag |= IGNPAR;
  tios.c_cflag &= ~CSTOPB;
  tios.c_cflag &= ~CSIZE;
  tios.c_cflag |= CS8;
  // Turn off all flow control
  tios.c_cflag &= flowControl;
  tios.c_cflag |= CREAD| CLOCAL;
  tios.c_iflag &= ~(IXON | IXOFF |IXANY);
  if (tcsetattr(fd,TCSANOW,&tios) == -1)
    {
      close(fd);
      fd = -1;
      fprintf(stderr,"openMeter: Unable to set parity and stop bits on %s.\n",deviceName);
    }
  else 
    {
      // At this point everything has worked and we can now associate the low
      // level integer file descriptor with a FILE pointer.
      dbg("openMeter():Line conditioned and opening file\n");
      pfd = fdopen(fd,"r+");
      if (pfd == NULL)
	{
	  fprintf(stderr,"openMeter: Conversion to file descriptor failed on %s.",deviceName);
	}
    }
  return pfd;
}
/*
 * closeMeter(int fd):
 * Close the power meter by closing the associated file descriptor.
 */
void closeMeter(FILE *fd)
{
  dbg("closeMeter(): closing serial line.\n");
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
 * resetMeterFromError():
 * Tell the meter to reset when an error occurs
 */
void resetMeterFromError(int fd)
{
  // Major error has occurred so tell the meter to stop transmitting.
  // You do this by writing a control X to the device.
  char ctrlx[2];
  memset(ctrlx,0,2);
  ctrlx[0] = (char)0x18;
  writeMeter(fd,(char *)&ctrlx);
}

/*
 * processHeader(fd):
 * Read and process a header line from the source.
 */
int processHeader(FILE *fd)
{
  int numItemsRead;
  int dummy;
  char buf[bufsize];
  dbg("processHeader(): Set up buffer for data read.\n");
  memset(buf,0,bufsize);
  fgets(buf,bufsize,fd);
  dbg("processHeader(): Scanning buffer to see if meter returned header\n");
  if (metertype == usb)
  {
    numItemsRead =   sscanf(buf,
			    "#n,-,3,_,%d,%d;\r\n",
			    &sampleInterval,
			    &numOfDataLines
			    );
  }
  else
  {
    numItemsRead =   sscanf(buf,
			    "#n,-,3,%d,%d,%d;\r\n",
			    &dummy,
			    &sampleInterval,
			    &numOfDataLines
			    );
  }
  if ((numItemsRead == EOF) || (numItemsRead < headerItems))
  {
    fprintf(stderr,"processHeader(): Read error in header. Expected %d, got %d\n",headerItems,numItemsRead);
    fprintf(stderr,"processHeader(): Offending data buffer is \n%s\n",buf);
    return error;
  }
  dbg("processHeader(): Sanity check passed, correctly read header from meter\n");
  printf("RunId,NumDataLines,SeqNum,Watts,Amps,WattHours,Cost,MoKWh,MoCost,MaxWatts,MaxVolts,MaxAmps,MinWatts,MinVolts,MinAmps,Factor,DutyCycle,PowerCycle\n");
  return data;
}

/*
 * processData(fd)
 * Read and process a data line from the source.
 */
int processData(FILE *fd)
{
  char buf[bufsize];
  int numItemsRead;
  int numErrors = 0;
  dbg("processData(): Set up buffer for data read.\n");
  memset(buf,0,bufsize);
  fgets(buf,bufsize,fd);
  dbg("processData(): Scanning buffer to see if meter delievered good data\n");
  if (metertype == usb)
  {
    numItemsRead =
      sscanf(buf,
	     "#d,-,18,%d,%d,%d,%d,%d,%d,%d,%d,%d,%d,%d,%d,%d,%d,%d,%d,%d,%d;\n",
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
	     &powerCycle,
	     &hertz,
	     &va);
  }
  else
  {
    numItemsRead =
      sscanf(buf,
	     "#d,-,16,%d,%d,%d,%d,%d,%d,%d,%d,%d,%d,%d,%d,%d,%d,%d,%d,%d,%d;\n",
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
    hertz = 0;
    va = 0;

      }
  if (numItemsRead < numItems)
  {
    fprintf(stderr,"processData: Less input read than expected at data line %d, expected %d, got %d.\n",
	    dataLines,
	    numItems,
	    numItemsRead
	    );
    fprintf(stderr,"processData: Data buffer contents: \n%s\n",buf);
    return formatProblem;
  }
  dbg("processData(): Data passed sanity check, correctly read data\n");
  printf(
    "%s,%d,%d,%d,%d,%d,%d,%d,%d,%d,%d,%d,%d,%d,%d,%d,%d,%d,%d,%d,%d\n",
    runId,
    numOfDataLines,
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
    powerCycle,
    hertz,
    va);
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
  char buf[bufsize];
  int reserve;
  int numItemsRead;
  dbg("processTrailer(): Set up buffer for reading data\n");
  memset(buf,0,bufsize);
  fgets(buf,bufsize,fd);
  dbg("processTrailer(): Scanning buffer to see if correctly read trailer\n");
  numItemsRead =
  sscanf(buf,
	 "#l,-,2,%d,_,%d;",
	 &reserve,
	 &endSampleInterval);
  if ((numItemsRead == EOF) || (numItemsRead < 2))
  {
    return error;
  }
  dbg("processTrailer(): Data passed sanity check, trailer correctly read\n");
  return end;
}


/*
 * readFromMeter(fd)
 * Read the data from the power meter.
 */
void readFromMeter(FILE *fd)
{
  int numErrors = 0;
  dbg("readFromMeter(): starting state machine\n");
  do
  {
    switch (state)
    {
    case header:
      dbg("readFromMeter(): State machine in header state\n");
      state = processHeader(fd);
      break;
    case data:
      dbg("readFromMeter(): State machine in data state\n");
      state = processData(fd);
      break;
    case trailer:
      dbg("readFromMeter(): State machine in trailer state\n");
      state = processTrailer(fd);
      break;
    case error:
      dbg("readFromMeter(): State machine in error state\n");
      fputs("readFromMeter: data read error",stderr);
      resetMeterFromError(fd);
      break;
    case end:
      dbg("readFromMeter(): State machine reached end state, terminating.\n");
      break;
    case formatProblem:
      dbg("readFromMeter(): A line in bad format was read from meter\n");
      numErrors++;
      state= processData(fd);
      break;
    default:
      fputs("readFromMeter: Something really bad has happened",stderr);
      state = error;
    }
  }
  while ((state != error) && (state != end));
  printf("Processed %d lines from power meter\n",dataLines);
  printf("There were %d errors in reading from the meter\n",numErrors);
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
  printf("-b buf size : Size of data buffer used for reading data\n");
  printf("-L          : Communicate with meter at 9.6kbps rather 115.2kbps\n");
  printf("-H          : Communciate with meter at 115.2kbps\n");
  printf("-r          : Use RTS/CTS hardware flow control\n");
  printf("-0          : Meter is a WattsUP type 0 (serial, 16 entries in data row)\n");
  printf("-1          : Meter is a WattsUP type 1 (usb, 18 entries in data row)\n");
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
  dbg("main(): processing program options\n");
  memset(sourceFile,0,256);
  strcpy(sourceFile,WATTSUP_PORT);
  while ((ch = getopt(argc,argv, "s:b:hdHLr01")) != -1)
  {
    switch (ch)
    {
    case 's':
      // User wants to use a different device that the default USB serial port
      // So, we have to clear the file name and get the new name from the cmd line.
      memset(sourceFile,0,256);
      strcpy(sourceFile,optarg);
      break;
    case 'b':
      bufsize = atoi(optarg);
      dbg("main(): Set buffer size to %d\n",bufsize);
      break;
    case 'd':
      wudebug = 1;
      break;
    case 'L':
      portSpeed = B9600;
      break;
    case 'H':
      portSpeed = B115200;
      break;
    case 'r':
      flowControl = CRTSCTS;
      break;
    case '0':
      metertype = serial;
      numItems = 16;
      headerItems = 3;
      break;
    case '1':
      metertype = usb;
      numItems = 18;
      headerItems = 2;
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
    fprintf(stderr,"downloadData.main(): Error, no run identifier given on the command line.\n");
    return -1;
  }
  else
  {
    memset(runId,0,256);
    strcpy(runId,argv[0]);
  }
  // Now we get the data from the power meter.
  dbg("main(): Attempting to open the meter\n");
  fd = openMeter(sourceFile);
  if (fd != NULL)
  {
    dbg("main(): Attempt to write get data command to meter\n");
    nc = writeMeter(fd,WUGETDATA);
    if (nc != EOF)
    {
      dbg("main(): Attempt to read data from meter\n");
      readFromMeter(fd);
    }
  }
  dbg("main(): processing complete, program exiting\n");
  return(0);
}
