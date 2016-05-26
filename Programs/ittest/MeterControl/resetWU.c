/*
 * File:	resetWU.c
 * Purpose:	Reset the power meter
 * Copyright:	(c) 2006, The University of Louisiana at Lafayette, All rights reserved.
 */

#include <stdio.h>
#include <stdlib.h>
#include <stdarg.h>
#include <getopt.h>
#include <string.h>
#include <unistd.h>
#include <fcntl.h>
#include <errno.h>
#include <termios.h>

#define _POSIX_SOURCE 1
#ifdef SOLARIS
#define DEVICE "/dev/term/a"
#else
#define DEVICE "/dev/ttyUSB0"
#endif

#define WUCLEARMEM "#R,W,0;"
#define WUSTART "#L,W,3,I,0,10;"
#define WUSTARTNOINT "#L,W,3,I,0,"
int portSpeed = B115200;
char sourceFile[256];
char restartStr[80];
int wudebug = 0;

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
 * displayHelp():
 * Write a help message to stdout.
 */
void displayHelp()
{
  printf("downloadData <s device_name> <-n> <-h> runName\n");
  printf("Download data from the WattsUp Power Meter\n");
  printf("Options:\n");
  printf("-s filename : Read data from this device.\n");
  printf("-L          : Communicate with meter at 9.6Kbps rather 115Kbps\n");
  printf("-H          : Communicate with meter at 115kbps\n");
  printf("-d          : Display debug information\n");
  printf("-h          : Display this help message.\n");
}

int main(int argc, char **argv)
{
  int fd;
  int ch;
  int nClear, nStart;
  struct termios tios;
  dbg("main(): processing program options\n");
  memset(sourceFile,0,256);
  strcpy(sourceFile,DEVICE);
  memset(restartStr,0,80);
  strcpy(restartStr,WUSTART);

  while ((ch = getopt(argc,argv, "s:LHdhi:")) != -1)
  {
    switch (ch)
    {
    case 's':
      // User wants to use a different device that the default USB serial port
      // So, we have to clear the file name and get the new name from the cmd line.
      memset(sourceFile,0,256);
      strcpy(sourceFile,optarg);
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
    case 'i':
      // User wants to use a different interval than the default
      // So, we clear the starting value and get the new value from
      // the command-line options.
      memset((char *)&restartStr,0,80);
      strcpy((char *)&restartStr,WUSTARTNOINT);
      strcat((char *)&restartStr,optarg);
      strcat((char *)&restartStr,";");
      fprintf(stderr,"Restart string now set to %s\n",restartStr);
      break;
    case 'h':
      displayHelp();
      return -1;
    }
  }
  argc -= optind;
  argv += optind;
  dbg("main(): Opening device \n");
  fd = open(DEVICE, O_RDWR | O_NOCTTY | O_NDELAY);
  memset(&tios,0,sizeof(tios));
  /*
   * Setup the serial port to be 8N1 with no flow control.
   */
  dbg("main(): Configuring serial port\n");
  tios.c_cflag = CLOCAL | CREAD | CS8;
  tios.c_cflag &= ~CSIZE;
  tios.c_cflag &= ~CSTOPB;
  tios.c_cflag &= ~CRTSCTS;
  tios.c_iflag &= ~(IXON| IXOFF |IXANY);
  tios.c_iflag |= IGNPAR;
  tios.c_oflag = 0;
  tios.c_lflag = IEXTEN | ICANON;
  if ((cfsetispeed(&tios,portSpeed) == -1) && (cfsetospeed(&tios,portSpeed) == -1))
    {
      close(fd);
      fprintf(stderr,"resetWU: Unable to set speed on %s.\n",DEVICE);
    }
  else if (tcsetattr(fd,TCSANOW,&tios) == -1)
    {
      close(fd);
      fprintf(stderr,"resetWU: Unable to set parity and stop bits on %s.\n",DEVICE);
    }
  else
  {
    dbg("main(): Writing clear and restart to power meter\n");
    fcntl(fd, F_SETFL, 0);
    //Write
    nClear = write(fd, WUCLEARMEM, strlen(WUCLEARMEM));
    if (nClear >= 0)
    {
      nStart = write(fd, (char *)&restartStr, strlen((char *)&restartStr));
      if (nStart < 0)
      {
	fputs("resetWU: Unable to write start string to power meter", stderr);
	return(1);
      }
    }
    else
    {
      fputs("resetWU: Unable to write memory clear string to power meter",stderr);
      return(1);
    }
    close(fd);
  }
  return 0;
}
