#!/bin/bash
SDKDIR="/home/${USER}/projects/sdk"
#URL="https://vlab3.dyndns.org/sdk/sdk-installer.sh"
#URL="http://192.168.42.105/sdk/sdk-installer.sh"
URL="http://mirror.res.training/sdk/sdk-installer.sh"
CONTAINER="reliableembeddedsystems/extsdk-container:ubuntu-18.04-gcc-9"
if wget -q --method=HEAD ${URL};
 then
  echo "${URL} exists."
 else
  echo "${URL} does not exist."
  exit
fi

if [ ! -d ${SDKDIR} ];
then
   mkdir -p ${SDKDIR}
else
   echo "${SDKDIR} exists"
   ls ${SDKDIR}
   echo "you might want to erase this"
   exit
fi
set -x
docker pull ${CONTAINER}
#docker run --rm -it -v ${SDKDIR}:/workdir reliableembeddedsystems/extsdk-container:ubuntu-16.04 --url ${URL}
#docker run --rm -it -v ${SDKDIR}:/workdir reliableembeddedsystems/extsdk-container:ubuntu-18.04-gcc-9 --url ${URL}
docker run --rm -it -v /opt:/opt -v ${SDKDIR}:/workdir -v /home/${USER}/projects:/projects -v /home/student:/student ${CONTAINER} --url ${URL}
set +x
