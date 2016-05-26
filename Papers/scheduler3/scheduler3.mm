<?xml version="1.0" encoding="utf-8"?>
<map version="0.9.0">
<!-- To view this file, download free mind mapping software FreeMind from http://freemind.sourceforge.net -->
<node text="THERMAL-AWARE SCHEDULING">
<node text="Terminology" position="left">
<node text="thread">
<node style="bubble" background_color="#eeee00">
<richcontent TYPE="NODE"><html>
<head>
<style type="text/css">
<!--
p { margin-top: 0 }
-->
</style>
</head>
<body>
<p>A schedulable entity reflecting a single flow of execution.</p>
</body>
</html>
</richcontent>
<richcontent TYPE="NOTE"><html><head></head><body><p>-- This is more about "thread" --</p></body></html></richcontent>
</node>
</node>
<node text="task">
<node style="bubble" background_color="#eeee00">
<richcontent TYPE="NODE"><html>
<head>
<style type="text/css">
<!--
p { margin-top: 0 }
-->
</style>
</head>
<body>
<p>A collection of threads running within one address space.</p>
</body>
</html>
</richcontent>
<richcontent TYPE="NOTE"><html><head></head><body><p>-- This is more about "task" --</p></body></html></richcontent>
</node>
</node>
<node text="timeslice">
<node style="bubble" background_color="#eeee00">
<richcontent TYPE="NODE"><html>
<head>
<style type="text/css">
<!--
p { margin-top: 0 }
-->
</style>
</head>
<body>
<p>A period of time a scheduler intends to schedule a thread.</p>
</body>
</html>
</richcontent>
<richcontent TYPE="NOTE"><html><head></head><body><p>-- This is more about "timeslice" --</p></body></html></richcontent>
</node>
</node>
<node text="quantum">
<node style="bubble" background_color="#eeee00">
<richcontent TYPE="NODE"><html>
<head>
<style type="text/css">
<!--
p { margin-top: 0 }
-->
</style>
</head>
<body>
<p>The actual execution time utilized by a thread.</p>
</body>
</html>
</richcontent>
<richcontent TYPE="NOTE"><html><head></head><body><p>-- This is more about "quantum" --</p></body></html></richcontent>
</node>
</node>
<node text="run-queue">
<node style="bubble" background_color="#eeee00">
<richcontent TYPE="NODE"><html>
<head>
<style type="text/css">
<!--
p { margin-top: 0 }
-->
</style>
</head>
<body>
<p>A queue containing runnable threads of a processor.</p>
</body>
</html>
</richcontent>
<richcontent TYPE="NOTE"><html><head></head><body><p>-- This is more about "run-queue" --</p></body></html></richcontent>
</node>
</node>
<node text="scheduling policy">
</node>
</node>
<node text="Scheduling policies" position="left">
<node text="constant time scheduling">
<node style="bubble" background_color="#eeee00">
<richcontent TYPE="NODE"><html>
<head>
<style type="text/css">
<!--
p { margin-top: 0 }
-->
</style>
</head>
<body>
<p>Priority based scheduling algorithm favoring I/O-bound threads</p>
</body>
</html>
</richcontent>
<richcontent TYPE="NOTE"><html><head></head><body><p>-- This is more about "constant time scheduling" --</p></body></html></richcontent>
</node>
<node text="Linux O(1) scheduler">
</node>
</node>
<node text="linear time scheduling">
<node text="Round-robin scheduler">
</node>
<node text="Multilevel feedback queue">
</node>
</node>
<node text="Proportional share policies">
<node text="fair scheduling/stride scheduling">
<node style="bubble" background_color="#eeee00">
<richcontent TYPE="NODE"><html>
<head>
<style type="text/css">
<!--
p { margin-top: 0 }
-->
</style>
</head>
<body>
<p>Fair scheduling: allocation of available CPU time is equally distributed<br />amongst system users and groups as opposed to equal distribution among<br />processes.  Common implementation method is to recursively apply<br />round-robin scheduling strategy at each level of abstraction.</p>
</body>
</html>
</richcontent>
<richcontent TYPE="NOTE"><html><head></head><body><p>-- This is more about "fair scheduling/stride scheduling" --</p></body></html></richcontent>
</node>
<node text="Terminology">
<node text="Stride">
<node style="bubble" background_color="#eeee00">
<richcontent TYPE="NODE"><html>
<head>
<style type="text/css">
<!--
p { margin-top: 0 }
-->
</style>
</head>
<body>
<p>The time interval a thread has to wait between its consecutive<br />executions.</p>
</body>
</html>
</richcontent>
<richcontent TYPE="NOTE"><html><head></head><body><p>-- This is more about "Stride" --</p></body></html></richcontent>
</node>
</node>
<node text="Virtual time">
<node style="bubble" background_color="#eeee00">
<richcontent TYPE="NODE"><html>
<head>
<style type="text/css">
<!--
p { margin-top: 0 }
-->
</style>
</head>
<body>
<p>Defines which thread is scheduled next.  Each thread has own concept of<br />virtual time which is synchronized with a per run-queue global virtual<br />time when a thread becomes runnable.  The idea is that virtual times of<br />all threads and the global virtual time of a run-queue are equal at each<br />distinct point of time.</p>
</body>
</html>
</richcontent>
<richcontent TYPE="NOTE"><html><head></head><body><p>-- This is more about "Virtual time" --</p></body></html></richcontent>
</node>
</node>
</node>
<node text="Start-time fair queuing">
</node>
<node text="completely fair scheduler">
<node style="bubble" background_color="#eeee00">
<richcontent TYPE="NODE"><html>
<head>
<style type="text/css">
<!--
p { margin-top: 0 }
-->
</style>
</head>
<body>
<p>Implementation in the most recent Linux kernel. Complexity is O(log N)<br />where N is the number of tasks in the runqueue.  Choosing a task can be<br />done in constant time, but reinserting task requires O(log N) because<br />runqueue is implemented as red/black tree.</p>
</body>
</html>
</richcontent>
<richcontent TYPE="NOTE"><html><head></head><body><p>-- This is more about "completely fair scheduler" --</p></body></html></richcontent>
</node>
</node>
<node text="brain f*** scheduler">
<node text="Loosely based on idea of earliest eligible virtual deadline first">
</node>
<node text="Signal queue of queued but not running processes">
</node>
<node text="Avoid complexity of per-CPU queues">
</node>
<node text="Optimized for mobile and desktop, light NUMA &amp; fewer than 16 cores">
<node style="bubble" background_color="#eeee00">
<richcontent TYPE="NODE"><html>
<head>
<style type="text/css">
<!--
p { margin-top: 0 }
-->
</style>
</head>
<body>
<p>Balancing of heuristics is a problem.  Gains of local runqueue locking<br />lost due to need of having grab multiple locks.</p>
</body>
</html>
</richcontent>
<richcontent TYPE="NOTE"><html><head></head><body><p>-- This is more about "Optimized for mobile and desktop, light NUMA &amp; fewer than 16 cores" --</p></body></html></richcontent>
</node>
</node>
</node>
</node>
</node>
</node>
<node text="Approaches">
<node text="real-time and embedded systems">
</node>
<node text="adjusting heuristics">
<node style="bubble" background_color="#eeee00">
<richcontent TYPE="NODE"><html>
<head>
<style type="text/css">
<!--
p { margin-top: 0 }
-->
</style>
</head>
<body>
<p>Use scheduling heuristics to determine how to adjust how processes are scheduled.</p>
</body>
</html>
</richcontent>
<richcontent TYPE="NOTE"><html><head></head><body><p>-- This is more about "adjusting heuristics" --</p></body></html></richcontent>
</node>
<node text="Heat and Run">
<node style="bubble" background_color="#eeee00">
<richcontent TYPE="NODE"><html>
<head>
<style type="text/css">
<!--
p { margin-top: 0 }
-->
</style>
</head>
<body>
<p>Proposed to distribute work amongst available cores until DTM occurs and<br />migrate work away from the overheated cores.</p>
</body>
</html>
</richcontent>
<richcontent TYPE="NOTE"><html><head></head><body><p>-- This is more about "Heat and Run" --</p></body></html></richcontent>
</node>
</node>
<node text="HybDTM">
<node style="bubble" background_color="#eeee00">
<richcontent TYPE="NODE"><html>
<head>
<style type="text/css">
<!--
p { margin-top: 0 }
-->
</style>
</head>
<body>
<p>Combine DTM techniques with a thread migration strategy that reduces the<br />thread priority of jobs on cores that are running hot.</p>
</body>
</html>
</richcontent>
<richcontent TYPE="NOTE"><html><head></head><body><p>-- This is more about "HybDTM" --</p></body></html></richcontent>
</node>
</node>
<node text="ThreshHot">
<node style="bubble" background_color="#eeee00">
<richcontent TYPE="NODE"><html>
<head>
<style type="text/css">
<!--
p { margin-top: 0 }
-->
</style>
</head>
<body>
<p>\cite{Yang2008;Yang2010} used an on-line temperature estimator to<br />determine what order threads should be scheduled onto cores. This work<br />analytically demonstrated that you want give preference to those threads<br />that contribute the most to the increase in the temperature to complete<br />them as quickly as possible</p>
</body>
</html>
</richcontent>
<richcontent TYPE="NOTE"><html><head></head><body><p>-- This is more about "ThreshHot" --</p></body></html></richcontent>
</node>
</node>
<node text="Task Vectors">
<node style="bubble" background_color="#eeee00">
<richcontent TYPE="NODE"><html>
<head>
<style type="text/css">
<!--
p { margin-top: 0 }
-->
</style>
</head>
<body>
<p>In \cite{Merkel2008b}, sort taks in each core's run-queue by memory<br />intensity so as to schedule memory-bound tasks at slower frequencies.</p>
</body>
</html>
</richcontent>
<richcontent TYPE="NOTE"><html><head></head><body><p>-- This is more about "Task Vectors" --</p></body></html></richcontent>
</node>
</node>
</node>
<node text="avoiding thermal emergencies">
<node text="thread migration">
<node style="bubble" background_color="#eeee00">
<richcontent TYPE="NODE"><html>
<head>
<style type="text/css">
<!--
p { margin-top: 0 }
-->
</style>
</head>
<body>
<p>Based on adjusting scheduling heuristics </p>
</body>
</html>
</richcontent>
<richcontent TYPE="NOTE"><html><head></head><body><p>-- This is more about "thread migration" --</p></body></html></richcontent>
</node>
</node>
<node text="Adjust load balancing based on thread migration">
<node style="bubble" background_color="#eeee00">
<richcontent TYPE="NODE"><html>
<head>
<style type="text/css">
<!--
p { margin-top: 0 }
-->
</style>
</head>
<body>
<p>\cite{Coskun2007} move work to the coolest processor.</p>
</body>
</html>
</richcontent>
<richcontent TYPE="NOTE"><html><head></head><body><p>-- This is more about "Adjust load balancing based on thread migration" --</p></body></html></richcontent>
</node>
</node>
</node>
</node>
<node text="Opportunities">
<node text="assets">
<node text="power model">
<node text="thermal extension">
</node>
</node>
</node>
<node text="Energy as resource">
<node text="Prior work">
<node text="ECOSystem and currentcy \cite{Zeng2002}">
<node style="bubble" background_color="#eeee00">
<richcontent TYPE="NODE"><html>
<head>
<style type="text/css">
<!--
p { margin-top: 0 }
-->
</style>
</head>
<body>
<p>Currentcy: an abstraction for the energy a system can spend on various<br />devices.  One unit of currentcy represents the right to consume a<br />certain amount of energy within a fixed amount of time.   Schedule<br />processes either with a static-priority policy where system allocates<br />currentcy to devices according to a static share while currentcy-centric<br />scheduling adjusts priorities on the basis of ration of consumed<br />currentcy to entitled currentcy.</p>
</body>
</html>
</richcontent>
<richcontent TYPE="NOTE"><html><head></head><body><p>-- This is more about "ECOSystem and currentcy \cite{Zeng2002}" --</p></body></html></richcontent>
</node>
</node>
<node text="Cinder capacitors \cite{Rumble2009}">
<node style="bubble" background_color="#eeee00">
<richcontent TYPE="NODE"><html>
<head>
<style type="text/css">
<!--
p { margin-top: 0 }
-->
</style>
</head>
<body>
<p>Proposed for mobile devices.  Treat energy as equivalent resource to<br />disk, memory, etc.   Manage in the same way as physical capacitor.</p>
</body>
</html>
</richcontent>
<richcontent TYPE="NOTE"><html><head></head><body><p>-- This is more about "Cinder capacitors \cite{Rumble2009}" --</p></body></html></richcontent>
</node>
</node>
<node text="Energy limits and task vectors \cite{Bellosa2003;Klee2008;Merkel2008}">
</node>
</node>
<node text="Thermal equivalence of application">
<node style="bubble" background_color="#eeee00">
<richcontent TYPE="NODE"><html>
<head>
<style type="text/css">
<!--
p { margin-top: 0 }
-->
</style>
</head>
<body>
<p>Adaptation of the analytical model from journal paper to thermal<br />domain.  Provides way of dynamically allocating concept of currentcy to<br />tasks. Use similar model to what was used in Cinder to manage.</p>
</body>
</html>
</richcontent>
<richcontent TYPE="NOTE"><html><head></head><body><p>-- This is more about "Thermal equivalence of application" --</p></body></html></richcontent>
</node>
</node>
</node>
<node text="Avoidance of DTM events">
<node text="The time differential">
<node style="bubble" background_color="#eeee00">
<richcontent TYPE="NODE"><html>
<head>
<style type="text/css">
<!--
p { margin-top: 0 }
-->
</style>
</head>
<body>
<p>Nanosecond decisions in the scheduler, minutes at the application.<br />Application decisions for managing temperature and how does this map<br />into effects seen at the scheduler level?</p>
</body>
</html>
</richcontent>
<richcontent TYPE="NOTE"><html><head></head><body><p>-- This is more about "The time differential" --</p></body></html></richcontent>
</node>
</node>
<node text="How this notion of fair scheduling affect these schemes?">
<node style="bubble" background_color="#eeee00">
<richcontent TYPE="NODE"><html>
<head>
<style type="text/css">
<!--
p { margin-top: 0 }
-->
</style>
</head>
<body>
<p>CFS and BFS both make serious effort to avoid complicated heuristics.<br />Avoid the complex structures involved with classic UNIX schedulers?</p>
</body>
</html>
</richcontent>
<richcontent TYPE="NOTE"><html><head></head><body><p>-- This is more about "How this notion of fair scheduling affect these schemes?" --</p></body></html></richcontent>
</node>
</node>
</node>
</node>
<node text="Proposed contributions">
<node text="Thermal model">
<node style="bubble" background_color="#eeee00">
<richcontent TYPE="NODE"><html>
<head>
<style type="text/css">
<!--
p { margin-top: 0 }
-->
</style>
</head>
<body>
<p>A switching activity based thermal model that extends the power model in prior work.</p>
</body>
</html>
</richcontent>
<richcontent TYPE="NOTE"><html><head></head><body><p>-- This is more about "Thermal model" --</p></body></html></richcontent>
</node>
</node>
<node text="Thermal load of application (TheA)">
<node style="bubble" background_color="#eeee00">
<richcontent TYPE="NODE"><html>
<head>
<style type="text/css">
<!--
p { margin-top: 0 }
-->
</style>
</head>
<body>
<p>A means to dynamically gauge application contribution to the thermal load of the system.</p>
</body>
</html>
</richcontent>
<richcontent TYPE="NOTE"><html><head></head><body><p>-- This is more about "Thermal load of application (TheA)" --</p></body></html></richcontent>
</node>
</node>
<node text="Energy-Aware Fair Scheduling (EAFS)">
<node style="bubble" background_color="#eeee00">
<richcontent TYPE="NODE"><html>
<head>
<style type="text/css">
<!--
p { margin-top: 0 }
-->
</style>
</head>
<body>
<p>A energy-aware fair scheduling policy that treats energy as a first<br />level scheduling constraint </p><p><br /></p><p><br /></p>
</body>
</html>
</richcontent>
<richcontent TYPE="NOTE"><html><head></head><body><p>-- This is more about "Energy-Aware Fair Scheduling (EAFS)" --</p></body></html></richcontent>
</node>
</node>
</node>
</node>
</map>
