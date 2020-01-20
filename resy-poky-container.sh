#!/bin/bash
echo "In the container:"
echo "source resy-cooker.sh"
echo "Press <ENTER> to go on"
read r
MIRROR_IP=$(getent ahostsv4 mirror | awk '{print $1}' | head -1)
set -x
docker pull reliableembeddedsystems/poky-container:ubuntu-16.04
docker run --rm -it --add-host mirror:${MIRROR_IP} -v ${HOME}/projects:/projects -v /opt:/nfs -v ${PWD}:${PWD} -v ${PWD}:/workdir reliableembeddedsystems/poky-container:ubuntu-16.04 --workdir=/workdir
set +x
