#!/bin/bash

set +x

#export TMPL="container-x86-64-java"
#export BUILD="app-container-image-java-examples-oci"
#export LOGFILE="/workdir/${TMPL}-${BUILD}.txt"
# needed for killall_bitbake from host
#export BUILDDIR="/workdir/build/container-x86-64-java"

export TMPL="container-x86-64-golang"
export BUILD="app-container-image-go"
export LOGFILE="/workdir/${TMPL}-${BUILD}.txt"
# needed for killall_bitbake from host
export BUILDDIR="/workdir/build/${TMPL}"


/workdir/killall_bitbake.sh

if [ -f ${LOGFILE} ]; 
then
  rm -f ${LOGFILE}
  touch ${LOGFILE}
fi

tail -f ${LOGFILE} &

(time /workdir/resy-poky-container.sh ${TMPL} ${BUILD} >> ${LOGFILE}) 2>&1 | tee -a ${LOGFILE}

#sudo shutdown -h now
