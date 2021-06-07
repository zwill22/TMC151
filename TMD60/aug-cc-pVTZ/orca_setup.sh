#!/bin/bash

nproc=${1}

/home/zw18965/gmtkn30/scripts/run-dir.sh 24 ${nproc} ${PWD} genall

perl -pi -e 's/144gb/144gb:mpiprocs=24/g' *.sub
sed -i '/entosRoot/d' *.sub 
sed -i '/module load/d' *.sub 
perl -pi -e 's/# Set up entos/module load lib\/openmpi\nmodule load apps\/orca\nexport orcadir\=\"\/sw\/apps\/orca\/orca\_4\_2\_0\_linux\_x86\-64\_openmpi314\"\nexport RSH_COMMAND\=\"\/usr\/bin\/ssh \-x\"/g' *.sub
perl -pi -e 's/Run entos/Run orca/g' *.sub
perl -pi -e 's/qcore -n 24/\${orcadir}\/orca/g' *.sub
