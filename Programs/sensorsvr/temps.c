/*
 * File:   temps.c
 * Author: awl8049
 */

#include "temps.h"


static uint64_t temp_reading;

/*
 * Get/Set methods for the static variable used to store temperature
 */
static void ul_set_reading(uint64_t new_value)
{
  temp_reading = new_value;
}

static uint64_t ul_get_reading()
{
  return temp_reading;
}

/*
 * ul_ipmi_init(ipmi_control_data_t *):
 * Open the ipmi interface. Do any required setup.
 */
int
ul_ipmi_init(ipmi_control_data_t *ipmi_ctl)
{
  int error;
  char *msg;
  if (ipmi_ctl != NULL) {
    ipmi_ctl->ipmi_hdl = ipmi_open(&error, &msg);
    if (ipmi_ctl->ipmi_hdl == NULL) {
      /* Unable to get clean connection to the SP thru /dev/bmc */
      if (error != EIPMI_BMC_OPEN_FAILED) {
	printf("gettemp: Init IPMI fail. Connection: %s\n", msg);
      }
      printf("gettemp: Failed to load. No IPMI connection\n");
      return(-1);
    }
  }
  return(0);
}

/*
 * ul_impi_close(impi_control_data_t *ipmi_ctl)
 */
void
ul_ipmi_close(ipmi_control_data_t *ipmi_ctl)
{
  if ((ipmi_ctl != NULL) && (ipmi_ctl->ipmi_hdl != NULL)) {
      ipmi_close(ipmi_ctl->ipmi_hdl);
    }
}

/*
 * int
 * process_sdr(ipmi_handle_t, ipmi_entity_t, const char *
 *               ipmi_sdr_t *, void *)
 *
 * Callback function used by the ipmi library to sweep
 * through the SDR data.  Yes, it's hokey but you can blame
 * that on screwed up way that the IPMI standard works.
 */ 
static int
process_sdr(ipmi_handle_t *ihp, ipmi_entity_t *ep, const char *name,
    ipmi_sdr_t *sdrp, void *data)
{
	ipmi_sdr_compact_sensor_t *csp;
	ipmi_sdr_full_sensor_t *fsp;
	uint8_t sensor_number, sensor_type, reading_type;
	boolean_t get_reading = B_FALSE;
 	ipmi_sensor_reading_t *srp;
	char sensor_name[128];
	char reading_name[128];
        int c_r;
	uint8_t converted;


	if (name == NULL)
		return (0);

	switch (sdrp->is_type) {
	case IPMI_SDR_TYPE_COMPACT_SENSOR:
		csp = (ipmi_sdr_compact_sensor_t *)sdrp->is_record;
		sensor_number = csp->is_cs_number;
		sensor_type = csp->is_cs_type;
		reading_type = csp->is_cs_reading_type;
		get_reading = B_TRUE;
		break;

	case IPMI_SDR_TYPE_FULL_SENSOR:
		fsp = (ipmi_sdr_full_sensor_t *)sdrp->is_record;
		sensor_number = fsp->is_fs_number;
		sensor_type = fsp->is_fs_type;
		reading_type = fsp->is_fs_reading_type;
		get_reading = B_TRUE;
		break;
	}


	if (get_reading) {
	  ipmi_sensor_type_name(sensor_type, sensor_name,
				sizeof (sensor_name));
	  ipmi_sensor_reading_name(sensor_type, reading_type,
				   reading_name, sizeof (reading_name));
	  if ((srp = ipmi_get_sensor_reading(ihp,
					     sensor_number)) == NULL) {
	    if (ipmi_errno(ihp) != EIPMI_NOT_PRESENT) {
	      return (-1);
	    }
	  } else {
	    if (strncmp(sensor_name,"TEMP",4) == 0) {
	      ul_set_reading(srp->isr_reading);
	    }
	  }
	}

	return (0);
}

/*
 * uint64_t
 * cpu_die_temp(int cpu#)
 */
uint64_t
cpu_die_temp(ipmi_control_data_t *ipmi_ctl, int cpu_num)
{
  ipmi_entity_t *proc_entity;
  ipmi_handle_t *ihp = ipmi_ctl->ipmi_hdl;
  char * ipmi_entity_str;
  uint64_t temp;
  switch (cpu_num)
  {
  case 0:
    ipmi_entity_str = "CPU 0 Temp";
    break;
  case 1:
    ipmi_entity_str = "CPU 1 Temp";
    break;
  default:
    fprintf(stderr,"Cannot get die temp for CPUs other than 0 or 1\n");
    return(0);
  }
  proc_entity = ipmi_entity_lookup_sdr(ihp, ipmi_entity_str);
  if (proc_entity != NULL) {
    ipmi_entity_iter_sdr(ihp, proc_entity, process_sdr, NULL);
    temp = ul_get_reading();
  }
  return(temp);
}

/*
 * uint64_t
 * ambient_temp();
 */
uint64_t
ambient_temp(ipmi_control_data_t *ipmi_ctl,int sensor)
{
  ipmi_entity_t *proc_entity;
  ipmi_handle_t *ihp = ipmi_ctl->ipmi_hdl;
  char * ipmi_entity_str = "Ambient Temp";
  uint64_t temp;
  switch (sensor)
  {
  case 0:
    ipmi_entity_str = "Ambient Temp0";
    break;
  case 1:
    ipmi_entity_str = "Ambient Temp1";
    break;
  default:
    fprintf(stderr,"Cannot get die temp for CPUs other than 0 or 1\n");
    return(0);
  }
  proc_entity = ipmi_entity_lookup_sdr(ihp, ipmi_entity_str);
  if (proc_entity != NULL) {
    ipmi_entity_iter_sdr(ihp, proc_entity, process_sdr, NULL);
    temp = ul_get_reading();
  }
  return(temp);
}
