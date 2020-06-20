#!/bin/bash
SDKDIR="/home/${USER}/projects/sdk"
#URL="https://vlab3.dyndns.org/sdk/sdk-installer.sh"
#URL="http://192.168.42.105/sdk/sdk-installer.sh"
URL="http://mirror.res.training/sdk/sdk-installer.sh"
set -x
if [ ! -d ${SDKDIR} ];
then
   mkdir -p ${SDKDIR}
fi 
docker run --rm -it -v ${SDKDIR}:/workdir reliableembeddedsystems/extsdk-container:ubuntu-16.04 --url ${URL}
set +x
