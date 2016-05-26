--
-- File:	collectstats.sql
-- Purpose:	Create the tables used to store data collected in the
--              XenPower experiments
-- Copyright:	(c) 2006, The University of Louisiana at Lafayette, All Rights Reserved
--
INSERT INTO exp_workload_runtime(runid,workload,runtime)
VALUES
(
'%RUNID%',
%WORKLOAD%,
%RUNTIME%
);
