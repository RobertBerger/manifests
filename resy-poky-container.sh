#!/bin/bash

CONTAINER="reliableembeddedsystems/poky-container:ubuntu-16.04"
#CONTAINER="reliableembeddedsystems/poky-container:ubuntu-16.04-gui"
#CONTAINER="reliableembeddedsystems/poky-container:ubuntu-16.04-gcc-6"
#CONTAINER="reliableembeddedsystems/poky-container:ubuntu-16.04-gcc-8"
#CONTAINER="reliableembeddedsystems/poky-container:ubuntu-16.04-gcc-9"

# --> GUI X-forwarding
# !!! For GUI to work in you host Linux you need to set
#
# in /etc/ssh/sshd_config
#    X11UseLocalhost no
#
# see: https://stackoverflow.com/questions/48235040/run-x-application-in-a-docker-container-reliably-on-a-server-connected-via-ssh-w

#XSOCK=/tmp/.X11-unix
#XAUTH=/tmp/.docker.xauth
#xauth nlist $DISPLAY | sed -e 's/^..../ffff/' | sudo xauth -f $XAUTH nmerge -
#sudo chmod 777 $XAUTH
#X11PORT=`echo $DISPLAY | sed 's/^[^:]*:\([^\.]\+\).*/\1/'`
#TCPPORT=`expr 6000 + $X11PORT`
#DISPLAY=`echo $DISPLAY | sed 's/^[^:]*\(.*\)/172.17.0.1\1/'`

# local GUI:
#GUI="-v /tmp/.X11-unix:/tmp/.X11-unix -e DISPLAY=unix$DISPLAY"

# GUI via ssh forwarding (--net host required?)
#GUI="-e DISPLAY=$DISPLAY -v $XSOCK:$XSOCK -v $XAUTH:$XAUTH -e XAUTHORITY=$XAUTH --net host"
#GUI="-e DISPLAY=$DISPLAY -v $XSOCK:$XSOCK -v $XAUTH:$XAUTH -e XAUTHORITY=$XAUTH"
# <-- GUI X-forwarding

#echo "In the container:"
#echo "source resy-cooker.sh"
#echo "Press <ENTER> to go on"
#read r
MIRROR_IP=$(getent ahostsv4 mirror | awk '{print $1}' | head -1)
set -x
docker pull ${CONTAINER}

if [ "$#" -eq "0" ]; then
  set +x
  echo " -- interactive mode --"
  echo "source resy-cooker.sh in container"
  echo "+ press <ENTER> to go on"
  read r
  set -x
  docker run --name poky_container --rm -it --add-host mirror:${MIRROR_IP} ${GUI} -v ${HOME}/projects:/projects -v /opt:/nfs -v ${PWD}:${PWD} -v ${PWD}:/workdir ${CONTAINER} --workdir=/workdir
else
#if [ "$#" -eq "1" ]; then
#  echo " -- interactive mode + MACHINE --"
#  docker run --name poky_container --rm -it --add-host mirror:${MIRROR_IP} ${GUI} -v ${HOME}/projects:/projects -v /opt:/nfs -v ${PWD}:${PWD} -v ${PWD}:/workdir ${CONTAINER} --workdir=/workdir ./resy-cooker.sh $1
#fi

#ocker run --name poky_container --rm -it --add-host mirror:${MIRROR_IP} ${GUI} -v ${HOME}/projects:/projects -v /opt:/nfs -v ${PWD}:${PWD} -v ${PWD}:/workdir ${CONTAINER} --workdir=/workdir ./resy-cooker.sh $1

#### build all 
#docker run --name poky_container --rm -it --add-host mirror:${MIRROR_IP} ${GUI} --env BUILD_ALL=yes -v ${HOME}/projects:/projects -v /opt:/nfs -v ${PWD}:${PWD} -v ${PWD}:/workdir ${CONTAINER} --workdir=/workdir ./resy-cooker.sh $1 $2

#### build non interactive
#docker run --name poky_container --rm -it --add-host mirror:${MIRROR_IP} ${GUI} -v ${HOME}/projects:/projects -v /opt:/nfs -v ${PWD}:${PWD} -v ${PWD}:/workdir ${CONTAINER} --workdir=/workdir ./resy-cooker.sh $1 $2
docker run --name poky_container --rm -t --add-host mirror:${MIRROR_IP} ${GUI} -v ${HOME}/projects:/projects -v /opt:/nfs -v ${PWD}:${PWD} -v ${PWD}:/workdir ${CONTAINER} --workdir=/workdir ./resy-cooker.sh $1 $2
fi
set +x
