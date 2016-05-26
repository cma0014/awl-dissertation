--
-- File:	createtables.sql
-- Purpose:	Create the tables used to store data collected in the
--              XenPower experiments
-- Copyright:	(c) 2006, The University of Louisiana at Lafayette, All Rights Reserved
--
-- raw: raw data for each run
--
CREATE TABLE experiment_data
(
	  runId VARCHAR(255),
	  sequenceNumber INTEGER,
	  watts INTEGER,
	  volts INTEGER,
	  amps INTEGER,
	  wattHrs INTEGER,
	  cost INTEGER,
	  moKwHrs INTEGER,
	  moCost INTEGER,
	  maxWatts INTEGER,
	  maxVolts INTEGER,
	  maxAmps INTEGER,
	  minWatts INTEGER,
	  minVolts INTEGER,
	  minAmps INTEGER,
	  factor INTEGER,
	  dutyCycle INTEGER,
	  powerCycle INTEGER
);
--
-- summary: summarizes each raw
--
CREATE TABLE experiment_summary
(
	runID VARCHAR(255) PRIMARY KEY,
	sampleInterval INTEGER,
	totalWattss INTEGER,
	totalVolts INTEGER,
	totalAmps INTEGER,
	averageWattss FLOAT,
	averageVolts FLOAT,
	avaerageAmps FLOAT
);
--
-- summary: collect runtime data
--
CREATE TABLE exp_workload_runtime
(
	runID VARCHAR(255),
	workload INTEGER,
	runtime FLOAT
);
