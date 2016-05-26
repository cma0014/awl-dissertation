<TeXmacs|1.0.6.15>

<style|amsart>

<\body>
  <surround| ||<doc-data|<doc-title|Scheduler Cost function
  derivation>|<doc-author-data|<author-name|Soumik Ghosh>|<\author-address>
    \;
  </author-address>>|<doc-date|<date|>>>>

  There are two major metrics of interest for the thermal workload of a
  multicore processor. The first is the total time of execution ( denoted by
  <with|mode|math|L> for length ) of a certain application (denoted by
  <with|mode|math|A>),

  <\equation*>
    L(A(p<rsub|i>),D<rsub|A>,t),
  </equation*>

  where application <with|mode|math|A> has <with|mode|math|p> processes, each
  associated with a data set of size <with|mode|math|d<rsub|i>> in a single
  chip. <with|mode|math|D<rsub|A>> is the total data associated with
  application <with|mode|math|A>, and <with|mode|math|D<rsub|A>=<big|sum><rsub|i=1><rsup|p>d<rsub|i>>.
  We assume that the activities are taking place in a staging area which
  contains the main and virtual memory operating spaces, as well as the
  processor with its cores and their associated caches and shared cache.

  This time of execution measurement includes both computation time, and the
  time to move the data for the problem from the staging area (peripherals
  off the chip like DRAM and HDD) to a computation or operation area (on the
  chip such as the caches and the cores).

  The second major metric of interest is the energy consumption or energy
  workload of an application, <with|mode|math|U(A(p<rsub|i>),d<rsub|i>)>. For
  each application <with|mode|math|A> and problem size
  <with|mode|math|D<rsub|A>>, a measure of the workload,
  <with|mode|math|W(A(p<rsub|i>),d<rsub|i>)>, is defined in a data-operation
  dependent and system-independent way. W contains two components, one being
  the operations count that is performed by the computational core, and the
  other is the communication operations in transferring data and instructions
  and data coherency and book-keeping operations. These are measured in terms
  of the number of bytes operated ON, or number of bytes transferred. Thus
  the energy workload of an application <with|mode|math|A> operating on a
  data set <with|mode|math|D<rsub|A>> can be expressed as :

  <equation*|U(A(p<rsub|i>),d<rsub|i>)=lim<rsub|n\<to\>k<rsub|e>>n\<times\>W(A(p<rsub|i>),d<rsub|i>)\<times\>L<rsub|n>(A(p<rsub|i>),d<rsub|i>,t)<next-line>>

  where <with|mode|math|L<rsub|n>(k,d<rsub|i>)> is the total time to execute
  <with|mode|math|n> applications using the chip. The term
  <with|mode|math|k<rsub|e>> is the total number of applications that can be
  excuted with the associated length of time for <with|mode|math|L<rsub|n>>,
  at which point a ``thermal event'' will occur causing the applications and
  the system to catastrophically fail, or shut down.

  It is easy to see that the above term is energy consumption of the system
  till a thermal event occurs. In order to relate the energy expenditure of
  the system while running applications, to teh corresponding joule heating,
  we define the term ``Thermal equivalent of Application'' (TEA), which is
  defined as the electrical work converted to heat in running an application
  and is measured in terms of die tmperature change and ambient temperature
  change of the system. Thus for the application <with|mode|math|A> we
  express TEA as :

  <\align*>
    <tformat|<table|<row|<cell|\<Theta\><rsub|A>(A(p<rsub|i>),d<rsub|i>,T,t)>|<cell|=<frac|U(A(p<rsub|i>),d<rsub|i>)|<with|math-display|true|lim<rsub|T\<to\>T<rsub|t*h>>J<rsub|e>\<times\>(T-T<rsub|n*o*m*i*n*a*l>)>>>>|<row|<cell|>|<cell|=<frac|<with|math-display|true|lim<rsub|n\<to\>k<rsub|e>>n\<times\>W(A(p<rsub|i>),d<rsub|i>)\<times\>L<rsub|n>(A(p<rsub|i>),d<rsub|i>,t)>|<with|math-display|true|lim<rsub|T\<to\>T<rsub|t*h>>J<rsub|e>\<times\>(T-T<rsub|n*o*m*i*n*a*l>)>>>>>>
  </align*>

  In these expressions, <with|mode|math|T<rsub|t*h>> refers to the threshold
  temperature at which a DTM triggered event will occur.
  <with|mode|math|T<rsub|n*o*m*i*n*a*l>> refers to the nominal temperature as
  reported by the DTM counters / registers , when only the operating system
  in operating and no application is being run. The term
  <with|mode|math|J<rsub|e>> is the ``electrical equivalent of heat'' for the
  chip, which reflects the <with|font-shape|italic|informational entropy> of
  the system associated with processing the bits application
  <with|mode|math|A(p<rsub|i>)> computes and communicates, as well as the
  black body thermal properties of the chip packaging and the cooling
  mechanisms around the chip. TEA thus is a dimensionless quantity , both
  denominator and numerator being expressing of work done or energy consumed
  in finishing a task.

  For managing the thermal envelope of applications on server systems as well
  as embedded systems, we are interested in the thermal efficiency of the
  operation, that is, the thermal cost of taking an application to
  completion. In general the efficiency <with|mode|math|\<eta\>(A(p<rsub|i>),d<rsub|i>,T)>
  is defined as

  <\equation*>
    \<eta\>(A(p<rsub|i>),d<rsub|i>,T,t)=<frac|\<Theta\><rsub|A>(A(p<rsub|i>),d<rsub|i>,T,t)|\<Theta\><rsub|A>(A<rsub|e>(p<rsub|i>),d<rsub|i>,T<rsub|m*e>,t<rsub|e>)><next-line>
  </equation*>

  where <with|mode|math|T<rsub|(>m*e)> is the maximum temperature till which
  the core will carry over till a DTM triggered event occurs.
  <with|mode|math|A<rsub|e>> refers to the application whose energy
  consumption has caused the DTM triggered event to take place.
  <with|mode|math|T<rsub|e>> is the execution time of application
  <with|mode|math|A<rsub|e>>. Thus <with|mode|math|\<eta\>(A(p<rsub|i>),d<rsub|i>,T)>
  is a measure of the ``thermal efficiency of the application'', which
  implies how much an application affects temperature change without
  compromising it's throughput and/or leads to a thermal event. Thus the
  definition of <with|mode|math|\<eta\>> is linked to the definition of the
  thermal and energy workload.

  An important metric finally is the achieved performance per unit power
  consumed by the chip,

  <\align*>
    <tformat|<table|<row|<cell|C<rsub|\<theta\>>(A(p<rsub|i>),d<rsub|i>,T,t)>|<cell|=<frac|\<Theta\><rsub|A>(A(p<rsub|i>),d<rsub|i>,T,t)|P(A(p<rsub|i>),d<rsub|i>)>>>|<row|<cell|>|<cell|=<frac|\<Theta\><rsub|A>(A(p<rsub|i>),d<rsub|i>,T,t)|<with|math-display|true|<big|sum><rsup|c*h*i*p,D*R*A*M,H*T,H*D*D><big|int><rsub|t=0><rsup|t=L<rsub|A>>v(t)i(t)d*t>>>>>>
  </align*>

  where <with|mode|math|P(A(p<rsub|i>),d<rsub|i>)> is the overall power
  consumed during the application lifetime. the quantity
  <with|mode|math|<big|int><rsub|t=0><rsup|t=L<rsub|A>>v(t)i(t)d*t> is the
  total power consumed by a single physical component (processor, DRAM units,
  HDD, HT or FSB) during the length of the application
  <with|mode|math|L<rsub|A>>, with <with|mode|math|v(t)> and
  <with|mode|math|i(t)> being the instantaneous voltage and currents
  respectively.

  This normalized quantity <with|mode|math|C<rsub|\<theta\>>> gives some
  indication of the ``cost'' of executing the benchmark on the given chip.

  The final optimization function could be thought of as :

  <\equation*>
    <frac|\<partial\><rsup|2>C<rsub|\<theta\>>(A(p<rsub|i>),d<rsub|i>,T,t)|\<partial\>T\<partial\>t>=<frac|\<partial\><rsup|2>|\<partial\>T\<partial\>t><frac|<with|math-display|true|lim<rsub|n\<to\>k<rsub|e>>n\<times\>W(A(p<rsub|i>),d<rsub|i>)\<times\>L<rsub|n>(A(p<rsub|i>),d<rsub|i>,t)>|<with|math-display|true|lim<rsub|T\<to\>T<rsub|t*h>>J<rsub|e>\<times\>(T-T<rsub|n*o*m*i*n*a*l>)>><next-line>\<times\><frac|1|<with|math-display|true|<big|sum><rsup|c*h*i*p,D*R*A*M,H*T,H*D*D><big|int><rsub|t=0><rsup|t=L<rsub|A>>v(t)i(t)d*t>>
  </equation*>

  \;

  \;

  \;
</body>