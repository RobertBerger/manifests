#!/bin/bash
SDKDIR="/home/${USER}/projects/sdk"
set -x
docker run --rm -it -v /opt:/opt -v ${SDKDIR}:/workdir -v /home/${USER}/projects:/projects -v /home/student:/student reliableembeddedsystems/extsdk-container:ubuntu-16.04
set +x
