#!/bin/bash
#echo "In the container:"
#echo "source resy-cooker.sh"
#echo "Press <ENTER> to go on"
#read r
set -x
#docker run --rm -it -v ${PWD}:${PWD} -v ${PWD}:/workdir reliableembeddedsystems/poky-container:ubuntu-16.04 --workdir=/workdir
docker run --rm -it -v ${PWD}:${PWD} -v /opt:/opt -v /home/student/projects/sdk:/workdir -v /home/student/projects:/projects reliableembeddedsystems/extsdk-container:ubuntu-16.04
#docker run --rm -it -v /opt/poky/3.0.1/multi-v7-ml/imx6q-phytec-mira-rdk-nand:/opt/poky/3.0.1/multi-v7-ml/imx6q-phytec-mira-rdk-nand -v /home/student/projects:/projects --workdir=/opt/poky/3.0.1/multi-v7-ml/imx6q-phytec-mira-rdk-nand reslocal/extsdk-container
set +x
