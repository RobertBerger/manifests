#!/bin/bash
#CONTAINER="reliableembeddedsystems/poky-container:ubuntu-16.04"
#CONTAINER="reliableembeddedsystems/poky-container:ubuntu-16.04-gcc-6"
#CONTAINER="reliableembeddedsystems/poky-container:ubuntu-16.04-gcc-8"
CONTAINER="reliableembeddedsystems/poky-container:ubuntu-16.04-gcc-9"
echo "In the container:"
echo "source resy-cooker.sh"
echo "Press <ENTER> to go on"
read r
MIRROR_IP=$(getent ahostsv4 mirror | awk '{print $1}' | head -1)
set -x
docker pull ${CONTAINER}
docker run --name poky_container --rm -it --add-host mirror:${MIRROR_IP} -v ${HOME}/projects:/projects -v /opt:/nfs -v ${PWD}:${PWD} -v ${PWD}:/workdir ${CONTAINER} --workdir=/workdir
set +x
