#!/bin/bash
echo "In the container:"
echo "source resy-cooker.sh"
echo "Press <ENTER> to go on"
read r
set -x
docker run --rm -it -v ${PWD}:${PWD} -v ${PWD}:/workdir reliableembeddedsystems/poky-container:ubuntu-16.04 --workdir=/workdir
set +x
