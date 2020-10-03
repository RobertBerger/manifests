#!/bin/bash
SDKDIR="/home/${USER}/projects/sdk"
CONTAINER="reliableembeddedsystems/extsdk-container:ubuntu-18.04-gcc-9"
set -x
#docker pull reliableembeddedsystems/extsdk-container:ubuntu-18.04-gcc-9
#docker run --rm -it -v /opt:/opt -v ${SDKDIR}:/workdir -v /home/${USER}/projects:/projects -v /home/student:/student reliableembeddedsystems/extsdk-container:ubuntu-16.04
#docker run --rm -it -v /opt:/opt -v ${SDKDIR}:/workdir -v /home/${USER}/projects:/projects -v /home/student:/student reliableembeddedsystems/extsdk-container:ubuntu-18.04-gcc-9
#docker run --rm -it -v /opt:/opt -v ${SDKDIR}:/workdir -v /home/${USER}/projects:/projects -v /home/student:/student reslocal/extsdk-container:latest
docker run --rm -it -v ${SDKDIR}:/workdir ${CONTAINER}
set +x
