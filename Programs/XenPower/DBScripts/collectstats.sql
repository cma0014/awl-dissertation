--
-- File:	collectstats.sql
-- Purpose:	Create the tables used to store data collected in the
--              XenPower experiments
-- Copyright:	(c) 2006, The University of Louisiana at Lafayette, All Rights Reserved
--
UPDATE experiment_summary
SET
	allruntime = (SELECT MIN(runtime) from exp_workload_runtime WHERE runid = '%RUNNAME%'),
	allseqnum = (SELECT MIN(runtime) from exp_workload_runtime WHERE runid = '%RUNNAME%') / (SELECT sampleInterval FROM experiment_summary WHERE runId = '%RUNNAME%')
WHERE runid='%RUNNAME%';
-- Now we know the minimum runtime, calculate
UPDATE experiment_summary
SET
	totalWatts =( SELECT AVG(watts) FROM experiment_data AS d INNER JOIN experiment_summary s ON s.runid=d.runid WHERE (POSITION('%RUNNAME%' IN d.runid) > 0) AND (d.sequencenumber <= s.allseqnum)),
	totalVolts = (SELECT SUM(volts) from experiment_data AS d INNER JOIN experiment_summary s ON s.runid=d.runid WHERE (POSITION('%RUNNAME%' IN d.runid) > 0) AND (d.sequencenumber <= s.allseqnum)),
	totalAmps = (SELECT SUM(amps) from experiment_data AS d INNER JOIN experiment_summary s ON s.runid=d.runid WHERE (POSITION('%RUNNAME%' IN d.runid) > 0) AND (d.sequencenumber <= s.allseqnum)),
	averageWatts = (SELECT AVG(watts) from experiment_data AS d INNER JOIN experiment_summary s ON s.runid=d.runid WHERE (POSITION('%RUNNAME%' IN d.runid) > 0) AND (d.sequencenumber <= s.allseqnum)),
	averageVolts = (SELECT AVG(volts) from experiment_data AS d INNER JOIN experiment_summary s ON s.runid=d.runid WHERE (POSITION('%RUNNAME%' IN d.runid) > 0) AND (d.sequencenumber <= s.allseqnum)),
	averageAmps = (SELECT AVG(amps) from experiment_data AS d INNER JOIN experiment_summary s ON s.runid=d.runid WHERE (POSITION('%RUNNAME%' IN d.runid) > 0) AND (d.sequencenumber <= s.allseqnum))
WHERE runid = '%RUNNAME%';
