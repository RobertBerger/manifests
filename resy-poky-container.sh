#!/bin/bash

# this enables building all the images 
# for a specific MACHINE as defined in resy-cooker.sh
# set to "yes" if you want this to happen in non-interactive mode
BUILD_ALL_VAR="no"
USE_GUI="no"
USE_MIRROR="yes"
DOCKER_PULL="yes"
USE_ICECC="yes"
USE_QEMU="no"

if [[ $USE_QEMU = yes ]]; then
   sudo modprobe tun
   #QEMU_PARAMS="--privileged"
   QEMU="--privileged -v /dev/net/tun:/dev/net/tun"
fi

if [[ $USE_ICECC = yes ]]; then
   # iceccd port
   # EXPOSE 10245 8765/TCP 8765/UDP 8766
   #ICECC="--net=host -p ::10245/tcp -p ::8765/tcp -p ::8766/tcp -p ::8765/udp"
   ICECC="--net=host "
fi

#docker login

# --> check for ip address and subnet
#WIREDIF="$(ip -o -4 route show to default | grep en | awk '{print $5}')"
#
#if [ -z "$WIREDIF" ]
#then
#      echo "\$WIREDIF is empty"
#      WIREDIF="$(ip -o -4 route show to default | grep eth | awk '{print $5}')"
#else
#      echo "\$WIREDIF is $WIREDIF"
#fi
#
#BUILDHOST="$(ip -4 addr show ${WIREDIF} | grep -oP "(?<=inet ).*(?=/)")"
#echo "BUILDHOST: ${BUILDHOST}"
#SUBNET=`echo  ${BUILDHOST} | cut -d"." -f1-3`
#echo "SUBNET: ${SUBNET}"
#read r
# <-- check for ip address and subnet

# with jenkins we want non-gui mode, without it we want gui mode
if [[ $WORKSPACE = *jenkins* ]]; then
   #CONTAINER="reliableembeddedsystems/poky-container:ubuntu-16.04"
   USE_GUI="no"
else
   ##CONTAINER="reliableembeddedsystems/poky-container:ubuntu-16.04-gui"
   #CONTAINER="reliableembeddedsystems/poky-container:ubuntu-18.04-gui-gcc-9"
   #CONTAINER="reslocal/poky-container:ubuntu-18.04"
   #CONTAINER="reliableembeddedsystems/poky-container:2020-07-26-master-local-gcc-9-gui-ub18"
   CONTAINER="reliableembeddedsystems/poky-container:2021-05-07-master-local-gcc-9-gui-icecc-ub18"
fi

if [[ $USE_GUI = no ]]; then
   ##CONTAINER="reliableembeddedsystems/poky-container:ubuntu-16.04"
   #CONTAINER="reliableembeddedsystems/poky-container:ubuntu-18.04-gcc-9"
   #CONTAINER="reslocal/poky-container:ubuntu-18.04"
   #CONTAINER="reliableembeddedsystems/poky-container:2020-07-26-master-local-gcc-9-gui-ub18"
   CONTAINER="reliableembeddedsystems/poky-container:2021-05-07-master-local-gcc-9-gui-icecc-ub18"
fi

#echo "CONTAINER= $CONTAINER"

#read r

#CONTAINER="reliableembeddedsystems/poky-container:ubuntu-16.04-gcc-6"
#CONTAINER="reliableembeddedsystems/poky-container:ubuntu-16.04-gcc-8"
#CONTAINER="reliableembeddedsystems/poky-container:ubuntu-16.04-gcc-9"

#CONTAINER="reslocal/poky-container:ubuntu-16.04"

# --> GUI X-forwarding
# !!! For GUI to work in you host Linux you need to set
#
# in /etc/ssh/sshd_config
#    X11UseLocalhost no
#
# see: https://stackoverflow.com/questions/48235040/run-x-application-in-a-docker-container-reliably-on-a-server-connected-via-ssh-w

if [[ $USE_GUI = *yes* ]]; then

XSOCK=/tmp/.X11-unix
XAUTH=/tmp/.docker.xauth

if [ -z "$DISPLAY" ]; then
   echo "+ problem (1) using gui - no DISPLAY variable set"
   echo "fix this, or choose USE_GUI=\"no\""
   exit 1
fi

xauth nlist $DISPLAY | sed -e 's/^..../ffff/' | sudo xauth -f $XAUTH nmerge -
if [ $? -ne 0 ]; then
   echo "+ problem (2) using gui"
   exit 1
fi

sudo chmod 777 $XAUTH
if [ $? -ne 0 ]; then
   echo "+ problem (3) using gui"
   exit 1
fi

X11PORT=`echo $DISPLAY | sed 's/^[^:]*:\([^\.]\+\).*/\1/'`
TCPPORT=`expr 6000 + $X11PORT`
DISPLAY=`echo $DISPLAY | sed 's/^[^:]*\(.*\)/172.17.0.1\1/'`

# local GUI:
#GUI="-v /tmp/.X11-unix:/tmp/.X11-unix -e DISPLAY=unix$DISPLAY"

