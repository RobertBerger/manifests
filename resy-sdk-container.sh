#!/bin/bash
#CONTAINER="reliableembeddedsystems/sdk-container:2021-01-17-master-local-gcc-9-ub18"
#CONTAINER="reslocal/sdk-container:latest"
#CONTAINER="reliableembeddedsystems/sdk-container:2021-05-31-master-local-gcc-9-ub18"
#CONTAINER="reliableembeddedsystems/sdk-container:2021-09-14-master-local-icecc-ub20"
CONTAINER="reliableembeddedsystems/sdk-container:2023-08-01-master-local-icecc-ub22"
GITPOD_CMD="--add-host gitpod:192.168.42.40"

# remove currently running containers
echo "+ ID_TO_KILL=\$(docker ps -a -q  --filter ancestor=${CONTAINER})"
ID_TO_KILL=$(docker ps -a -q  --filter ancestor=${CONTAINER})

echo "+ docker ps -a"
docker ps -a
echo "+ docker stop ${ID_TO_KILL}"
docker stop ${ID_TO_KILL}
echo "+ docker rm -f ${ID_TO_KILL}"
docker rm -f ${ID_TO_KILL}
echo "+ docker ps -a"
docker ps -a


set -x
docker pull ${CONTAINER}
docker run ${GITPOD_CMD} --name sdk-container -e TARGET_UID=$(id -u ${USER}) -e TARGET_GID=$(stat -c "%g" /home/${USER}) -v /home/${USER}/yocto-download:/home/sdk/yocto-download -v /home/${USER}:/home/sdk -v /opt:/opt -v /workdir:/workdir -v /home/${USER}/projects:/projects  -v /tftpboot:/tftpboot --interactive --tty --entrypoint=/usr/bin/entrypoint.sh ${CONTAINER} --login
set +x
