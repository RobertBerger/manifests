#!/bin/bash
CONTAINER="reliableembeddedsystems/sdk-container:ubuntu-18.04-gcc-9"
set -x
docker pull ${CONTAINER}
docker run -e TARGET_UID=$(id -u ${USER}) -e TARGET_GID=$(stat -c "%g" /home/${USER}) -v /opt:/opt -v /workdir:/workdir -v /home/${USER}/projects:/projects -v /home/${USER}:/student -v /tftpboot:/tftpboot --interactive --tty --entrypoint=/usr/bin/entrypoint.sh ${CONTAINER} --login
set +x
