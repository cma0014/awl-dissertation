/*
 * File:     temps.h
 * Author:   awl8049
 * Library functions for getting temps from IPMI
 */

#ifndef _TEMPS_H
#define _TEMPS_H

#include <unistd.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <strings.h>
#include <limits.h>
#include <alloca.h>
#include <errno.h>
#include <sys/types.h>
#include <sys/param.h>
#include <libipmi.h>

#define BUFSZ 128
/* Largest possible SDR ID length is 2^5+1 */
#define MAX_ID_LEN 33

typedef struct ipmi_control_data {
  ipmi_handle_t        *ipmi_hdl;
} ipmi_control_data_t;

extern int ul_ipmi_init(ipmi_control_data_t *ipmi_ctl);

extern void ul_ipmi_close(ipmi_control_data_t *ipmi_ctl);

extern uint64_t cpu_die_temp(
  ipmi_control_data_t *ipmi_ctl,
  int cpu_num);

extern uint64_t ambient_temp(
  ipmi_control_data_t *ipmi_ctl,
  int sensor);

#endif /* _TEMPS_H */
