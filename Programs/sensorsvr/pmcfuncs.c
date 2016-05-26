/*
 * File: pmcfuncs.c
 *
 * Note: this code may not correctly handle any situation where smt is involved.
 *       More stdudy rquired.
 */

#include "pmcfuncs.h"

typedef struct cstate {
  processorid_t cpuid;
  int chip_id;
  int status;
} cstate_t;
  
typedef struct ul_cpc_info {
  cpc_t *cpc;
  cpc_set_t *set;
  cpc_buf_t *pmcbuffer;
  uint64_t PMCvalue;
  int ncpus;
  int nreq;
  cstate_t *cores;
} ul_cpc_info_t;

static ul_cpc_info_t cpcbuf;

/*
 * Build CPU status
 */
void
build_cpu_status() {
  cstate_t *mycore = (cstate_t *)calloc(sizeof(cstate_t), cpcbuf.ncpus);
  int c,i;
  for (c=0,i=0; i < cpcbuf.ncpus; c++)
  {
    switch (p_online(c, P_STATUS)) {
    case P_ONLINE:
    case P_NOINTR:
      mycore[i++].cpuid = c;
      break;
    case P_OFFLINE:
    case P_POWEROFF:
    case P_FAULTED:
    case P_SPARE:
      mycore[i++].cpuid = -1;
      break;
    default:
      mycore[i++].cpuid = -1;
      break;
    case -1:
      break;
    }
  }
  cpcbuf.cores = mycore;
}

/*
 * Walker to count the number of requests in a set
 */
static void
pmc_walker(void *arg,
	   int index,
	   const char *event,
	   uint64_t preset,
	   uint_t flags,
	   int nattrs,
	   const cpc_attr_t*attrs)
{
  cpcbuf.nreq++;
}

/*
 * pmc_init(const char *, const char *)
 * Open a connection to the CPC shared object and bind to this sets
 */
void
pmc_init(const char *pmc)
{
  int rtn_code;
  cpcbuf.ncpus = (int) sysconf(_SC_NPROCESSORS_CONF);
  build_cpu_status();
  cpcbuf.cpc = cpc_open(CPC_VER_CURRENT);
  if (cpcbuf.cpc == NULL) {
    printf("pmc_init(): cpc open failed\n");
    return;
  }
  cpcbuf.set = cpc_strtoset(cpcbuf.cpc, pmc, 0);
  if (cpcbuf.set == NULL) {
    /* Failure to convert the pmc string to a set is a catatrophic error*/
    printf("pmc_init(): unable to convert pmc string to cpc set. Exiting.\n");
    pmc_close();
    exit(-1);
  }
  cpcbuf.nreq = 0;
  /* now we count number of requests */
  cpc_walk_requests(cpcbuf.cpc,cpcbuf.set,&(cpcbuf.nreq), pmc_walker);
  cpcbuf.pmcbuffer = cpc_buf_create(cpcbuf.cpc,cpcbuf.set);
  if (cpcbuf.pmcbuffer == NULL) {
    printf("pmc_init(): buffer create failed.\n");
    return;
  }
}

/*
 * pmc_close()
 */
void
pmc_close()
{
  int i;
  /* Free memory allocated for cpu state */
  free(cpcbuf.cores);
  cpcbuf.cores = NULL;
  /* Now turn off the performance counter collection */
  cpc_close(cpcbuf.cpc);
}


/*
 * pmc_get_reading()
 */
void 
pmc_get_reading(sample_t *s)
{
  int rtn_code;
  int cpu;
  int i;
  cstate_t *lcores = cpcbuf.cores;
  int ncpus = cpcbuf.ncpus;
  int nreqs = cpcbuf.nreq;
  uint64_t *pmclist = (uint64_t *)calloc(sizeof(uint64_t), ncpus*nreqs);
  uint64_t *curnode;
  for (cpu=0; cpu < ncpus; cpu++) {
    rtn_code = cpc_bind_cpu(cpcbuf.cpc,lcores[cpu].cpuid, cpcbuf.set,0);
    if (rtn_code == -1) {
      (void) fprintf(stderr,"cpc_bind_cpu failed for cpu %d %d\n",lcores[cpu].cpuid,errno);
      exit(-1);
    }
    rtn_code = cpc_set_sample(cpcbuf.cpc,cpcbuf.set,cpcbuf.pmcbuffer);
    if (rtn_code == -1) {
      (void) fprintf(stderr,"cpc_bind_cpu failed for cpu %d %d\n",lcores[cpu].cpuid,errno);
      exit(-1);
    }
    for (i = 0; i < nreqs; i++) {
      cpc_buf_get(cpcbuf.cpc,
		  cpcbuf.pmcbuffer,
		  i,
		  &(cpcbuf.PMCvalue));
      curnode = pmclist + cpu*ncpus + i;
      *curnode = cpcbuf.PMCvalue;
    }
    rtn_code = cpc_unbind(cpcbuf.cpc, cpcbuf.set);
  }
  s->ncpus = ncpus;
  s->nreqs = nreqs;
  s->pmc0 = pmclist;
}
