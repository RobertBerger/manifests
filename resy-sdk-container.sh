#!/bin/bash
#CONTAINER="reliableembeddedsystems/sdk-container:2021-01-17-master-local-gcc-9-ub18"
#CONTAINER="reslocal/sdk-container:latest"
CONTAINER="reliableembeddedsystems/sdk-container:2021-05-31-master-local-gcc-9-ub18"
GITPOD_CMD="--add-host gitpod:192.168.42.40"
set -x
docker pull ${CONTAINER}
docker run ${GITPOD_CMD} --name sdk-container -e TARGET_UID=$(id -u ${USER}) -e TARGET_GID=$(stat -c "%g" /home/${USER}) -v /home/${USER}/yocto-download:/home/sdk/yocto-download -v /home/${USER}:/home/sdk -v /opt:/opt -v /workdir:/workdir -v /home/${USER}/projects:/projects  -v /tftpboot:/tftpboot --interactive --tty --entrypoint=/usr/bin/entrypoint.sh ${CONTAINER} --login
set +x
