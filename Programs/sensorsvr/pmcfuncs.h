/*
 * File: pmcfuncs.h
 */

#ifndef _PMCFNCS_H
#define _PMCFNCS_H

#include <inttypes.h>
#include <stdlib.h>
#include <stdio.h>
#include <unistd.h>
#include <libcpc.h>
#include <sys/lwp.h>
#include <errno.h>
#include <string.h>

#ifdef __cplusplus
extern "C" {
#endif

/*
 * sample is organized in a dyanmically allocated array of 64 bit integers.  One
 * sample per row with counters in the columns.
 */
typedef struct sample {
  int ncpus;
  int nreqs;
  uint64_t *pmc0;
} sample_t;

extern void pmc_init(const char *pmc);
/* extern void pmc_init_old(const char *pmc0, const char*pmc1); */
extern void pmc_close();
extern void pmc_get_reading(sample_t *s);

extern cpc_set_t *cpc_strtoset(cpc_t *cpcin, const char *spec, int smt);

#ifdef __cplusplus
}
#endif

#endif /* _PMCFNCS_H */
