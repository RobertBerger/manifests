#!/bin/bash
<<<<<<< HEAD
CONTAINER="reliableembeddedsystems/sdk-container:ubuntu-18.04-gcc-9"
#CONTAINER="reslocal/sdk-container:latest"
set -x
docker pull ${CONTAINER}
docker run -e TARGET_UID=$(id -u ${USER}) -e TARGET_GID=$(stat -c "%g" /home/${USER}) -v  /home/${USER}:/home/sdk -v /opt:/opt -v /workdir:/workdir -v /home/${USER}/projects:/projects  -v /tftpboot:/tftpboot --interactive --tty --entrypoint=/usr/bin/entrypoint.sh ${CONTAINER} --login
=======
CONTAINER="reliableembeddedsystems/sdk-container:2021-01-17-master-local-gcc-9-ub18"
#CONTAINER="reliableembeddedsystems/sdk-container:ubuntu-18.04-gcc-9"
#CONTAINER="reslocal/sdk-container:latest"
set -x
docker pull ${CONTAINER}
docker run -e TARGET_UID=$(id -u ${USER}) -e TARGET_GID=$(stat -c "%g" /home/${USER}) -v /home/${USER}/yocto-download:/home/sdk/yocto-download -v /home/${USER}:/home/sdk -v /opt:/opt -v /workdir:/workdir -v /home/${USER}/projects:/projects  -v /tftpboot:/tftpboot --interactive --tty --entrypoint=/usr/bin/entrypoint.sh ${CONTAINER} --login
>>>>>>> master
set +x
