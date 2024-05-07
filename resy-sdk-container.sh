#!/bin/bash
#CONTAINER="reliableembeddedsystems/sdk-container:2021-01-17-master-local-gcc-9-ub18"
#CONTAINER="reslocal/sdk-container:latest"
#CONTAINER="reliableembeddedsystems/sdk-container:2021-05-31-master-local-gcc-9-ub18"
#CONTAINER="reliableembeddedsystems/sdk-container:2021-09-14-master-local-icecc-ub20"
#CONTAINER="reliableembeddedsystems/sdk-container:2023-08-01-master-local-icecc-ub22"
CONTAINER="reliableembeddedsystems/sdk-container:2023-09-01-master-local-icecc-ub22"
GITPOD_CMD="--add-host gitpod:192.168.42.40"

# remove currently running containers
echo "+ ID_TO_KILL=\$(docker ps -a -q  --filter ancestor=${CONTAINER})"
ID_TO_KILL=$(docker ps -a -q  --filter ancestor=${CONTAINER})

echo "+ docker ps -a"
docker ps -a

# -->

CONTAINER_ID_TO_STOP=${ID_TO_KILL}

RUNNING=$(docker inspect --format="{{ .State.Running }}" $CONTAINER_ID_TO_STOP 2> /dev/null)

if [ $? -ne 1 ]; then
  echo "+ docker stop $CONTAINER_ID_TO_STOP"
  /usr/bin/docker stop $CONTAINER_ID_TO_STOP
fi

#echo "+ docker stop ${ID_TO_KILL}"
#docker stop ${ID_TO_KILL}

# <--

# -->

CONTAINER_ID_TO_RM=${ID_TO_KILL}

RUNNING=$(docker inspect --format="{{ .State.Running }}" $CONTAINER_ID_TO_RM 2> /dev/null)

if [ $? -ne 1 ]; then
  echo "+ docker rm --force $CONTAINER_ID_TO_RM"
  /usr/bin/docker rm --force $CONTAINER_ID_TO_RM
fi

#echo "+ docker rm -f ${ID_TO_KILL}"
#docker rm -f ${ID_TO_KILL}

# <--

# -->

CONTAINER_TAG_TO_RM=sdk-container

RUNNING=$(docker inspect --format="{{ .State.Running }}" $CONTAINER_TAG_TO_RM 2> /dev/null)

if [ $? -ne 1 ]; then
  echo "+ docker rm --force $CONTAINER_TAG_TO_RM"
  /usr/bin/docker rm --force $CONTAINER_TAG_TO_RM
fi

#echo "+ docker rm -f sdk-container"
#docker rm -f sdk-container

# <--

echo "+ docker ps -a"
docker ps -a

set -x
docker pull ${CONTAINER}
docker run ${GITPOD_CMD} --name sdk-container -e TARGET_UID=$(id -u ${USER}) -e TARGET_GID=$(stat -c "%g" /home/${USER}) -v /home/${USER}/yocto-download:/home/sdk/yocto-download -v /home/${USER}:/home/sdk -v /opt:/opt -v /workdir:/workdir -v /home/${USER}/projects:/projects  -v /tftpboot:/tftpboot --interactive --tty --entrypoint=/usr/bin/entrypoint.sh ${CONTAINER} --login
set +x
