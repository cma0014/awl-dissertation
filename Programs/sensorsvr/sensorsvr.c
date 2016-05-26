/*
 * File:    sensorsvr.c
 * Author:  awl8049
 */

#include "temps.h"
#include "pmcfuncs.h"

#include <time.h>
#define DEFFILE "/tmp/reading"
#define FILENAME_SIZE 1024
#define SENSOR_DELAY 5

// Performance counters using in this application
#define PMC0 "pic0=PAPI_l2_dcm,pic1=PAPI_l2_icm"
#define PMC1 "pic0=NB_ht_bus0_bandwidth,umask=0x07,pic1=NB_ht_bus1_bandwidth,umask=0x07"


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

char *tempstr()
{
  int error;
  uint64_t c0,c1,amb0,amb1;
  ipmi_control_data_t *it = (ipmi_control_data_t *) calloc(sizeof(ipmi_control_data_t),1);
  char *buffer = (char *)malloc(1024);
  memset(buffer,1024,0);
  error = ul_ipmi_init(it);
  if (error >= 0) {
    c0 = cpu_die_temp(it,0);
    c1 = cpu_die_temp(it,1);
    amb0 = ambient_temp(it,0);
    amb1 = ambient_temp(it,1);
    sprintf(buffer,"%lld %lld %lld %lld",
	    c0,
	    c1,
	    amb0,
	    amb1);
  }
  ul_ipmi_close(it);
  free((void *)it);
  return((char *)buffer);
}

char *pmcstr()
{
  int i,j,k;
  uint64_t *cache_sam_pmc0;
  uint64_t *ht_sam_pmc0;
  sample_t *cache_sam = (sample_t *) calloc(sizeof(sample_t), 1);
  sample_t *ht_sam    = (sample_t *) calloc(sizeof(sample_t), 1);
  int ncpus,cnreqs,hnreqs;
  char *buffer = (char *)malloc(1024);
  memset(buffer,1024,0);
  pmc_init(PMC0);
  pmc_get_reading(cache_sam);
  pmc_close();
  pmc_init(PMC1);
  pmc_get_reading(ht_sam);
  pmc_close();
  cache_sam_pmc0 = cache_sam->pmc0;
  ht_sam_pmc0 = ht_sam->pmc0;
  ncpus = cache_sam->ncpus; /* we assume the # of cpus doesn't change */
  cnreqs = cache_sam->nreqs;
  hnreqs = ht_sam->nreqs;
  for (j=0; j< ncpus; j++) {
    sprintf(buffer,"%d\t%d\t",i,j);
    for (k=0; k < cnreqs; k++) {
      printf(buffer,
	     "%lld\t",
	     *(cache_sam_pmc0 + j*ncpus + k));
    }
    for (k=0; k < hnreqs; k++) {
      printf(buffer,
	     "%lld\t",
	     *(ht_sam_pmc0 + j*ncpus + k));
    }
  }
  free(cache_sam);
  free(ht_sam);
  return((char *) buffer);
}

char *kstatsr()
{
  return(NULL);
}

/*
 * main(argc, argv) : Test driver for getting temp from IPMI
 */
int
main(int argc, void *argv[])
{
  char *fname;
  double data;
  FILE * rFile;
  char *stringToPrint;
  fname = (char *) malloc(FILENAME_SIZE);
  memset(fname, FILENAME_SIZE + 1, 0);
  strcpy(fname, DEFFILE);
  while (1) {
    rFile = fopen(fname,"w");
    // timestamp
    stringToPrint = buildTimeStamp();
    fprintf(rFile,"%s ", stringToPrint );
    printf("%s ", stringToPrint );
    // temperatures
    stringToPrint = tempstr();
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
    sleep(SENSOR_DELAY);
  }
}