# GUI via ssh forwarding (--net host required?)
#GUI="-e DISPLAY=$DISPLAY -v $XSOCK:$XSOCK -v $XAUTH:$XAUTH -e XAUTHORITY=$XAUTH --net host"
GUI="-e DISPLAY=$DISPLAY -v $XSOCK:$XSOCK -v $XAUTH:$XAUTH -e XAUTHORITY=$XAUTH"
# <-- GUI X-forwarding
fi # use gui

#echo "In the container:"
#echo "source resy-cooker.sh"
#echo "Press <ENTER> to go on"
#read r

if [[ $USE_MIRROR = *yes* ]]; then
   #MIRROR_IP=$(getent ahostsv4 mirror | awk '{print $1}' | head -1)
   #MIRROR_CMD="--add-host mirror:${MIRROR_IP}"
   MIRROR_CMD="--add-host mirror:192.168.42.1"
fi # use mirror

set +x
if [[ $DOCKER_PULL = *yes* ]]; then
set -x
docker pull ${CONTAINER}
set +x
fi

set +x
if [ "$#" -eq "0" ]; then
  echo " -- interactive mode --"
  echo "source /workdir/resy-cooker.sh in container"
  echo "+ press <ENTER> to go on"
  read r
  if [[ $WORKSPACE = *jenkins* ]]; then
  docker run --name poky_container --rm -it ${MIRROR_CMD} ${QEMU} ${ICECC} ${GUI} -v ${HOME}/projects:/projects -v /opt:/nfs -v ${PWD}:${PWD} -v ${PWD}:/workdir ${CONTAINER} --workdir=/workdir; [ $? -ne 0 ] && printf "\e[31m+Docker ERRORS found (1)\e[0m\n" && exit 1
  else
  set -x
  docker run --name poky_container --rm -it ${MIRROR_CMD} ${QEMU} ${ICECC} ${GUI} -v ${HOME}/projects:/projects -v /opt:/nfs -v ${PWD}:${PWD} -v ${PWD}:/workdir ${CONTAINER} --workdir=/workdir
  fi
else
  set +x
  echo " -- non interactive mode --"
  set -x
#if [ "$#" -eq "1" ]; then
#  echo " -- interactive mode + MACHINE --"
#  docker run --name poky_container --rm -it --add-host mirror:${MIRROR_IP} ${GUI} -v ${HOME}/projects:/projects -v /opt:/nfs -v ${PWD}:${PWD} -v ${PWD}:/workdir ${CONTAINER} --workdir=/workdir ./resy-cooker.sh $1
#fi

#ocker run --name poky_container --rm -it --add-host mirror:${MIRROR_IP} ${GUI} -v ${HOME}/projects:/projects -v /opt:/nfs -v ${PWD}:${PWD} -v ${PWD}:/workdir ${CONTAINER} --workdir=/workdir ./resy-cooker.sh $1

#### build all 
#docker run --name poky_container --rm -it --add-host mirror:${MIRROR_IP} ${GUI} --env BUILD_ALL=yes -v ${HOME}/projects:/projects -v /opt:/nfs -v ${PWD}:${PWD} -v ${PWD}:/workdir ${CONTAINER} --workdir=/workdir ./resy-cooker.sh $1 $2

#### build non interactive
#docker run --name poky_container --rm -it --add-host mirror:${MIRROR_IP} ${GUI} -v ${HOME}/projects:/projects -v /opt:/nfs -v ${PWD}:${PWD} -v ${PWD}:/workdir ${CONTAINER} --workdir=/workdir ./resy-cooker.sh $1 $2

  if [[ $WORKSPACE = *jenkins* ]]; then
     # with jenkins interactive mode is not possible
     INTERACIVE=""
     export BUILDDIR="/workdir/build/$1"
     /workdir/killall_bitbake.sh
  else
     INTERACTIVE="-i"
  fi

  set +x

  if [[ $WORKSPACE = *jenkins* ]]; then
  docker run --name poky_container --rm ${INTERACTIVE} -t ${MIRROR_CMD} ${QEMU} ${ICECC} ${GUI} --env BUILD_ALL=${BUILD_ALL_VAR} -v ${HOME}/projects:/projects -v /opt:/nfs -v ${PWD}:${PWD} -v ${PWD}:/workdir ${CONTAINER} --workdir=/workdir ./resy-cooker.sh $1 $2 ;[ $? -ne 0 ] && printf "\e[31m+ Docker ERRORS found (2)\e[0m\n" && exit 1
  else
  docker run --name poky_container --rm ${INTERACTIVE} -t ${MIRROR_CMD} ${QEMU} ${ICECC} ${GUI} --env BUILD_ALL=${BUILD_ALL_VAR} -v ${HOME}/projects:/projects -v /opt:/nfs -v ${PWD}:${PWD} -v ${PWD}:/workdir ${CONTAINER} --workdir=/workdir ./resy-cooker.sh $1 $2
  fi
fi # non interactve mode
set +x
