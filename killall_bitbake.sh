#!/bin/bash
# kill all instances of bitbake
#set -x
ps -ef | grep bitbake
#for pid in $(ps -ef | awk '/\/poky\/bitbake\/bin\/bitbake/ {print $2}'); do
for pid in $(ps -ef | awk '/\/bitbake\/bin\/bitbake/ {print $2}'); do
        echo "do kill -9 ${pid}";
        kill -9 $pid;
done
ps -ef | grep bitbake
echo "rm -f ${BUILDDIR}/hashserve.sock"
rm -f ${BUILDDIR}/hashserve.sock
#set +x
