#!/bin/bash
# kill all instances of bitbake
ps -ef | grep bitbake
for pid in $(ps -ef | awk '/\/poky\/bitbake\/bin\/bitbake/ {print $2}'); do kill -9 $pid; done
ps -ef | grep bitbake
echo "rm -f ${BUILDDIR}/hashserve.sock"
rm -f ${BUILDDIR}/hashserve.sock
