/*
 * File:	resetWU.c
 * Purpose:	Reset the power meter
 * Copyright:	(c) 2006, The University of Louisiana at Lafayette, All rights reserved.
 */

#include <stdio.h>
#include <string.h>
#include <unistd.h>
#include <fcntl.h>
#include <errno.h>
#include <termios.h>

#define _POSIX_SOURCE 1

#define WUCLEARMEM "#R,W,0;"
#define WUSTART "#L,W,3,I,0,10;"

int main(int argc, char **argv)
{
  int fd;
  int nClear, nStart;
  fd = open("/dev/ttyS0", O_RDWR | O_NOCTTY | O_NDELAY);
  if (fd != -1)
  {
    fcntl(fd, F_SETFL, 0);
    //Write
    nClear = write(fd, WUCLEARMEM, strlen(WUCLEARMEM));
    if (nStart >= 0)
    {
      nStart = write(fd, WUSTART, strlen(WUSTART));
      if (nStart < 0)
      {
	fputs("Unable to write start string to power meter", stderr);
	return(1);
      }
    }
    else
    {
      fputs("Unable to write memory clear string to power meter",stderr);
      return(1);
    }
    close(fd);
  }
  else
  {
    perror("resetWU: Unable to open serial port - ");
  }
  return 0;
}
