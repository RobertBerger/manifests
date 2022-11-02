#!/bin/bash

# only if this script is sourced it will be able to bitbake from the shell

#echo "\$#: $#"

#read r

pushd /workdir

if [[ $_ == $0 ]]; then
   echo "you need to source me:"
   echo "source /workdir/$(basename ${0})"
   exit
fi

# do not user HERE here ;)
#HERE=$(pwd)

if [ ! -d build ]; then
   mkdir build
fi

cd build

# For jenkins I do the setup of meta-data as without it, via resy.sh

declare -A MYMAP
# MYMAP[MACHINE or MACHINE-sw-variant]="<image>"

# --> container-x86-64
# jenkins:
# HERE=$(pwd)
# cd /workdir
# ./resy-poky-container.sh container-x86-64 app-container-image-redis-oci
# ./resy-poky-container.sh container-x86-64 app-container-image-mosquitto-oci
# ./resy-poky-container.sh container-x86-64 app-container-image-python3-nmap-srv-oci
# ./resy-poky-container.sh container-x86-64 app-container-image-python3-data-collector-oci
# ./resy-poky-container.sh container-x86-64 app-container-image-python3-mqttbrokerclient-oci
# ./resy-poky-container.sh container-x86-64 app-container-image-python3-mastermind-oci
# pwd
# cd ${HERE}
MYMAP[container-x86-64]="app-container-image-redis-oci app-container-image-mosquitto-oci app-container-image-python3-nmap-srv-oci app-container-image-python3-data-collector-oci app-container-image-python3-mqttbrokerclient-oci app-container-image-python3-mastermind-oci"
# <-- container-x86-64

# --> container-x86-64-master
# jenkins:
# HERE=$(pwd)
# cd /workdir
# ./resy-poky-container.sh container-x86-64 app-container-image-redis-oci
# ./resy-poky-container.sh container-x86-64 app-container-image-mosquitto-oci
# ./resy-poky-container.sh container-x86-64 app-container-image-python3-nmap-srv-oci
# ./resy-poky-container.sh container-x86-64 app-container-image-python3-data-collector-oci
# ./resy-poky-container.sh container-x86-64 app-container-image-python3-mqttbrokerclient-oci
# ./resy-poky-container.sh container-x86-64 app-container-image-python3-mastermind-oci
# pwd
# cd ${HERE}
MYMAP[container-x86-64-master]="app-container-image-lighttpd app-container-image-lighttpd-container-oci"
# <-- container-x86-64-master

# --> container-x86-64-java
MYMAP[container-x86-64-java]="app-container-image-java"
# <-- container-x86-64-java

# --> container-x86-64-java-master
MYMAP[container-x86-64-java-master]="app-container-image-java"
# <-- container-x86-64-java-master

# --> container-x86-64-tensorflow
MYMAP[container-x86-64-tensorflow]="app-container-image-tensorflow"
# <-- container-x86-64-tensorflow

# --> container-x86-64-tensorflow-master
MYMAP[container-x86-64-tensorflow-master]="app-container-image-tensorflow"
# <-- container-x86-64-tensorflow-master

# --> container-x86-64-golang
MYMAP[container-x86-64-golang]="app-container-image-go"
# <-- container-x86-64-golang

# --> container-x86-64-golang-master
MYMAP[container-x86-64-golang-master]="app-container-image-go"
# <-- container-x86-64-golang-master

# --> container-x86-64-tig
MYMAP[container-x86-64-tig]="image-influxdb-prebuilt image-influxdb-from-source app-container-image-influxdb-prebuilt app-container-image-influxdb-prebuilt-oci"
# <-- container-x86-64-tig

# --> container-x86-64-tig-master
MYMAP[container-x86-64-tig-master]="image-influxdb-prebuilt image-influxdb-from-source app-container-image-influxdb-prebuilt app-container-image-influxdb-prebuilt-oci"
# <-- container-x86-64-tig-master

# --> container-arm-v7
# jenkins:
# HERE=$(pwd)
# cd /workdir
# ./resy-poky-container.sh container-arm-v7 app-container-image-redis-oci
# ./resy-poky-container.sh container-arm-v7 app-container-image-mosquitto-oci
# ./resy-poky-container.sh container-arm-v7 app-container-image-python3-nmap-srv-oci
# ./resy-poky-container.sh container-arm-v7 app-container-image-python3-data-collector-oci
# ./resy-poky-container.sh container-arm-v7 app-container-image-python3-mqttbrokerclient-oci
# ./resy-poky-container.sh container-arm-v7 app-container-image-python3-mastermind-oci
# pwd
# cd ${HERE}
MYMAP[container-arm-v7]="app-container-image-redis-oci app-container-image-mosquitto-oci app-container-image-python3-nmap-srv-oci app-container-image-python3-data-collector-oci app-container-image-python3-mqttbrokerclient-oci app-container-image-python3-mastermind-oci"
# <-- container-arm-v7

# --> container-arm-v7-master
# jenkins:
# HERE=$(pwd)
# cd /workdir
# ./resy-poky-container.sh container-arm-v7-master app-container-image-telegraf-prebuilt-oci-container-arm-v7
# pwd
# cd ${HERE}
MYMAP[container-arm-v7-master]="app-container-image-telegraf-prebuilt-oci-container-arm-v7"
# <-- container-arm-v7-master

# --> container-arm-v7-tig
# @@@ TODO
MYMAP[container-arm-v7-tig]="influxdb"
# <-- container-arm-v7-tig

# --> container-arm-v7-tensorflow-master
MYMAP[container-arm-v7-tensorflow-master]="app-container-image-tensorflow"
# <-- container-arm-v7-tensorflow-master

# --> container-arm-v7-phoronix
MYMAP[container-arm-v7-phoronix]="app-container-image-phoronix app-container-image-phoronix-oci"
# <-- container-arm-v7-phoronix

# --> container-raspberrypi-4-64-ml-phoronix
MYMAP[container-raspberrypi-4-64-ml-phoronix]="app-container-image-phoronix app-container-image-phoronix-oci"
# <-- container-raspberrypi-4-64-ml-phoronix



# --> multi-v7-ml
# jenkins:
# HERE=$(pwd)
# cd /workdir
# ./resy-poky-container.sh multi-v7-ml core-image-minimal
# ./resy-poky-container.sh multi-v7-ml core-image-sato-sdk
# ./resy-poky-container.sh multi-v7-ml 'core-image-sato-sdk -c populate_sdk'
# ./resy-poky-container.sh multi-v7-ml 'core-image-sato-sdk -c populate_sdk_ext'
# pwd
# cd ${HERE}
MYMAP[multi-v7-ml]="core-image-minimal core-image-sato-sdk"
# <-- multi-v7-ml

# --> multi-v7-ml-master
# jenkins:
# HERE=$(pwd)
# cd /workdir
# ./resy-poky-container.sh multi-v7-ml-master core-image-minimal
# ./resy-poky-container.sh multi-v7-ml-master core-image-sato-sdk
# ./resy-poky-container.sh multi-v7-ml-master 'core-image-sato-sdk -c populate_sdk'
# ./resy-poky-container.sh multi-v7-ml-master 'core-image-sato-sdk -c populate_sdk_ext'
# pwd
# cd ${HERE}
MYMAP[multi-v7-ml-master]="core-image-minimal core-image-sato-sdk"
# <-- multi-v7-ml-master

# --> multi-v7-ml-gdbserver-master
# jenkins:
# HERE=$(pwd)
# cd /workdir
# ./resy-poky-container.sh multi-v7-ml-master core-image-minimal
# ./resy-poky-container.sh multi-v7-ml-master 'core-image-minimal -c populate_sdk'
# pwd
# cd ${HERE}
MYMAP[multi-v7-ml-gdbserver-master]="core-image-minimal"
# <-- multi-v7-ml-gdbserver-master

# --> multi-v7-ml-debuginfod-master
# jenkins:
# HERE=$(pwd)
# cd /workdir
# ./resy-poky-container.sh multi-v7-ml-master core-image-minimal
# pwd
# cd ${HERE}
MYMAP[multi-v7-ml-debuginfod-master]="core-image-minimal"
# <-- multi-v7-ml-debuginfod-master

# --> multi-v7-ml-virt-docker-master
# jenkins:
# HERE=$(pwd)
# cd /workdir
# ./resy-poky-container.sh multi-v7-ml-virt-docker-master core-image-minimal-virt-docker
# pwd
# cd ${HERE}
MYMAP[multi-v7-ml-virt-docker-master]="core-image-minimal-virt-docker"
# <-- multi-v7-ml-virt-docker-master


# --> multi-v7-ml-virt-podman-master
# jenkins:
# HERE=$(pwd)
# cd /workdir
# ./resy-poky-container.sh multi-v7-ml-virt-podman-master core-image-minimal-virt-podman
# pwd
# cd ${HERE}
MYMAP[multi-v7-ml-virt-podman-master]="core-image-minimal-virt-podman"
# <-- multi-v7-ml-virt-podman-master

# --> multi-v7-ml-bpf-master
MYMAP[multi-v7-ml-bpf-master]="core-image-minimal"
# <-- multi-v7-ml-bpf-master

# --> multi-v7-ml-qt5
# jenkins:
# HERE=$(pwd)
# cd /workdir
# ./resy-poky-container.sh multi-v7-ml core-image-minimal-qt5
# ./resy-poky-container.sh multi-v7-ml 'core-image-minimal-qt5 -c populate_sdk'
# ./resy-poky-container.sh multi-v7-ml core-image-minimal-base-qt5
# ./resy-poky-container.sh multi-v7-ml 'core-image-minimal-base-qt5 -c populate_sdk'
# pwd
# cd ${HERE}
MYMAP[multi-v7-ml-qt5]="core-image-minimal-qt5 core-image-minimal-base-qt5"
# <-- multi-v7-ml-qt5


# --> multi-v7-ml-debug
# jenkins:
# HERE=$(pwd)
# cd /workdir
# ./resy-poky-container.sh multi-v7-ml-debug core-image-minimal
# ./resy-poky-container.sh multi-v7-ml-debug core-image-sato-sdk
# ./resy-poky-container.sh multi-v7-ml-debug 'core-image-sato-sdk -c populate_sdk'
# ./resy-poky-container.sh multi-v7-ml-debug 'core-image-sato-sdk -c populate_sdk_ext'
# pwd
# cd ${HERE}
MYMAP[multi-v7-ml-debug]="core-image-minimal core-image-sato-sdk"
# <-- multi-v7-ml-debug

# --> multi-v7-ml-debug-training
# jenkins:
# HERE=$(pwd)
# cd /workdir
# ./resy-poky-container.sh multi-v7-ml-debug-training core-image-minimal
# ./resy-poky-container.sh multi-v7-ml-debug-training core-image-sato-sdk
# ./resy-poky-container.sh multi-v7-ml-debug-training 'core-image-sato-sdk -c populate_sdk'
# ./resy-poky-container.sh multi-v7-ml-debug-training 'core-image-sato-sdk -c populate_sdk_ext'
# pwd
# cd ${HERE}
MYMAP[multi-v7-ml-debug-training]="core-image-minimal core-image-sato-sdk"
# <-- multi-v7-ml-debug-training

# --> multi-v7-ml-debug-training-master
# jenkins:
# HERE=$(pwd)
# cd /workdir
# ./resy-poky-container.sh multi-v7-ml-debug-training-master core-image-minimal
# ./resy-poky-container.sh multi-v7-ml-debug-training-master core-image-sato-sdk
# ./resy-poky-container.sh multi-v7-ml-debug-training-master 'core-image-sato-sdk -c populate_sdk'
# ./resy-poky-container.sh multi-v7-ml-debug-training-master 'core-image-sato-sdk -c populate_sdk_ext'
# pwd
# cd ${HERE}
MYMAP[multi-v7-ml-debug-training-master]="core-image-minimal core-image-sato-sdk"
# <-- multi-v7-ml-debug-training-master


# --> multi-v7-ml-debug-training-libs
# jenkins:
# HERE=$(pwd)
# cd /workdir
# ./resy-poky-container.sh multi-v7-ml-debug-training-libs core-image-minimal
# pwd
# cd ${HERE}
MYMAP[multi-v7-ml-debug-training-libs]="core-image-minimal"
# <-- multi-v7-ml-debug-training-libs


# --> multi-v7-ml-debug-training-libs-master
# jenkins:
# HERE=$(pwd)
# cd /workdir
# ./resy-poky-container.sh multi-v7-ml-debug-training-libs-master core-image-minimal
# pwd
# cd ${HERE}
MYMAP[multi-v7-ml-debug-training-libs-master]="core-image-minimal"
# <-- multi-v7-ml-debug-training-libs-master


# --> multi-v7-ml-debug-training-pkgs
# jenkins:
# HERE=$(pwd)
# cd /workdir
# ./resy-poky-container.sh multi-v7-ml-debug-training-pkgs core-image-minimal
# pwd
# cd ${HERE}
MYMAP[multi-v7-ml-debug-training-pkgs]="core-image-minimal"
# <-- multi-v7-ml-debug-training-pkgs

# --> multi-v7-ml-pkgs
# jenkins:
# HERE=$(pwd)
# cd /workdir
# ./resy-poky-container.sh multi-v7-ml-pkgs core-image-minimal
# pwd
# cd ${HERE}
MYMAP[multi-v7-ml-pkgs]="core-image-minimal"
# <-- multi-v7-ml-pkgs

# --> multi-v7-ml-debug-training-lic
# jenkins:
# HERE=$(pwd)
# cd /workdir
# ./resy-poky-container.sh multi-v7-ml-debug-training-lic core-image-minimal
# pwd
# cd ${HERE}
MYMAP[multi-v7-ml-debug-training-lic]="core-image-minimal"
# <-- multi-v7-ml-debug-training-lic

# --> multi-v7-ml-virt
# jenkins:
# HERE=$(pwd)
# cd /workdir
# ./resy-poky-container.sh multi-v7-ml-virt core-image-minimal
# ./resy-poky-container.sh multi-v7-ml-virt core-image-minimal-virt-docker-ce
# pwd
# cd ${HERE}
MYMAP[multi-v7-ml-virt]="core-image-minimal core-image-minimal-virt-docker-ce"
# <-- multi-v7-ml-virt

# --> multi-v7-mender
# jenkins:
# HERE=$(pwd)
# cd /workdir
# ./resy-poky-container.sh multi-v7-mender core-image-minimal
# pwd
# cd ${HERE}
MYMAP[multi-v7-mender]="core-image-minimal"
# <-- multi-v7-mender

# --> multi-v7-ml-xenomai
# jenkins:
# HERE=$(pwd)
# cd /workdir
# ./resy-poky-container.sh multi-v7-ml-xenomai core-image-minimal-xenomai
# ./resy-poky-container.sh multi-v7-ml-xenomai core-image-minimal-xenomai-plus
# pwd
# cd ${HERE}
MYMAP[multi-v7-ml-xenomai]="core-image-minimal-xenomai core-image-minimal-xenomai-plus"
# <-- multi-v7-ml-xenomai

# --> multi-v7-ml-prt
# jenkins:
# HERE=$(pwd)
# cd /workdir
# ./resy-poky-container.sh multi-v7-ml-prt core-image-minimal-prt
# pwd
# cd ${HERE}
MYMAP[multi-v7-ml-prt]="core-image-minimal-prt"
# <-- multi-v7-ml-prt

# --> imx6q-phytec-mira-rdk-nand-wic
# jenkins:
# HERE=$(pwd)
# cd /workdir
# ./resy-poky-container.sh imx6q-phytec-mira-rdk-nand-wic core-image-minimal
# pwd
# cd ${HERE}
MYMAP[imx6q-phytec-mira-rdk-nand-wic]="core-image-minimal"
# <-- imx6q-phytec-mira-rdk-nand-wic

# --> imx6q-phytec-mira-rdk-nand-wic-master
# jenkins:
# HERE=$(pwd)
# cd /workdir
# ./resy-poky-container.sh imx6q-phytec-mira-rdk-nand-wic-master core-image-minimal
# pwd
# cd ${HERE}
MYMAP[imx6q-phytec-mira-rdk-nand-wic-master]="core-image-minimal"
# <-- imx6q-phytec-mira-rdk-nand-wic-master

# --> imx6q-phytec-mira-rdk-nand-npm-wic-master
# jenkins:
# HERE=$(pwd)
# cd /workdir
# ./resy-poky-container.sh imx6q-phytec-mira-rdk-nand-npm-wic-master core-image-minimal
# pwd
# cd ${HERE}
MYMAP[imx6q-phytec-mira-rdk-nand-npm-wic-master]="core-image-minimal"
# <-- imx6q-phytec-mira-rdk-nand-npm-wic-master


# --> zynq-zed-wic-master (mine)
# jenkins:
# HERE=$(pwd)
# cd /workdir
# ./resy-poky-container.sh zynq-zed-wic-master core-image-minimal
# pwd
# cd ${HERE}
MYMAP[zynq-zed-wic-master]="core-image-minimal"
# <-- zynq-zed-wic-master (mine)

# --> imx6q-phytec-mira-rdk-nand-virt-wic
# jenkins:
# HERE=$(pwd)
# cd /workdir
# ./resy-poky-container.sh imx6q-phytec-mira-rdk-nand-virt-wic core-image-minimal
# ./resy-poky-container.sh imx6q-phytec-mira-rdk-nand-virt-wic core-image-minimal-virt-docker-ce
# pwd
# cd ${HERE}
MYMAP[imx6q-phytec-mira-rdk-nand-virt-wic]="core-image-minimal core-image-minimal-virt-docker-ce"
# <-- imx6q-phytec-mira-rdk-nand-virt-wic

# --> qemux86-64-virt-master
# jenkins:
# HERE=$(pwd)
# cd /workdir
# ./resy-poky-container.sh qemux86-64-virt-master core-image-minimal
# ./resy-poky-container.sh qemux86-64-virt-master core-image-minimal-virt-docker-ce
# pwd
# cd ${HERE}
MYMAP[qemux86-64-virt-master]="core-image-minimal core-image-minimal-virt-docker-ce"
# <-- qemux86-64-virt-master

# --> intel-core2-32-master
# jenkins:
# HERE=$(pwd)
# cd /workdir
# ./resy-poky-container.sh intel-core2-32-master core-image-minimal
# pwd
# cd ${HERE}
MYMAP[intel-core2-32-master]="core-image-minimal"
# <-- intel-core2-32-master


# --> container-x86-64-ex-compact-docker-only
# jenkins:
# HERE=$(pwd)
# cd /workdir
# ./resy-poky-container.sh container-x86-64-ex-compact-docker-only app-container-image-lighttpd
# pwd
# cd ${HERE}
MYMAP[container-x86-64-ex-compact-docker-only]="app-container-image-lighttpd"
# <-- container-x86-64-ex-compact-docker-only

# --> container-x86-64-ex-compact-oci
# jenkins:
# HERE=$(pwd)
# cd /workdir
# ./resy-poky-container.sh container-x86-64-ex-compact-oci app-container-image-lighttpd-oci
# pwd
# cd ${HERE}
MYMAP[container-x86-64-ex-compact-oci]="app-container-image-lighttpd-oci"
# <-- container-x86-64-ex-compact-oci

# --> imx6q-phytec-mira-rdk-nand-virt-wic-mc
# jenkins:
# HERE=$(pwd)
# cd /workdir
# ./resy-poky-container.sh imx6q-phytec-mira-rdk-nand-virt-wic-mc mc:imx6q-phytec-mira-rdk-nand-resy-virt:core-image-minimal-virt-docker-ce-mc
# pwd
# cd ${HERE}
MYMAP[imx6q-phytec-mira-rdk-nand-virt-wic-mc]="mc:imx6q-phytec-mira-rdk-nand-resy-virt:core-image-minimal-virt-docker-ce-mc"
# <-- imx6q-phytec-mira-rdk-nand-virt-wic-mc

# --> imx6q-phytec-mira-rdk-nand-virt-wic-mc-master
# jenkins:
# HERE=$(pwd)
# cd /workdir
# ./resy-poky-container.sh imx6q-phytec-mira-rdk-nand-virt-wic-mc-master mc:imx6q-phytec-mira-rdk-nand-resy-virt:core-image-minimal-virt-docker-ce-mc
# pwd
# cd ${HERE}
MYMAP[imx6q-phytec-mira-rdk-nand-virt-wic-mc-master]="mc:imx6q-phytec-mira-rdk-nand-resy-virt:core-image-minimal-virt-docker-ce-mc"
# <-- imx6q-phytec-mira-rdk-nand-virt-wic-mc-master

# --> imx6q-phytec-mira-rdk-nand-virt-docker-master
# jenkins:
# HERE=$(pwd)
# cd /workdir
# ./resy-poky-container.sh imx6q-phytec-mira-rdk-nand-virt-docker-master core-image-minimal-virt-docker
# pwd
# cd ${HERE}
MYMAP[imx6q-phytec-mira-rdk-nand-virt-docker-master]="core-image-minimal-virt-docker"
# <-- imx6q-phytec-mira-rdk-nand-virt-docker-master

# --> imx6q-phytec-mira-rdk-nand-virt-podman-master
# jenkins:
# HERE=$(pwd)
# cd /workdir
# ./resy-poky-container.sh imx6q-phytec-mira-rdk-nand-virt-docker-master core-image-minimal-virt-docker
# pwd
# cd ${HERE}
MYMAP[imx6q-phytec-mira-rdk-nand-virt-podman-master]="core-image-minimal-virt-podman"
# <-- imx6q-phytec-mira-rdk-nand-virt-podman-master


# --> imx6q-phytec-mira-rdk-nand-virt-mender
# jenkins:
# HERE=$(pwd)
# cd /workdir
# ./resy-poky-container.sh imx6q-phytec-mira-rdk-nand-virt-mender core-image-minimal
# ./resy-poky-container.sh imx6q-phytec-mira-rdk-nand-virt-mender core-image-minimal-virt-docker-ce
# pwd
# cd ${HERE}
MYMAP[imx6q-phytec-mira-rdk-nand-virt-mender]="core-image-minimal core-image-minimal-virt-docker-ce"
# <-- imx6q-phytec-mira-rdk-nand-virt-mender

# --> imx6q-phytec-mira-rdk-nand-mender
# jenkins:
# HERE=$(pwd)
# cd /workdir
# ./resy-poky-container.sh imx6q-phytec-mira-rdk-nand-mender core-image-minimal
# pwd
# cd ${HERE}
MYMAP[imx6q-phytec-mira-rdk-nand-mender]="core-image-minimal"
# <-- imx6q-phytec-mira-rdk-nand-mender

# --> beaglebone-yocto
# jenkins:
# HERE=$(pwd)
# cd /workdir
# ./resy-poky-container.sh beaglebone-yocto-master core-image-minimal
# pwd
# cd ${HERE}
MYMAP[beaglebone-yocto-master]="core-image-minimal"
# <-- beaglebone-yocto

# --> beaglebone-yocto-swupdate
# jenkins:
# HERE=$(pwd)
# cd /workdir
# ./resy-poky-container.sh beaglebone-yocto-swupdate-master core-image-minimal
# pwd
# cd ${HERE}
MYMAP[beaglebone-yocto-swupdate-master]="core-image-minimal"
# <-- beaglebone-yocto-swupdate


# --> beagle-bone-black-wic
# jenkins:
# HERE=$(pwd)
# cd /workdir
# ./resy-poky-container.sh beagle-bone-black-wic core-image-minimal
# pwd
# cd ${HERE}
MYMAP[beagle-bone-black-wic]="core-image-minimal"
# <-- beagle-bone-black-wic

# --> beagle-bone-black-wic-master
# jenkins:
# HERE=$(pwd)
# cd /workdir
# ./resy-poky-container.sh beagle-bone-black-wic-master core-image-minimal
# pwd
# cd ${HERE}
MYMAP[beagle-bone-black-wic-master]="core-image-minimal"
# <-- beagle-bone-black-wic-master

# --> conserver-beagle-bone-black-wic-master
# jenkins:
# HERE=$(pwd)
# cd /workdir
# ./resy-poky-container.sh conserver-beagle-bone-black-wic-master core-image-minimal-base-conserver
# pwd
# cd ${HERE}
MYMAP[conserver-beagle-bone-black-wic-master]="core-image-minimal-base-conserver"
# <-- conserver-beagle-bone-black-wic-master

# --> conserver-beagle-bone-black-wic-swupdate-master
# jenkins:
# HERE=$(pwd)
# cd /workdir
# ./resy-poky-container.sh conserver-beagle-bone-black-wic-swupdate-master core-image-minimal-base-conserver
# pwd
# cd ${HERE}
MYMAP[conserver-beagle-bone-black-wic-swupdate-master]="core-image-minimal-base-conserver"
# <-- conserver-beagle-bone-black-wic-swupate-master

# --> am335x-pocketbeagle-wic-master
# jenkins:
# HERE=$(pwd)
# cd /workdir
# ./resy-poky-container.sh am335x-pocketbeagle-wic-master core-image-minimal
# pwd
# cd ${HERE}
MYMAP[am335x-pocketbeagle-wic-master]="core-image-minimal"
# <-- am335x-pocketbeagle-wic-master

# --> omap3-beagle-xm-wic-master
# jenkins:
# HERE=$(pwd)
# cd /workdir
# ./resy-poky-container.sh omap3-beagle-xm-wic-master core-image-minimal
# pwd
# cd ${HERE}
MYMAP[omap3-beagle-xm-wic-master]="core-image-minimal"
# <-- omap3-beagle-xm-wic-master

# --> stm32mp157c-dk2-wic-master
# jenkins:
# HERE=$(pwd)
# cd /workdir
# ./resy-poky-container.sh stm32mp157c-dk2-wic-master core-image-minimal core-image-minimal-base
# pwd
# cd ${HERE}
MYMAP[stm32mp157c-dk2-wic-master]="core-image-minimal core-image-minimal-base"
# <-- stm32mp157c-dk2-wic-master

# --> stm32mp157c-dk2-systemd-wic-master
# jenkins:
# HERE=$(pwd)
# cd /workdir
# ./resy-poky-container.sh stm32mp157c-dk2--wic-master core-image-minimal core-image-minimal-base
# pwd
# cd ${HERE}
MYMAP[stm32mp157c-dk2-systemd-wic-master]="core-image-minimal core-image-minimal-base"
# <-- stm32mp157c-dk2-systemd-wic-master

# --> stm32mp157c-dk2-meta-stm32mp1-wic-master
# jenkins:
# HERE=$(pwd)
# cd /workdir
# ./resy-poky-container.sh stm32mp157c-dk2-meta-stm32mp1-wic-master core-image-minimal
# pwd
# cd ${HERE}
# MYMAP[stm32mp157c-dk2-meta-stm32mp1-wic-master]="core-image-minimal"
# <-- stm32mp157c-dk2-meta-stm32mp1-wic-master

# --> sargas-phycore-stm32mp1-2-systemd-master
# jenkins:
# HERE=$(pwd)
# cd /workdir
# ./resy-poky-container.sh sargas-phycore-stm32mp1-2-systemd-master core-image-minimal
# pwd
# cd ${HERE}
MYMAP[sargas-phycore-stm32mp1-2-systemd-master]="core-image-minimal"
# <-- sargas-phycore-stm32mp1-2-systemd-master

# --> m100pfsevp-polarfire-poky
# jenkis:
# HERE=$(pwd)
# cd /workdir
# ./resy-poky-container.sh m100pfsevp-polarfire-poky core-image-minimal
# pwd
# cd ${HERE}
MYMAP[m100pfsevp-polarfire-poky]="core-image-minimal"
# <-- m100pfsevp-polarfire-poky

# --> m100pfsevp-polarfire-poky-master
# jenkis:
# HERE=$(pwd)
# cd /workdir
# ./resy-poky-container.sh m100pfsevp-polarfire-poky-master core-image-minimal
# pwd
# cd ${HERE}
MYMAP[m100pfsevp-polarfire-poky-master]="core-image-minimal"
# <-- m100pfsevp-polarfire-poky-master


# --> m100pfsevp-polarfire-resy
# jenkis:
# HERE=$(pwd)
# cd /workdir
# ./resy-poky-container.sh m100pfsevp-polarfire-resy core-image-minimal
# pwd
# cd ${HERE}
MYMAP[m100pfsevp-polarfire-resy]="core-image-minimal"
# <-- m100pfsevp-polarfire-resy

# --> m100pfsevp-polarfire-resy-master
# jenkis:
# HERE=$(pwd)
# cd /workdir
# ./resy-poky-container.sh m100pfsevp-polarfire-resy-master core-image-minimal
# pwd
# cd ${HERE}
MYMAP[m100pfsevp-polarfire-resy-master]="core-image-minimal"
# <-- m100pfsevp-polarfire-resy-master


# --> m100pfsevp-polarfire-resy-master-minimal
# jenkis:
# HERE=$(pwd)
# cd /workdir
# ./resy-poky-container.sh m100pfsevp-polarfire-resy-master-minimal core-image-minimal
# pwd
# cd ${HERE}
MYMAP[m100pfsevp-polarfire-resy-master-minimal]="core-image-minimal"
# <-- m100pfsevp-polarfire-resy-master-minimal


# --> de0-nano-soc-kit-wic-master
# jenkins:
# HERE=$(pwd)
# cd /workdir
# ./resy-poky-container.sh de0-nano-soc-kit-wic-master core-image-minimal
# cd ${HERE}
MYMAP[de0-nano-soc-kit-wic-master]="core-image-minimal"
# <-- de0-nano-soc-kit-wic-master

# --> beagle-bone-green-wic
# jenkins:
# HERE=$(pwd)
# cd /workdir
# ./resy-poky-container.sh beagle-bone-green-wic core-image-minimal
# pwd
# cd ${HERE}
MYMAP[beagle-bone-green-wic]="core-image-minimal"
# <-- beagle-bone-green-wic

# --> beagle-bone-green-wic-master
# jenkins:
# HERE=$(pwd)
# cd /workdir
# ./resy-poky-container.sh beagle-bone-green-wic-master core-image-minimal
# pwd
# cd ${HERE}
MYMAP[beagle-bone-green-wic-master]="core-image-minimal"
# <-- beagle-bone-green-wic-master

# --> am335x-regor-rdk-wic-master
# jenkins:
# HERE=$(pwd)
# cd /workdir
# ./resy-poky-container.sh am335x-regor-rdk-wic-master core-image-minimal
# pwd
# cd ${HERE}
MYMAP[am335x-regor-rdk-wic-master]="core-image-minimal"
# <-- am335x-regor-rdk-wic-master

# --> beagle-bone-black-virt-wic
# jenkins:
# HERE=$(pwd)
# cd /workdir
# ./resy-poky-container.sh beagle-bone-black-virt-wic core-image-minimal
# ./resy-poky-container.sh beagle-bone-black-virt-wic core-image-minimal-virt-docker-ce
# pwd
# cd ${HERE}
MYMAP[beagle-bone-black-virt-wic]="core-image-minimal core-image-minimal-virt-docker-ce"
# <-- beagle-bone-black-virt-wic


# --> beagle-bone-black-mender
# jenkins:
# HERE=$(pwd)
# cd /workdir
# ./resy-poky-container.sh beagle-bone-black-mender core-image-minimal
# pwd
# cd ${HERE}
MYMAP[beagle-bone-black-mender]="core-image-minimal"
# <-- beagle-bone-black-mender

# --> am335x-phytec-wega-wic
# jenkins:
# HERE=$(pwd)
# cd /workdir
# ./resy-poky-container.sh am335x-phytec-wega-wic core-image-minimal
# pwd
# cd ${HERE}
MYMAP[am335x-phytec-wega-wic]="core-image-minimal"
# <-- am335x-phytec-wega-wic

# --> am335x-phytec-wega-wic-master
# jenkins:
# HERE=$(pwd)
# cd /workdir
# ./resy-poky-container.sh am335x-phytec-wega-wic-master core-image-minimal
# pwd
# cd ${HERE}
MYMAP[am335x-phytec-wega-wic-master]="core-image-minimal"
# <-- am335x-phytec-wega-wic-master

# --> am335x-phytec-wega-mender
# jenkins:
# HERE=$(pwd)
# cd /workdir
# ./resy-poky-container.sh am335x-phytec-wega-mender core-image-minimal
# pwd
# cd ${HERE}
MYMAP[am335x-phytec-wega-mender]="core-image-minimal"
# <-- am335x-phytec-wega-mender

# --> imx6ul-phytec-segin-wic-master
# jenkins:
# HERE=$(pwd)
# cd /workdir
# ./resy-poky-container.sh imx6ul-phytec-segin-wic-master core-image-minimal core-image-minimal-base
# pwd
# cd ${HERE}
MYMAP[imx6ul-phytec-segin-wic-master]="core-image-minimal core-image-minimal-base"
# <-- imx6ul-phytec-segin-wic-master

# --> imx6ul-phytec-segin-systemd-wic-master
# jenkins:
# HERE=$(pwd)
# cd /workdir
# ./resy-poky-container.sh imx6ul-phytec-segin-systemd-wic-master core-image-minimal core-image-minimal-base
# pwd
# cd ${HERE}
MYMAP[imx6ul-phytec-segin-systemd-wic-master]="core-image-minimal core-image-minimal-base"
# <-- imx6ul-phytec-segin-systemd-wic-master


# --> imx6ul-phytec-segin-virt-telegraf-wic-master
# jenkins:
# HERE=$(pwd)
# cd /workdir
# ./resy-poky-container.sh imx6ul-phytec-segin-virt-telegraf-wic-master core-image-minimal-virt-docker
# pwd
# cd ${HERE}
MYMAP[imx6ul-phytec-segin-virt-telegraf-wic-master]="core-image-minimal-virt-docker"
# <-- imx6ul-phytec-segin-virt-telegraf-wic-master

# --> de0-nano-soc-kit-virt-telegraf-wic-master
# jenkins:
# HERE=$(pwd)
# cd /workdir
# ./resy-poky-container.sh de0-nano-soc-kit-virt-telegraf-wic-master core-image-minimal-virt-docker
# pwd
# cd ${HERE}
MYMAP[de0-nano-soc-kit-virt-telegraf-wic-master]="core-image-minimal-virt-docker"
# <-- de0-nano-soc-kit-virt-telegraf-wic-master

# --> imx6q-phytec-mira-rdk-nand-virt-telegraf-wic-master
# jenkins:
# HERE=$(pwd)
# cd /workdir
# ./resy-poky-container.sh imx6q-phytec-mira-rdk-nand-virt-telegraf-wic-master core-image-minimal-virt-docker
# pwd
# cd ${HERE}
MYMAP[imx6q-phytec-mira-rdk-nand-virt-telegraf-wic-master]="core-image-minimal-virt-docker"
# <-- imx6q-phytec-mira-rdk-nand-virt-telegraf-wic-master

# --> imx6q-phytec-mira-rdk-nand-virt-fmu-wic-master
# jenkins:
# HERE=$(pwd)
# cd /workdir
# ./resy-poky-container.sh imx6q-phytec-mira-rdk-nand-virt-fmu-wic-master core-image-minimal-virt-docker
# pwd
# cd ${HERE}
# MYMAP[imx6q-phytec-mira-rdk-nand-virt-fmu-wic-master]="core-image-minimal-virt-docker"
# <-- imx6q-phytec-mira-rdk-nand-virt-fmu-wic-master

# --> imx6sx-udoo-neo-full-wic-master
# jenkins:
# HERE=$(pwd)
# cd /workdir
# ./resy-poky-container.sh imx6sx-udoo-neo-full-wic-master core-image-minimal
# pwd
# cd ${HERE}
MYMAP[imx6sx-udoo-neo-full-wic-master]="core-image-minimal"
# <-- imx6sx-udoo-neo-full-wic-master

# --> karo-imx6ul-txul
# jenkins:
# HERE=$(pwd)
# cd /workdir
# ./resy-poky-container.sh karo-imx6ul-txul core-image-minimal
# ./resy-poky-container.sh karo-imx6ul-txul core-image-minimal-bfe
# pwd
# cd ${HERE}
MYMAP[karo-imx6ul-txul]="core-image-minimal core-image-minimal-bfe"
# <-- karo-imx6ul-txul

# --> raspberrypi4-64-master
# jenkins:
# HERE=$(pwd)
# cd /workdir
# ./resy-poky-container.sh raspberrypi4-64-master core-image-minimal
# pwd
# cd ${HERE}
MYMAP[raspberrypi4-64-master]="core-image-minimal"
# <-- raspberrypi4-64-master

# --> raspberrypi4-64-updater-master
# jenkins:
# HERE=$(pwd)
# cd /workdir
# ./resy-poky-container.sh raspberrypi4-64-updater-master core-image-minimal
# pwd
# cd ${HERE}
#MYMAP[raspberrypi4-64-updater-master]="core-image-minimal"
# <-- raspberrypi4-64-updater-master

# --> raspberrypi4-64-virt-docker-master
# jenkins:
# HERE=$(pwd)
# cd /workdir
# ./resy-poky-container.sh raspberrypi4-64-virt-docker-master core-image-minimal-virt-docker
# pwd
# cd ${HERE}
MYMAP[raspberrypi4-64-virt-docker-master]="core-image-minimal-virt-docker"
# <-- raspberrypi4-64-virt-docker-master

# --> raspberrypi4-64-virt-k3s-master
# jenkins:
# HERE=$(pwd)
# cd /workdir
# ./resy-poky-container.sh raspberrypi4-64-virt-k3s-master core-image-minimal-virt-k3s
# pwd
# cd ${HERE}
MYMAP[raspberrypi4-64-virt-k3s-master]="core-image-minimal-virt-k3s"
# <-- raspberrypi4-64-virt-k3s-master

# --> raspberrypi4-64-virt-k3s-master-bosc
# jenkins:
# HERE=$(pwd)
# cd /workdir
# ./resy-poky-container.sh raspberrypi4-64-virt-k3s-master-bosc core-image-minimal-virt-k3s
# pwd
# cd ${HERE}
MYMAP[raspberrypi4-64-virt-k3s-master-bosc]="core-image-minimal-virt-k3s"
# <-- raspberrypi4-64-virt-k3s-master-bosc

# --> raspberrypi3-64-master
# jenkins:
# HERE=$(pwd)
# cd /workdir
# ./resy-poky-container.sh raspberrypi3-64-master core-image-base
# pwd
# cd ${HERE}
MYMAP[raspberrypi3-64-master]="core-image-base"
# <-- raspberrypi3-64-master

# --> raspberrypi-4-64-raspi-kernel-wic
# jenkins:
# HERE=$(pwd)
# cd /workdir
# ./resy-poky-container.sh raspberrypi-4-64-raspi-kernel-wic core-image-base
# pwd
# cd ${HERE}
MYMAP[raspberrypi-4-64-raspi-kernel-wic]="core-image-base"
# <-- raspberrypi-4-64-raspi-kernel-wic

# --> raspberrypi-4-64-ml-kernel-wic
# jenkins:
# HERE=$(pwd)
# cd /workdir
# ./resy-poky-container.sh raspberrypi-4-64-ml-kernel-wic core-image-base
# pwd
# cd ${HERE}
MYMAP[raspberrypi-4-64-ml-kernel-wic]="core-image-base"
# <-- raspberrypi-4-64-ml-kernel-wic

# --> raspberrypi-4-64-ml-kernel-wic-virt-tftp-nfs
# jenkins:
# HERE=$(pwd)
# cd /workdir
# ./resy-poky-container.sh raspberrypi-4-64-ml-kernel-wic-virt-tftp-nfs core-image-base
# ./resy-poky-container.sh raspberrypi-4-64-ml-kernel-wic-virt-tftp-nfs core-image-minimal-virt-docker-ce
# pwd
# cd ${HERE}
MYMAP[raspberrypi-4-64-ml-kernel-wic-virt-tftp-nfs]="core-image-base core-image-minimal-virt-docker-ce"
# <-- raspberrypi-4-64-ml-kernel-wic-virt-tftp-nfs

# --> raspberrypi-4-64-ml-kernel-wic-virt-all-sdcard
# jenkins:
# HERE=$(pwd)
# cd /workdir
# ./resy-poky-container.sh raspberrypi-4-64-ml-kernel-wic-virt-all-sdcard core-image-base
# ./resy-poky-container.sh raspberrypi-4-64-ml-kernel-wic-virt-all-sdcard core-image-minimal-virt-docker-ce
# pwd
# cd ${HERE}
MYMAP[raspberrypi-4-64-ml-kernel-wic-virt-all-sdcard]="core-image-base core-image-minimal-virt-docker-ce"
# <-- raspberrypi-4-64-ml-kernel-wic-virt-all-sdcard

# --> zedboard-zynq7-master (meta-xilinx)
# jenkins:
# HERE=$(pwd)
# cd /workdir
# ./resy-poky-container.sh zedboard-zynq7-master core-image-minimal
# pwd
# cd ${HERE}
MYMAP[zedboard-zynq7-master]="core-image-minimal"
# <-- zedboard-zynq7-master

# --> imx8mm-lpddr4-evk-master
# jenkins:
# HERE=$(pwd)
# cd /workdir
# ./resy-poky-container.sh imx8mm-lpddr4-evk-master core-image-minimal-base
# pwd
# cd ${HERE}
MYMAP[imx8mm-lpddr4-evk-master]="core-image-minimal-base"
# <-- imx8mm-lpddr4-evk-master

# --> imx8mm-lpddr4-evk-ml-master
# jenkins:
# HERE=$(pwd)
# cd /workdir
# ./resy-poky-container.sh imx8mm-lpddr4-evk-ml-master core-image-minimal-base
# pwd
# cd ${HERE}
MYMAP[imx8mm-lpddr4-evk-ml-master]="core-image-minimal-base"
# <-- imx8mm-lpddr4-evk-ml-master

# --> imx8mm-lpddr4-evk-ml-virt-docker-master
# jenkins:
# HERE=$(pwd)
# cd /workdir
# ./resy-poky-container.sh imx8mm-lpddr4-evk-ml-virt-docker-master core-image-minimal-virt-docker
# pwd
# cd ${HERE}
MYMAP[imx8mm-lpddr4-evk-ml-virt-docker-master]="core-image-minimal-virt-docker"
# <-- imx8mm-lpddr4-evk-ml-virt-docker-master

# --> container-imx8mm-lpddr4-evk-ml-tensorflow-master
# jenkins:
# HERE=$(pwd)
# cd /workdir
# ./resy-poky-container.sh container-imx8mm-lpddr4-evk-ml-tensorflow-master tensorflow-native
# ./resy-poky-container.sh container-imx8mm-lpddr4-evk-ml-tensorflow-master tensorflow
# ./resy-poky-container.sh container-imx8mm-lpddr4-evk-ml-tensorflow-master app-container-image-tensorflow
MYMAP[container-imx8mm-lpddr4-evk-ml-tensorflow-master]="tensorflow-native tensorflow app-container-image-tensorflow"
# <-- container-imx8mm-lpddr4-evk-ml-tensorflow-master

# --> phyboard-polis-imx8mm-wic
# jenkins:
# HERE=$(pwd)
# cd /workdir
# ./resy-poky-container.sh phyboard-polis-imx8mm-wic core-image-base
# pwd
# cd ${HERE}
MYMAP[phyboard-polis-imx8mm-wic]="core-image-base"
# <-- phyboard-polis-imx8mm-wic

# --> phyboard-polis-imx8mm-wic-virt
# jenkins:
# HERE=$(pwd)
# cd /workdir
# ./resy-poky-container.sh phyboard-polis-imx8mm-wic core-image-base
# pwd
# cd ${HERE}
MYMAP[phyboard-polis-imx8mm-wic-virt]="core-image-base core-image-minimal-virt-docker-ce"
# <-- phyboard-polis-imx8mm-wic-virt


# --> karo-imx6ul-txul-uboot-wic
# @@@ This is currently broken and hopefully soon deprecated
# jenkins:
# HERE=$(pwd)
# cd /workdir
# ./resy-poky-container.sh karo-imx6ul-txul-uboot-wic core-image-minimal
# pwd
# cd ${HERE}
# MYMAP[karo-imx6ul-txul-uboot-wic]="core-image-minimal"
# <-- karo-imx6ul-txul-uboot-wic

available_targets () {
    echo "available targets:"
    for K in "${!MYMAP[@]}"; do echo $K; done | sort -n -k3
}

usage () {
    echo "usage:"
    echo "source /workdir/resy-cooker.sh MACHINE or MACHINE-sw-variant"
    echo "source /workdir/resy-cooker.sh container-x86-64"
    available_targets
}

# --> usage
if [ "$#" -lt "1" ]; then
     echo "--> USAGE 1 <--"
     usage 
     #exit 0
#fi
# <-- usage


elif [ ! ${MYMAP[${1}]+_} ]; then
  echo "--> $1 not found <--" 
  echo "--> USAGE 2 <--"
  usage
  #exit 0
fi

if [ "$#" -gt "0" ]; then
# here we have a MACHINE or MACHINE-sw-variant defined

machine="$1"
echo "MACHINE or MACHINE-sw-variant: $machine"

if [ ! ${MYMAP[${1}]+_} ]; then
  echo "--> $1 not found <--" 
  echo "--> USAGE 3 <--"
  usage
  #exit 0
fi


#set ${MYMAP["${1}"]}

#read r

  # check if hostname specific site.conf exists and pick it up
  if [ -f ../sources/meta-resy/template-common/site.conf.sample.${HOSTNAME} ]; then 
     SITE_CONF="../../sources/meta-resy/template-common/site.conf.sample.${HOSTNAME}"
  else
     SITE_CONF="../../sources/meta-resy/template-common/site.conf.sample"
  fi
 
  echo "initial SITE_CONF=${SITE_CONF}"

  # x86-64 container e.g. for development and testing

  if [ "$machine" == "container-x86-64" ]; then
     export TEMPLATECONF="../meta-resy/template-${machine}"
     echo "TEMPLATECONF: ${TEMPLATECONF}"
     echo "source ../sources/poky/oe-init-build-env ${machine}"
     source ../sources/poky/oe-init-build-env ${machine}
     # only copy site.conf if it's not already there
     if [ ! -f conf/site.conf ]; then
        cp ${SITE_CONF} conf/site.conf
        tree conf
     fi
  fi

  # x86-64 container master e.g. for development and testing

  if [ "$machine" == "container-x86-64-master" ]; then
     export TEMPLATECONF="../meta-resy-master/template-${machine}"
     echo "TEMPLATECONF: ${TEMPLATECONF}"
     echo "source ../sources/poky-master/oe-init-build-env ${machine}"
     source ../sources/poky-master/oe-init-build-env ${machine}
     # only copy site.conf if it's not already there
     if [ ! -f conf/site.conf ]; then
        #cp ${SITE_CONF} conf/site.conf
        cp ../../sources/meta-resy-master/template-${machine}/site.conf conf/site.conf
        tree conf
     fi
  fi

  # x86-64 java container e.g. for Java development and testing

  if [ "$machine" == "container-x86-64-java" ]; then
     # I moved to ubuntu 18 and gcc-9 by default - let's see
     # --> currently only host gcc-9 seems to work here
     # check if hostname specific site.conf exists and pick it up
     #if [ -f ../sources/meta-resy/template-common/site.conf.sample.${HOSTNAME}_gcc-9 ]; then
     #   SITE_CONF="../../sources/meta-resy/template-common/site.conf.sample.${HOSTNAME}_gcc-9 "
     #else
     #   SITE_CONF="../../sources/meta-resy/template-common/site.conf.sample_gcc-9"
     #fi
     #
     #echo "SITE_CONF=${SITE_CONF}"
     # <-- currently only host gcc-9 seems to work here

     export TEMPLATECONF="../meta-resy/template-${machine}"
     echo "TEMPLATECONF: ${TEMPLATECONF}"
     echo "source ../sources/poky/oe-init-build-env ${machine}"
     source ../sources/poky/oe-init-build-env ${machine}
     # only copy site.conf if it's not already there
     if [ ! -f conf/site.conf ]; then
        cp ${SITE_CONF} conf/site.conf
        tree conf
     fi
  fi

  # x86-64 java master container e.g. for Java development and testing

  if [ "$machine" == "container-x86-64-java-master" ]; then
     # I moved to ubuntu 18 and gcc-9 by default - let's see
     # --> currently only host gcc-9 seems to work here
     # check if hostname specific site.conf exists and pick it up
     #if [ -f ../sources/meta-resy/template-common/site.conf.sample.${HOSTNAME}_gcc-9 ]; then
     #   SITE_CONF="../../sources/meta-resy/template-common/site.conf.sample.${HOSTNAME}_gcc-9 "
     #else
     #   SITE_CONF="../../sources/meta-resy/template-common/site.conf.sample_gcc-9"
     #fi
     #
     #echo "SITE_CONF=${SITE_CONF}"
     # <-- currently only host gcc-9 seems to work here

     export TEMPLATECONF="../meta-resy-master/template-${machine}"
     echo "TEMPLATECONF: ${TEMPLATECONF}"
     echo "source ../sources/poky-master/oe-init-build-env ${machine}"
     source ../sources/poky-master/oe-init-build-env ${machine}
     # only copy site.conf if it's not already there
     if [ ! -f conf/site.conf ]; then
        #cp ${SITE_CONF} conf/site.conf
        # custom site.conf
        cp ../../sources/meta-resy-master/template-common/site.conf.sample conf/site.conf
        tree conf
     fi
  fi

 # qemux86-64 virt master container e.g. for container testing

  if [ "$machine" == "qemux86-64-virt-master" ]; then
     # I moved to ubuntu 18 and gcc-9 by default - let's see
     # --> currently only host gcc-9 seems to work here
     # check if hostname specific site.conf exists and pick it up
     #if [ -f ../sources/meta-resy/template-common/site.conf.sample.${HOSTNAME}_gcc-9 ]; then
     #   SITE_CONF="../../sources/meta-resy/template-common/site.conf.sample.${HOSTNAME}_gcc-9 "
     #else
     #   SITE_CONF="../../sources/meta-resy/template-common/site.conf.sample_gcc-9"
     #fi
     #
     #echo "SITE_CONF=${SITE_CONF}"
     # <-- currently only host gcc-9 seems to work here

     export TEMPLATECONF="../meta-resy-master/template-${machine}"
     echo "TEMPLATECONF: ${TEMPLATECONF}"
     pwd
     echo "source ../sources/poky-master/oe-init-build-env ${machine}"
     source ../sources/poky-master/oe-init-build-env ${machine}
     # only copy site.conf if it's not already there
     if [ ! -f conf/site.conf ]; then
        #cp ${SITE_CONF} conf/site.conf
        # custom site.conf
        cp ../../sources/meta-resy-master/template-${machine}/site.conf conf/site.conf
        tree conf
     fi
  fi

  if [ "$machine" == "intel-core2-32-master" ]; then
     # I moved to ubuntu 18 and gcc-9 by default - let's see
     # --> currently only host gcc-9 seems to work here
     # check if hostname specific site.conf exists and pick it up
     #if [ -f ../sources/meta-resy/template-common/site.conf.sample.${HOSTNAME}_gcc-9 ]; then
     #   SITE_CONF="../../sources/meta-resy/template-common/site.conf.sample.${HOSTNAME}_gcc-9 "
     #else
     #   SITE_CONF="../../sources/meta-resy/template-common/site.conf.sample_gcc-9"
     #fi
     #
     #echo "SITE_CONF=${SITE_CONF}"
     # <-- currently only host gcc-9 seems to work here

     export TEMPLATECONF="../meta-resy-master/template-${machine}"
     echo "TEMPLATECONF: ${TEMPLATECONF}"
     pwd
     echo "source ../sources/poky-master/oe-init-build-env ${machine}"
     source ../sources/poky-master/oe-init-build-env ${machine}
     # only copy site.conf if it's not already there
     if [ ! -f conf/site.conf ]; then
        #cp ${SITE_CONF} conf/site.conf
        # custom site.conf
        cp ../../sources/meta-resy-master/template-${machine}/site.conf conf/site.conf
        tree conf
     fi
  fi


  # x86-64 tensorflow container e.g. for tensorflow development and testing

  if [ "$machine" == "container-x86-64-tensorflow" ]; then
     export TEMPLATECONF="../meta-resy/template-${machine}"
     echo "TEMPLATECONF: ${TEMPLATECONF}"
     echo "source ../sources/poky/oe-init-build-env ${machine}"
     source ../sources/poky/oe-init-build-env ${machine}
     # only copy site.conf if it's not already there
     if [ ! -f conf/site.conf ]; then
        cp ${SITE_CONF} conf/site.conf
        tree conf
     fi
  fi


 # x86-64 tensorflow master container e.g. for tensorflow development and testing

  if [ "$machine" == "container-x86-64-tensorflow-master" ]; then
     export TEMPLATECONF="../meta-resy-master/template-${machine}"
     echo "TEMPLATECONF: ${TEMPLATECONF}"
     echo "source ../sources/poky-master/oe-init-build-env ${machine}"
     source ../sources/poky-master/oe-init-build-env ${machine}
     # only copy site.conf if it's not already there
     if [ ! -f conf/site.conf ]; then
        #cp ${SITE_CONF} conf/site.conf
        cp ../../sources/meta-resy-master/template-${machine}/site.conf conf/site.conf
        tree conf
     fi
  fi


  # x86-64 golang container e.g. for golang development and testing

  if [ "$machine" == "container-x86-64-golang" ]; then
     export TEMPLATECONF="../meta-resy/template-${machine}"
     echo "TEMPLATECONF: ${TEMPLATECONF}"
     echo "source ../sources/poky/oe-init-build-env ${machine}"
     source ../sources/poky/oe-init-build-env ${machine}
     # only copy site.conf if it's not already there
     if [ ! -f conf/site.conf ]; then
        cp ${SITE_CONF} conf/site.conf
        tree conf
     fi
  fi

  # x86-64 golang container master e.g. for golang development and testing

  if [ "$machine" == "container-x86-64-golang-master" ]; then
     export TEMPLATECONF="../meta-resy-master/template-${machine}"
     echo "TEMPLATECONF: ${TEMPLATECONF}"
     echo "source ../sources/poky-master/oe-init-build-env ${machine}"
     source ../sources/poky-master/oe-init-build-env ${machine}
     # only copy site.conf if it's not already there
     if [ ! -f conf/site.conf ]; then
        #cp ${SITE_CONF} conf/site.conf
	cp ../../sources/meta-resy-master/template-${machine}/site.conf.sample conf/site.conf
        tree conf
     fi
  fi

  # x86-64 tig container e.g. for tig development and testing

  if [ "$machine" == "container-x86-64-tig" ]; then
     export TEMPLATECONF="../meta-resy/template-${machine}"
     echo "TEMPLATECONF: ${TEMPLATECONF}"
     echo "source ../sources/poky/oe-init-build-env ${machine}"
     source ../sources/poky/oe-init-build-env ${machine}
     # only copy site.conf if it's not already there
     if [ ! -f conf/site.conf ]; then
        cp ${SITE_CONF} conf/site.conf
        tree conf
     fi
  fi

  # x86-64 tig master container e.g. for tig development and testing

  if [ "$machine" == "container-x86-64-tig-master" ]; then
     export TEMPLATECONF="../meta-resy-master/template-${machine}"
     echo "TEMPLATECONF: ${TEMPLATECONF}"
     echo "source ../sources/poky-master/oe-init-build-env ${machine}"
     source ../sources/poky-master/oe-init-build-env ${machine}
     # only copy site.conf if it's not already there
     if [ ! -f conf/site.conf ]; then
        #cp ${SITE_CONF} conf/site.conf
        # custom site.conf
        cp ../../sources/meta-resy-master/template-common/site.conf.sample conf/site.conf
        tree conf
     fi
  fi

  # container-x86-64-ex-compact-docker-only
  # container examples, which should work only with poky
  # I pulled in stuff from various of my layers

  if [ "$machine" == "container-x86-64-ex-compact-docker-only" ]; then
     export TEMPLATECONF="../meta-container-ex-compact-docker-only/template-${machine}"
     echo "TEMPLATECONF: ${TEMPLATECONF}"
     echo "source ../sources/poky-master/oe-init-build-env ${machine}"
     source ../sources/poky-master/oe-init-build-env ${machine}
     # only copy site.conf if it's not already there
     if [ ! -f conf/site.conf ]; then
        cp ../../sources/meta-container-ex-compact-docker-only/template-${machine}/site.conf conf/site.conf
        tree conf
     fi
  fi
 
  # container-x86-64-ex-compact-oci
  # container examples, which should work only with poky
  # I pulled in stuff from various of my layers

  if [ "$machine" == "container-x86-64-ex-compact-oci" ]; then
     export TEMPLATECONF="../meta-container-ex-compact-oci/template-${machine}"
     echo "TEMPLATECONF: ${TEMPLATECONF}"
     echo "source ../sources/poky-master/oe-init-build-env ${machine}"
     source ../sources/poky-master/oe-init-build-env ${machine}
     # only copy site.conf if it's not already there
     if [ ! -f conf/site.conf ]; then
        cp ../../sources/meta-container-ex-compact-oci/template-${machine}/site.conf conf/site.conf
        tree conf
     fi
  fi

  # arm-v7 container e.g. to run on target/docker

  if [ "$machine" == "container-arm-v7" ]; then
     export TEMPLATECONF="../meta-multi-v7-ml-bsp/template-${machine}"
     echo "TEMPLATECONF: ${TEMPLATECONF}"
     echo "source ../sources/poky/oe-init-build-env ${machine}"
     source ../sources/poky/oe-init-build-env ${machine}
     # only copy site.conf if it's not already there
     if [ ! -f conf/site.conf ]; then
        cp ${SITE_CONF} conf/site.conf
        tree conf
     fi 
  fi


  # arm-v7 container e.g. to run on target/docker

  if [ "$machine" == "container-arm-v7-master" ]; then
     export TEMPLATECONF="../meta-multi-v7-ml-bsp-master/template-${machine}"
     echo "TEMPLATECONF: ${TEMPLATECONF}"
     echo "source ../sources/poky-master/oe-init-build-env ${machine}"
     source ../sources/poky-master/oe-init-build-env ${machine}
     # only copy site.conf if it's not already there
     if [ ! -f conf/site.conf ]; then
        #cp ${SITE_CONF} conf/site.conf
        #tree conf
        cp ../../sources/meta-multi-v7-ml-bsp-master/template-container-arm-v7-master/site.conf conf/site.conf
        tree conf
     fi
  fi

  # arm-v7 container e.g. for tig development and testing

  if [ "$machine" == "container-arm-v7-tig" ]; then
     export TEMPLATECONF="../meta-multi-v7-ml-bsp/template-${machine}"
     echo "TEMPLATECONF: ${TEMPLATECONF}"
     echo "source ../sources/poky/oe-init-build-env ${machine}"
     source ../sources/poky/oe-init-build-env ${machine}
     # only copy site.conf if it's not already there
     if [ ! -f conf/site.conf ]; then
        cp ${SITE_CONF} conf/site.conf
        tree conf
     fi
  fi


  # arm-v7 tensorflow master container e.g. for tensorflow development and testing

  if [ "$machine" == "container-arm-v7-tensorflow-master" ]; then
     export TEMPLATECONF="../meta-multi-v7-ml-bsp-master/template-${machine}"
     echo "TEMPLATECONF: ${TEMPLATECONF}"
     echo "source ../sources/poky-master/oe-init-build-env ${machine}"
     source ../sources/poky-master/oe-init-build-env ${machine}
     # only copy site.conf if it's not already there
     if [ ! -f conf/site.conf ]; then
        #cp ${SITE_CONF} conf/site.conf
        pwd
        cp ../../sources/meta-multi-v7-ml-bsp-master/template-${machine}/site.conf conf/site.conf
        tree conf
     fi
  fi

  # arm-v7 container e.g. for phoronix development and testing

  if [ "$machine" == "container-arm-v7-phoronix" ]; then
     export TEMPLATECONF="../meta-multi-v7-ml-bsp/template-${machine}"
     echo "TEMPLATECONF: ${TEMPLATECONF}"
     echo "source ../sources/poky/oe-init-build-env ${machine}"
     source ../sources/poky/oe-init-build-env ${machine}
     # only copy site.conf if it's not already there
     if [ ! -f conf/site.conf ]; then
        cp ${SITE_CONF} conf/site.conf
        tree conf
     fi
  fi

  # raspberrypi-4-64-ml container e.g. for phoronix development and testing

  if [ "$machine" == "container-raspberrypi-4-64-ml-phoronix" ]; then
     export TEMPLATECONF="../meta-raspberrypi-ml-bsp/template-${machine}"
     echo "TEMPLATECONF: ${TEMPLATECONF}"
     echo "source ../sources/poky/oe-init-build-env ${machine}"
     source ../sources/poky/oe-init-build-env ${machine}
     # only copy site.conf if it's not already there
     if [ ! -f conf/site.conf ]; then
        #cp ${SITE_CONF} conf/site.conf
        # custom site.conf
        cp ../../sources/meta-raspberrypi-ml-bsp/template-${machine}/site.conf conf/site.conf
        tree conf
     fi
  fi
 
  # rootfs + kernel + ftd(s) - no u-boot, no sd card image
  # used for development
  # DISTRO = resy
  # default kernel config: std

  if [ "$machine" == "multi-v7-ml" ]; then
     export TEMPLATECONF="../meta-multi-v7-ml-bsp/template-${machine}"
     echo "TEMPLATECONF: ${TEMPLATECONF}"
     echo "source ../sources/poky/oe-init-build-env ${machine}"
     source ../sources/poky/oe-init-build-env ${machine}
     # only copy site.conf if it's not already there
     if [ ! -f conf/site.conf ]; then
        cp ${SITE_CONF} conf/site.conf
        tree conf
     fi
  fi

  # rootfs + kernel + ftd(s) - no u-boot, no sd card image
  # used for development
  # DISTRO = resy
  # default kernel config: std

  if [ "$machine" == "multi-v7-ml-master" ]; then
     export TEMPLATECONF="../meta-multi-v7-ml-bsp-master/conf/templates/template-${machine}"
     echo "TEMPLATECONF: ${TEMPLATECONF}"
     echo "source ../sources/poky-master/oe-init-build-env ${machine}"
     source ../sources/poky-master/oe-init-build-env ${machine}
     # only copy site.conf if it's not already there
     if [ ! -f conf/site.conf ]; then
        #cp ${SITE_CONF} conf/site.conf
        # custom site.conf
        cp ../../sources/meta-multi-v7-ml-bsp-master/conf/templates/template-${machine}/site.conf conf/site.conf
        tree conf
     fi
  fi

  # rootfs + kernel + ftd(s) - no u-boot, no sd card image
  # used for development
  # DISTRO = resy
  # default kernel config: std
  # gdbserver use case

  if [ "$machine" == "multi-v7-ml-gdbserver-master" ]; then
     export TEMPLATECONF="../meta-multi-v7-ml-bsp-master/template-${machine}"
     echo "TEMPLATECONF: ${TEMPLATECONF}"
     echo "source ../sources/poky-master/oe-init-build-env ${machine}"
     source ../sources/poky-master/oe-init-build-env ${machine}
     # only copy site.conf if it's not already there
     if [ ! -f conf/site.conf ]; then
        #cp ${SITE_CONF} conf/site.conf
        # custom site.conf
        cp ../../sources/meta-multi-v7-ml-bsp-master/template-${machine}/site.conf conf/site.conf
        tree conf
     fi
  fi

  # rootfs + kernel + ftd(s) - no u-boot, no sd card image
  # used for development
  # DISTRO = resy
  # default kernel config: std
  # debuginfod use case

  if [ "$machine" == "multi-v7-ml-debuginfod-master" ]; then
     export TEMPLATECONF="../meta-multi-v7-ml-bsp-master/template-${machine}"
     echo "TEMPLATECONF: ${TEMPLATECONF}"
     echo "source ../sources/poky-master/oe-init-build-env ${machine}"
     source ../sources/poky-master/oe-init-build-env ${machine}
     # only copy site.conf if it's not already there
     if [ ! -f conf/site.conf ]; then
        #cp ${SITE_CONF} conf/site.conf
        # custom site.conf
        cp ../../sources/meta-multi-v7-ml-bsp-master/template-${machine}/site.conf conf/site.conf
        tree conf
     fi
  fi

  # rootfs + kernel + ftd(s) - no u-boot, no sd card image
  # used for development
  # DISTRO = resy-virt
  # default kernel config: virt
  # contains docker, docker-compose

  if [ "$machine" == "multi-v7-ml-virt-docker-master" ]; then
     export TEMPLATECONF="../meta-multi-v7-ml-bsp-master/template-${machine}"
     echo "TEMPLATECONF: ${TEMPLATECONF}"
     echo "source ../sources/poky-master/oe-init-build-env ${machine}"
     source ../sources/poky-master/oe-init-build-env ${machine}
     # only copy site.conf if it's not already there
     if [ ! -f conf/site.conf ]; then
        #cp ${SITE_CONF} conf/site.conf
        # custom site.conf
        cp ../../sources/meta-multi-v7-ml-bsp-master/template-${machine}/site.conf conf/site.conf
        tree conf
     fi
  fi

  # rootfs + kernel + ftd(s) - no u-boot, no sd card image
  # used for development
  # DISTRO = resy-virt
  # default kernel config: virt
  # contains podman, podman-compose

  if [ "$machine" == "multi-v7-ml-virt-podman-master" ]; then
     export TEMPLATECONF="../meta-multi-v7-ml-bsp-master/template-${machine}"
     echo "TEMPLATECONF: ${TEMPLATECONF}"
     echo "source ../sources/poky-master/oe-init-build-env ${machine}"
     source ../sources/poky-master/oe-init-build-env ${machine}
     # only copy site.conf if it's not already there
     if [ ! -f conf/site.conf ]; then
        #cp ${SITE_CONF} conf/site.conf
        # custom site.conf
        cp ../../sources/meta-multi-v7-ml-bsp-master/template-${machine}/site.conf conf/site.conf
        tree conf
     fi
  fi


  # rootfs + kernel + ftd(s) - no u-boot, no sd card image
  # used for development, bpf
  # DISTRO = resy
  # default kernel config: std

  if [ "$machine" == "multi-v7-ml-bpf-master" ]; then
     export TEMPLATECONF="../meta-multi-v7-ml-bsp-master/template-${machine}"
     echo "TEMPLATECONF: ${TEMPLATECONF}"
     echo "source ../sources/poky-master/oe-init-build-env ${machine}"
     source ../sources/poky-master/oe-init-build-env ${machine}
     # only copy site.conf if it's not already there
     if [ ! -f conf/site.conf ]; then
        #cp ${SITE_CONF} conf/site.conf
        # custom site.conf
        cp ../../sources/meta-multi-v7-ml-bsp-master/template-${machine}/site.conf conf/site.conf
        tree conf
     fi
  fi

  # rootfs + kernel + ftd(s) - no u-boot, no sd card image
  # used for development
  # DISTRO = resy
  # default kernel config: std

  if [ "$machine" == "multi-v7-ml-qt5" ]; then
     export TEMPLATECONF="../meta-multi-v7-ml-bsp/template-${machine}"
     echo "TEMPLATECONF: ${TEMPLATECONF}"
     echo "source ../sources/poky/oe-init-build-env ${machine}"
     source ../sources/poky/oe-init-build-env ${machine}
     # only copy site.conf if it's not already there
     if [ ! -f conf/site.conf ]; then
        cp ${SITE_CONF} conf/site.conf
        tree conf
     fi
  fi

  # rootfs + kernel + ftd(s) - no u-boot, no sd card image
  # used for development
  # DISTRO = resy
  # default kernel config: xenomai

  if [ "$machine" == "multi-v7-ml-xenomai" ]; then
     export TEMPLATECONF="../meta-xenomai/template-${machine}"
     echo "TEMPLATECONF: ${TEMPLATECONF}"
     echo "source ../sources/poky/oe-init-build-env ${machine}"
     source ../sources/poky/oe-init-build-env ${machine}
     # only copy site.conf if it's not already there
     if [ ! -f conf/site.conf ]; then
        cp ${SITE_CONF} conf/site.conf
        tree conf
     fi
  fi

  # rootfs + kernel + ftd(s) - no u-boot, no sd card image
  # used for development
  # DISTRO = resy
  # default kernel config: prt

  if [ "$machine" == "multi-v7-ml-prt" ]; then
     export TEMPLATECONF="../meta-prt/template-${machine}"
     echo "TEMPLATECONF: ${TEMPLATECONF}"
     echo "source ../sources/poky/oe-init-build-env ${machine}"
     source ../sources/poky/oe-init-build-env ${machine}
     # only copy site.conf if it's not already there
     if [ ! -f conf/site.conf ]; then
        cp ${SITE_CONF} conf/site.conf
        tree conf
     fi
  fi


  # rootfs + kernel + ftd(s) - no u-boot, no sd card image
  # used for development
  # DISTRO = resy
  # default kernel config: debug

  if [ "$machine" == "multi-v7-ml-debug" ]; then
     export TEMPLATECONF="../meta-multi-v7-ml-bsp/template-${machine}"
     echo "TEMPLATECONF: ${TEMPLATECONF}"
     echo "source ../sources/poky/oe-init-build-env ${machine}"
     source ../sources/poky/oe-init-build-env ${machine}
     # only copy site.conf if it's not already there
     if [ ! -f conf/site.conf ]; then
        cp ${SITE_CONF} conf/site.conf
        tree conf
     fi
  fi

  # rootfs + kernel + ftd(s) - no u-boot, no sd card image
  # used for development
  # DISTRO = resy
  # default kernel config: debug
  # poky -> poky-training

  if [ "$machine" == "multi-v7-ml-debug-training" ]; then
     export TEMPLATECONF="../meta-multi-v7-ml-bsp/template-${machine}"
     echo "TEMPLATECONF: ${TEMPLATECONF}"
     echo "source ../sources/poky-training/oe-init-build-env ${machine}"
     source ../sources/poky-training/oe-init-build-env ${machine}
     # only copy site.conf if it's not already there
     if [ ! -f conf/site.conf ]; then
        cp ${SITE_CONF} conf/site.conf
        tree conf
     fi
  fi

  # rootfs + kernel + ftd(s) - no u-boot, no sd card image
  # used for development
  # DISTRO = resy
  # default kernel config: debug
  # poky -> poky-master

  if [ "$machine" == "multi-v7-ml-debug-training-master" ]; then
     export TEMPLATECONF="../meta-multi-v7-ml-bsp-master/conf/templates/template-${machine}"
     echo "TEMPLATECONF: ${TEMPLATECONF}"
     echo "source ../sources/poky-training-master/oe-init-build-env ${machine}"
     source ../sources/poky-training-master/oe-init-build-env ${machine}
     # only copy site.conf if it's not already there
     if [ ! -f conf/site.conf ]; then
        #cp ${SITE_CONF} conf/site.conf
        # custom site.conf
        cp ../../sources/meta-multi-v7-ml-bsp-master/conf/templates/template-${machine}/site.conf conf/site.conf
        tree conf
     fi
  fi

  # rootfs + kernel + ftd(s) - no u-boot, no sd card image
  # used for development
  # DISTRO = resy
  # default kernel config: debug
  # poky -> poky-training

  if [ "$machine" == "multi-v7-ml-debug-training-libs" ]; then
     # we use the same template as for standard training
     export TEMPLATECONF="../meta-multi-v7-ml-bsp/template-multi-v7-ml-debug-training"
     echo "TEMPLATECONF: ${TEMPLATECONF}"
     echo "source ../sources/poky-training/oe-init-build-env ${machine}"
     source ../sources/poky-training/oe-init-build-env ${machine}
     # only copy site.conf if it's not already there
     if [ ! -f conf/site.conf ]; then
        cp ${SITE_CONF} conf/site.conf
        tree conf
     fi
  fi

  # as above, but master
  if [ "$machine" == "multi-v7-ml-debug-training-libs-master" ]; then
     # we use the same template as for standard training
     export TEMPLATECONF="../meta-multi-v7-ml-bsp-master/conf/templates/template-multi-v7-ml-debug-training-master"
     echo "TEMPLATECONF: ${TEMPLATECONF}"
     echo "source ../sources/poky-training-master/oe-init-build-env ${machine}"
     source ../sources/poky-training-master/oe-init-build-env ${machine}
     # only copy site.conf if it's not already there
     if [ ! -f conf/site.conf ]; then
        cp ../../sources/meta-multi-v7-ml-bsp-master/conf/templates/template-multi-v7-ml-debug-training-master/site.conf conf/site.conf
        tree conf
     fi
  fi

  # rootfs + kernel + ftd(s) - no u-boot, no sd card image
  # used for development
  # DISTRO = resy
  # default kernel config: debug
  # poky -> poky-training

  if [ "$machine" == "multi-v7-ml-debug-training-pkgs" ]; then
     # we use the same template as for standard training
     export TEMPLATECONF="../meta-multi-v7-ml-bsp/template-multi-v7-ml-debug-training"
     echo "TEMPLATECONF: ${TEMPLATECONF}"
     echo "source ../sources/poky-training/oe-init-build-env ${machine}"
     source ../sources/poky-training/oe-init-build-env ${machine}
     # only copy site.conf if it's not already there
     if [ ! -f conf/site.conf ]; then
        cp ${SITE_CONF} conf/site.conf
        tree conf
     fi
  fi


  if [ "$machine" == "multi-v7-ml-debug-training-pkgs-master" ]; then
     # we use the same template as for standard training
     export TEMPLATECONF="../meta-multi-v7-ml-bsp-master/conf/templates/template-multi-v7-ml-debug-training-master"
     echo "TEMPLATECONF: ${TEMPLATECONF}"
     echo "source ../sources/poky-training-master/oe-init-build-env ${machine}"
     source ../sources/poky-training-master/oe-init-build-env ${machine}
     # only copy site.conf if it's not already there
     if [ ! -f conf/site.conf ]; then
        #cp ${SITE_CONF} conf/site.conf
        cp ../../sources/meta-multi-v7-ml-bsp-master/conf/templates/template-multi-v7-ml-debug-training-master/site.conf conf/site.conf
        tree conf
     fi
  fi

  # rootfs + kernel + ftd(s) - no u-boot, no sd card image
  # used for development
  # DISTRO = resy
  # default kernel config: debug
  # poky -> poky-training
  # special template

  if [ "$machine" == "multi-v7-ml-debug-training-lic" ]; then
     # we use the same template as for standard training
     export TEMPLATECONF="../meta-multi-v7-ml-bsp/template-${machine}"
     echo "TEMPLATECONF: ${TEMPLATECONF}"
     echo "source ../sources/poky-training/oe-init-build-env ${machine}"
     source ../sources/poky-training/oe-init-build-env ${machine}
     # only copy site.conf if it's not already there
     if [ ! -f conf/site.conf ]; then
        cp ${SITE_CONF} conf/site.conf
        tree conf
     fi
  fi

  if [ "$machine" == "multi-v7-ml-debug-training-lic-master" ]; then
     # we use the same template as for standard training
     export TEMPLATECONF="../meta-multi-v7-ml-bsp-master/conf/templates/template-${machine}"
     echo "TEMPLATECONF: ${TEMPLATECONF}"
     echo "source ../sources/poky-training-master/oe-init-build-env ${machine}"
     source ../sources/poky-training-master/oe-init-build-env ${machine}
     # only copy site.conf if it's not already there
     if [ ! -f conf/site.conf ]; then
        #cp ${SITE_CONF} conf/site.conf
        cp ../../sources/meta-multi-v7-ml-bsp-master/conf/templates/template-multi-v7-ml-debug-training-master/site.conf conf/site.conf
        tree conf
     fi
  fi




  # rootfs + kernel + ftd(s) - no u-boot, no sd card image
  # used for development - ipk: signed packages, signed package feed
  # DISTRO = resy
  # default kernel config: std?
  # poky

  if [ "$machine" == "multi-v7-ml-pkgs" ]; then
     # we use the same template as for standard training
     export TEMPLATECONF="../meta-multi-v7-ml-bsp/template-multi-v7-ml-pkgs"
     echo "TEMPLATECONF: ${TEMPLATECONF}"
     echo "source ../sources/poky/oe-init-build-env ${machine}"
     source ../sources/poky/oe-init-build-env ${machine}
     # only copy site.conf if it's not already there
     if [ ! -f conf/site.conf ]; then
        cp ${SITE_CONF} conf/site.conf
        tree conf
     fi
     # import the keys
     ../../sources/meta-multi-v7-ml-bsp/template-multi-v7-ml-pkgs/gpg-stuff/container-import-keys.sh
  fi


  # rootfs + kernel + ftd(s) - no u-boot, no sd card image
  # used for development
  # DISTRO = resy-virt
  # default kernel config: virt

  if [ "$machine" == "multi-v7-ml-virt" ]; then
     export TEMPLATECONF="../meta-multi-v7-ml-bsp/template-${machine}"
     echo "TEMPLATECONF: ${TEMPLATECONF}"
     echo "source ../sources/poky/oe-init-build-env ${machine}"
     source ../sources/poky/oe-init-build-env ${machine}
     # only copy site.conf if it's not already there
     if [ ! -f conf/site.conf ]; then
        cp ${SITE_CONF} conf/site.conf
        tree conf
     fi
  fi

  # multi-v7 mender update image for various boards

  if [ "$machine" == "multi-v7-mender" ]; then
     export TEMPLATECONF="../meta-u-boot-mender-bsp/template-multi-v7"
     echo "TEMPLATECONF: ${TEMPLATECONF}"
     echo "source ../sources/poky/oe-init-build-env ${machine}"
     source ../sources/poky/oe-init-build-env ${machine}
     # only copy site.conf if it's not already there
     if [ ! -f conf/site.conf ]; then
        cp ${SITE_CONF} conf/site.conf
        tree conf
     fi
  fi

  # rootfs over nfs or SD card
  # for imx8mm-lpddr4-evk master branch

  if [ "$machine" == "imx8mm-lpddr4-evk-master" ]; then
     export TEMPLATECONF="../meta-fsl-common-master/template-${machine}"
     echo "TEMPLATECONF: ${TEMPLATECONF}"
     echo "source ../sources/poky-master/oe-init-build-env ${machine}"
     source ../sources/poky-master/oe-init-build-env ${machine}
     # only copy site.conf if it's not already there
     if [ ! -f conf/site.conf ]; then
        #cp ${SITE_CONF} conf/site.conf
        # custom site.conf
        cp ../../sources/meta-fsl-common-master/template-${machine}/site.conf conf/site.conf
        tree conf
     fi
  fi

  # rootfs over nfs or SD card
  # for zedboard-zynq7 master branch
  # this uses meta-xilinx-master!

  if [ "$machine" == "zedboard-zynq7-master" ]; then
     export TEMPLATECONF="../meta-xilinx-common-master/template-${machine}"
     echo "TEMPLATECONF: ${TEMPLATECONF}"
     echo "source ../sources/poky-master/oe-init-build-env ${machine}"
     source ../sources/poky-master/oe-init-build-env ${machine}
     # only copy site.conf if it's not already there
     if [ ! -f conf/site.conf ]; then
        #cp ${SITE_CONF} conf/site.conf
        # custom site.conf
        cp ../../sources/meta-xilinx-common-master/template-${machine}/site.conf conf/site.conf
        tree conf
     fi
  fi

  # rootfs over nfs or SD card
  # for imx8mm-lpddr4-evk-ml master branch

  if [ "$machine" == "imx8mm-lpddr4-evk-ml-master" ]; then
     export TEMPLATECONF="../meta-imx8mm-lpddr4-evk-ml-bsp-master/template-${machine}"
     echo "TEMPLATECONF: ${TEMPLATECONF}"
     echo "source ../sources/poky-master/oe-init-build-env ${machine}"
     source ../sources/poky-master/oe-init-build-env ${machine}
     # only copy site.conf if it's not already there
     if [ ! -f conf/site.conf ]; then
        #cp ${SITE_CONF} conf/site.conf
        # custom site.conf
        cp ../../sources/meta-imx8mm-lpddr4-evk-ml-bsp-master/template-${machine}/site.conf conf/site.conf
        tree conf
     fi
  fi

  # rootfs over nfs or SD card
  # for imx8mm-lpddr4-evk-ml-virt-docker-master master branch

  if [ "$machine" == "imx8mm-lpddr4-evk-ml-virt-docker-master" ]; then
     export TEMPLATECONF="../meta-imx8mm-lpddr4-evk-ml-bsp-master/template-${machine}"
     echo "TEMPLATECONF: ${TEMPLATECONF}"
     echo "source ../sources/poky-master/oe-init-build-env ${machine}"
     source ../sources/poky-master/oe-init-build-env ${machine}
     # only copy site.conf if it's not already there
     if [ ! -f conf/site.conf ]; then
        #cp ${SITE_CONF} conf/site.conf
        # custom site.conf
        cp ../../sources/meta-imx8mm-lpddr4-evk-ml-bsp-master/template-${machine}/site.conf conf/site.conf
        tree conf
     fi
  fi

  # tensorflow container
  # for container-imx8mm-lpddr4-evk-ml-virt-docker-master master branch

  if [ "$machine" == "container-imx8mm-lpddr4-evk-ml-tensorflow-master" ]; then
     export TEMPLATECONF="../meta-imx8mm-lpddr4-evk-ml-bsp-master/template-${machine}"
     echo "TEMPLATECONF: ${TEMPLATECONF}"
     echo "source ../sources/poky-master/oe-init-build-env ${machine}"
     source ../sources/poky-master/oe-init-build-env ${machine}
     # only copy site.conf if it's not already there
     if [ ! -f conf/site.conf ]; then
        #cp ${SITE_CONF} conf/site.conf
        # custom site.conf
        cp ../../sources/meta-imx8mm-lpddr4-evk-ml-bsp-master/template-${machine}/site.conf conf/site.conf
        tree conf
     fi
  fi


  # rootfs over nfs or SD card
  # upstream kernel
  # hacked fdt
  # sd card image e.g. core-image-base
  # for phyboard-polis-imx8mm

  if [ "$machine" == "phyboard-polis-imx8mm-wic" ]; then
     export TEMPLATECONF="../meta-phyboard-polis-imx8mm-bsp/template-${machine}"
     echo "TEMPLATECONF: ${TEMPLATECONF}"
     echo "source ../sources/poky/oe-init-build-env ${machine}"
     source ../sources/poky/oe-init-build-env ${machine}
     # only copy site.conf if it's not already there
     if [ ! -f conf/site.conf ]; then
        #cp ${SITE_CONF} conf/site.conf
        # custom site.conf
        cp ../../sources/meta-phyboard-polis-imx8mm-bsp/template-${machine}/site.conf conf/site.conf
        tree conf
     fi
  fi


  # rootfs over nfs or SD card
  # upstream kernel
  # hacked fdt
  # sd card image e.g. core-image-base
  # for phyboard-polis-imx8mm

  if [ "$machine" == "phyboard-polis-imx8mm-wic-virt" ]; then
     export TEMPLATECONF="../meta-phyboard-polis-imx8mm-bsp/template-${machine}"
     echo "TEMPLATECONF: ${TEMPLATECONF}"
     echo "source ../sources/poky/oe-init-build-env ${machine}"
     source ../sources/poky/oe-init-build-env ${machine}
     # only copy site.conf if it's not already there
     if [ ! -f conf/site.conf ]; then
        #cp ${SITE_CONF} conf/site.conf
        # custom site.conf
        cp ../../sources/meta-phyboard-polis-imx8mm-bsp/template-${machine}/site.conf conf/site.conf
        tree conf
     fi
  fi



  # rootfs over nfs or SD card
  # raspi kernel
  # raspi fdt
  # sd card image e.g. core-image-base
  # for raspberrypi-4-64 

  if [ "$machine" == "raspberrypi-4-64-raspi-kernel-wic" ]; then
     export TEMPLATECONF="../meta-raspberrypi-ml-bsp/template-${machine}"
     echo "TEMPLATECONF: ${TEMPLATECONF}"
     echo "source ../sources/poky/oe-init-build-env ${machine}"
     source ../sources/poky/oe-init-build-env ${machine}
     # only copy site.conf if it's not already there
     if [ ! -f conf/site.conf ]; then
        #cp ${SITE_CONF} conf/site.conf
        # custom site.conf
        cp ../../sources/meta-raspberrypi-ml-bsp/template-${machine}/site.conf conf/site.conf
        tree conf
     fi
  fi

  # rootfs over nfs or SD card
  # mainline/stable kernel
  # raspi fdt ?
  # sd card image e.g. core-image-base
  # for raspberrypi-4-64 

  if [ "$machine" == "raspberrypi-4-64-ml-kernel-wic" ]; then
     export TEMPLATECONF="../meta-raspberrypi-ml-bsp/template-${machine}"
     echo "TEMPLATECONF: ${TEMPLATECONF}"
     echo "source ../sources/poky/oe-init-build-env ${machine}"
     source ../sources/poky/oe-init-build-env ${machine}
     # only copy site.conf if it's not already there
     if [ ! -f conf/site.conf ]; then
        #cp ${SITE_CONF} conf/site.conf
        # custom site.conf
        cp ../../sources/meta-raspberrypi-ml-bsp/template-${machine}/site.conf conf/site.conf
        tree conf
     fi
  fi

  # everthing from SD card
  # virt kernel
  # raspi fdt ?
  # sd card image e.g. core-image-base
  # for raspberrypi-4-64 

  if [ "$machine" == "raspberrypi-4-64-ml-kernel-wic-virt-all-sdcard" ]; then
     export TEMPLATECONF="../meta-raspberrypi-ml-bsp/template-${machine}"
     echo "TEMPLATECONF: ${TEMPLATECONF}"
     echo "source ../sources/poky/oe-init-build-env ${machine}"
     source ../sources/poky/oe-init-build-env ${machine}
     # only copy site.conf if it's not already there
     if [ ! -f conf/site.conf ]; then
        #cp ${SITE_CONF} conf/site.conf
        # custom site.conf
        cp ../../sources/meta-raspberrypi-ml-bsp/template-${machine}/site.conf conf/site.conf
        tree conf
     fi
  fi

  # kernel/fdt from tftp
  # rootfs over nfs
  # /dev/mmcblk1p3 on /var/lib/docker type btrfs
  # virt kernel
  # raspi fdt ?
  # sd card image e.g. core-image-base
  # for raspberrypi-4-64 

  if [ "$machine" == "raspberrypi-4-64-ml-kernel-wic-virt-tftp-nfs" ]; then
     export TEMPLATECONF="../meta-raspberrypi-ml-bsp/template-${machine}"
     echo "TEMPLATECONF: ${TEMPLATECONF}"
     echo "source ../sources/poky/oe-init-build-env ${machine}"
     source ../sources/poky/oe-init-build-env ${machine}
     # only copy site.conf if it's not already there
     if [ ! -f conf/site.conf ]; then
        #cp ${SITE_CONF} conf/site.conf
        # custom site.conf
        cp ../../sources/meta-raspberrypi-ml-bsp/template-${machine}/site.conf conf/site.conf
        tree conf
     fi
  fi


  # raspberrypi4-64-master
  # rootfs,
  # meta-raspberrypi kernel,
  # fdt,
  # sd card image e.g. core-image-base
  # for raspberrypi4-64

  if [ "$machine" == "raspberrypi4-64-master" ]; then
     export TEMPLATECONF="../meta-raspberrypi-common-master/template-${machine}"
     echo "TEMPLATECONF: ${TEMPLATECONF}"
     echo "source ../sources/poky-master/oe-init-build-env ${machine}"
     source ../sources/poky-master/oe-init-build-env ${machine}
     # only copy site.conf if it's not already there
     if [ ! -f conf/site.conf ]; then
        cp ../../sources/meta-raspberrypi-common-master/template-${machine}/site.conf conf/site.conf
        tree conf
     fi
  fi

  # raspberrypi4-64-updater-master
  # rootfs,
  # meta-raspberrypi kernel,
  # fdt,
  # sd card image e.g. core-image-base
  # for raspberrypi4-64

#  if [ "$machine" == "raspberrypi4-64-updater-master" ]; then
#     export TEMPLATECONF="../meta-raspberrypi-common-master/template-${machine}"
#     echo "TEMPLATECONF: ${TEMPLATECONF}"
#     echo "source ../sources/poky-master/oe-init-build-env ${machine}"
#     source ../sources/poky-master/oe-init-build-env ${machine}
#     # only copy site.conf if it's not already there
#     if [ ! -f conf/site.conf ]; then
#        cp ../../sources/meta-raspberrypi-common-master/template-${machine}/site.conf conf/site.conf
#        tree conf
#     fi
#  fi

  # raspberrypi4-64-virt-docker-master
  # rootfs,
  # meta-raspberrypi kernel, + config for docker?
  # fdt,
  # sd card image e.g. core-image-base
  # for raspberrypi4-64

  if [ "$machine" == "raspberrypi4-64-virt-docker-master" ]; then
     export TEMPLATECONF="../meta-raspberrypi-common-master/template-${machine}"
     echo "TEMPLATECONF: ${TEMPLATECONF}"
     echo "source ../sources/poky-master/oe-init-build-env ${machine}"
     source ../sources/poky-master/oe-init-build-env ${machine}
     # only copy site.conf if it's not already there
     if [ ! -f conf/site.conf ]; then
        cp ../../sources/meta-raspberrypi-common-master/template-${machine}/site.conf conf/site.conf
        tree conf
     fi
  fi

  # raspberrypi4-64-virt-k3s-master
  # rootfs,
  # meta-raspberrypi kernel, + config for k3s?
  # fdt,
  # sd card image e.g. core-image-base
  # for raspberrypi4-64

  if [ "$machine" == "raspberrypi4-64-virt-k3s-master" ]; then
     export TEMPLATECONF="../meta-raspberrypi-common-master/template-${machine}"
     echo "TEMPLATECONF: ${TEMPLATECONF}"
     echo "source ../sources/poky-master/oe-init-build-env ${machine}"
     source ../sources/poky-master/oe-init-build-env ${machine}
     # only copy site.conf if it's not already there
     if [ ! -f conf/site.conf ]; then
        cp ../../sources/meta-raspberrypi-common-master/template-${machine}/site.conf conf/site.conf
        tree conf
     fi
  fi


  # raspberrypi4-64-virt-k3s-master-bosc
  # rootfs,
  # meta-raspberrypi kernel, + config for k3s?
  # fdt,
  # sd card image e.g. core-image-base
  # for raspberrypi4-64

  if [ "$machine" == "raspberrypi4-64-virt-k3s-master-bosc" ]; then
     export TEMPLATECONF="../meta-raspberrypi-common-master-bosc/template-${machine}"
     echo "TEMPLATECONF: ${TEMPLATECONF}"
     echo "source ../sources/meta-raspberrypi-resy-collection-bosc/poky-master-bosc/oe-init-build-env ${machine}"
     pwd
     source ../sources/meta-raspberrypi-resy-collection-bosc/poky-master-bosc/oe-init-build-env ${machine}
     # only copy site.conf if it's not already there
     if [ ! -f conf/site.conf ]; then
        pwd
        cp ../../sources/meta-raspberrypi-resy-collection-bosc/meta-raspberrypi-common-master-bosc/template-${machine}/site.conf conf/site.conf
        tree conf
     fi
  fi

  # raspberrypi3-64-master
  # rootfs,
  # meta-raspberrypi kernel,
  # fdt,
  # sd card image e.g. core-image-base
  # for raspberrypi3-64

  if [ "$machine" == "raspberrypi3-64-master" ]; then
     export TEMPLATECONF="../meta-raspberrypi-common-master/template-${machine}"
     echo "TEMPLATECONF: ${TEMPLATECONF}"
     echo "source ../sources/poky-master/oe-init-build-env ${machine}"
     source ../sources/poky-master/oe-init-build-env ${machine}
     # only copy site.conf if it's not already there
     if [ ! -f conf/site.conf ]; then
        cp ../../sources/meta-raspberrypi-common-master/template-${machine}/site.conf conf/site.conf
        tree conf
     fi
  fi


  # rootfs, 
  # std kernel from multi-v7-ml, 
  # fdt, 
  # sd card image e.g. core-image-minimal
  # for imx6q-phytec-mira-rdk-nand

  if [ "$machine" == "imx6q-phytec-mira-rdk-nand-wic" ]; then
     export TEMPLATECONF="../meta-u-boot-wic-bsp/template-imx6q-phytec-mira-rdk-nand"
     echo "TEMPLATECONF: ${TEMPLATECONF}"
     echo "source ../sources/poky/oe-init-build-env ${machine}"
     source ../sources/poky/oe-init-build-env ${machine}
     # only copy site.conf if it's not already there
     if [ ! -f conf/site.conf ]; then
        cp ${SITE_CONF} conf/site.conf
        tree conf
     fi
  fi

  # rootfs,
  # std kernel from multi-v7-ml,
  # fdt,
  # sd card image e.g. core-image-minimal
  # for imx6q-phytec-mira-rdk-nand

  if [ "$machine" == "imx6q-phytec-mira-rdk-nand-wic-master" ]; then
     export TEMPLATECONF="../meta-u-boot-wic-bsp-master/conf/templates/template-imx6q-phytec-mira-rdk-nand-master"
     echo "TEMPLATECONF: ${TEMPLATECONF}"
     echo "source ../sources/poky-master/oe-init-build-env ${machine}"
     source ../sources/poky-master/oe-init-build-env ${machine}
     # only copy site.conf if it's not already there
     if [ ! -f conf/site.conf ]; then
        #cp ${SITE_CONF} conf/site.conf
        # custom site.conf
        cp ../../sources/meta-u-boot-wic-bsp-master/conf/templates/template-imx6q-phytec-mira-rdk-nand-master/site.conf conf/site.conf
        tree conf
     fi
  fi

  # rootfs,
  # std kernel from multi-v7-ml,
  # fdt,
  # sd card image e.g. core-image-minimal
  # for imx6q-phytec-mira-rdk-nand

  if [ "$machine" == "imx6q-phytec-mira-rdk-nand-npm-wic-master" ]; then
     export TEMPLATECONF="../meta-u-boot-wic-bsp-master/template-imx6q-phytec-mira-rdk-nand-npm-master"
     echo "TEMPLATECONF: ${TEMPLATECONF}"
     echo "source ../sources/poky-master/oe-init-build-env ${machine}"
     source ../sources/poky-master/oe-init-build-env ${machine}
     # only copy site.conf if it's not already there
     if [ ! -f conf/site.conf ]; then
        #cp ${SITE_CONF} conf/site.conf
        # custom site.conf
        cp ../../sources/meta-u-boot-wic-bsp-master/template-imx6q-phytec-mira-rdk-nand-npm-master/site.conf conf/site.conf
        tree conf
     fi
  fi

  # rootfs,
  # std kernel from multi-v7-ml,
  # fdt,
  # sd card image e.g. core-image-minimal
  # for zynq-zed (mine)

  if [ "$machine" == "zynq-zed-wic-master" ]; then
     export TEMPLATECONF="../meta-u-boot-wic-bsp-master/template-${machine}"
     echo "TEMPLATECONF: ${TEMPLATECONF}"
     echo "source ../sources/poky-master/oe-init-build-env ${machine}"
     source ../sources/poky-master/oe-init-build-env ${machine}
     # only copy site.conf if it's not already there
     if [ ! -f conf/site.conf ]; then
        #cp ${SITE_CONF} conf/site.conf
        # custom site.conf
        cp ../../sources/meta-u-boot-wic-bsp-master/template-${machine}/site.conf conf/site.conf
        tree conf
     fi
  fi

  # rootfs which can host docker,
  # virt kernel from multi-v7-ml,
  # fdt
  # sd card image e.g. core-image-minimal-virt-docker-ce
  # for imx6q-phytec-mira-rdk-nand

  if [ "$machine" == "imx6q-phytec-mira-rdk-nand-virt-wic" ]; then
     export TEMPLATECONF="../meta-u-boot-wic-bsp/template-imx6q-phytec-mira-rdk-nand-virt"
     echo "TEMPLATECONF: ${TEMPLATECONF}"
     # --> let's try to merge in sca stuff
     if [ ! -d ../build/${machine}/conf ]; then
       echo "../build/${machine}/ does not exist - creating it via TEMPLATECONF"
       mv -f /workdir/sources/poky/${TEMPLATECONF}/local.conf.sample  /workdir/sources/poky/${TEMPLATECONF}/local.conf.sample.ori
       cat /workdir/sources/poky/${TEMPLATECONF}/local.conf.sample.ori  /workdir/sources/meta-resy/template-common/sca.conf.sample > /workdir/sources/poky/${TEMPLATECONF}/local.conf.sample
       cat /workdir/sources/poky/${TEMPLATECONF}/local.conf.sample
     else
       echo "../build/${machine}/ already exists - not recreating it via TEMPLATECONF"
     fi
     # <-- let's try to merge in sca stuff
     echo "source ../sources/poky/oe-init-build-env ${machine}"
     source ../sources/poky/oe-init-build-env ${machine}
     # only copy site.conf if it's not already there
     if [ ! -f conf/site.conf ]; then
        cp ${SITE_CONF} conf/site.conf
        tree conf
     fi
     # --> more SCA stuff
     if [ -f /workdir/sources/poky/${TEMPLATECONF}/local.conf.sample.ori ]; then
        # let's restore the original without sca
        mv -f /workdir/sources/poky/${TEMPLATECONF}/local.conf.sample.ori /workdir/sources/poky/${TEMPLATECONF}/local.conf.sample
     fi
     # <-- more SCA stuff
  fi

  # rootfs which can host docker,
  # virt kernel from multi-v7-ml,
  # fdt
  # sd card image e.g. core-image-minimal-virt-docker-ce
  # for beagle-bone-black
  # removed sca

  if [ "$machine" == "beagle-bone-black-virt-wic" ]; then
     export TEMPLATECONF="../meta-u-boot-wic-bsp/template-beagle-bone-black-virt"
     echo "TEMPLATECONF: ${TEMPLATECONF}"
     # --> let's try to merge in sca stuff
     if [ ! -d ../build/${machine}/conf ]; then
       echo "../build/${machine}/ does not exist - creating it via TEMPLATECONF"
       #mv -f /workdir/sources/poky/${TEMPLATECONF}/local.conf.sample  /workdir/sources/poky/${TEMPLATECONF}/local.conf.sample.ori
       #cat /workdir/sources/poky/${TEMPLATECONF}/local.conf.sample.ori  /workdir/sources/meta-resy/template-common/sca.conf.sample > /workdir/sources/poky/${TEMPLATECONF}/local.conf.sample
       #cat /workdir/sources/poky/${TEMPLATECONF}/local.conf.sample
     else
       echo "../build/${machine}/ already exists - not recreating it via TEMPLATECONF"
     fi
     # <-- let's try to merge in sca stuff
     echo "source ../sources/poky/oe-init-build-env ${machine}"
     source ../sources/poky/oe-init-build-env ${machine}
     # only copy site.conf if it's not already there
     if [ ! -f conf/site.conf ]; then
        cp ${SITE_CONF} conf/site.conf
        tree conf
     fi
     # --> more SCA stuff
     #if [ -f /workdir/sources/poky/${TEMPLATECONF}/local.conf.sample.ori ]; then
     #   # let's restore the original without sca
     #   mv -f /workdir/sources/poky/${TEMPLATECONF}/local.conf.sample.ori /workdir/sources/poky/${TEMPLATECONF}/local.conf.sample
     #fi
     # <-- more SCA stuff
  fi

  # rootfs which can host docker,
  # virt kernel from multi-v7-ml,
  # fdt
  # sd card image e.g. core-image-minimal-virt-docker-ce
  # for imx6q-phytec-mira-rdk-nand wic image
  # but here also multiconfig - attempt to build rootfs with docker plus
  # application container

  if [ "$machine" == "imx6q-phytec-mira-rdk-nand-virt-wic-mc" ]; then
     export TEMPLATECONF="../meta-u-boot-wic-bsp/template-imx6q-phytec-mira-rdk-nand-virt-mc"
     echo "TEMPLATECONF: ${TEMPLATECONF}"
     # --> let's try to merge in sca stuff
     #if [ ! -d ../build/${machine}/conf ]; then
     #  echo "../build/${machine}/ does not exist - creating it via TEMPLATECONF"
     #  mv -f /workdir/sources/poky/${TEMPLATECONF}/local.conf.sample  /workdir/sources/poky/${TEMPLATECONF}/local.conf.sample.ori
     #  cat /workdir/sources/poky/${TEMPLATECONF}/local.conf.sample.ori  /workdir/sources/meta-resy/template-common/sca.conf.sample > /workdir/sources/poky/${TEMPLATECONF}/local.conf.sample
     #  cat /workdir/sources/poky/${TEMPLATECONF}/local.conf.sample
     #else
     #  echo "../build/${machine}/ already exists - not recreating it via TEMPLATECONF"
     #fi
     # <-- let's try to merge in sca stuff
     echo "source ../sources/poky/oe-init-build-env ${machine}"
     source ../sources/poky/oe-init-build-env ${machine}
     # only copy site.conf if it's not already there
     if [ ! -f conf/site.conf ]; then
        cp ${SITE_CONF} conf/site.conf
        tree conf
     fi
     # --> more SCA stuff 
     if [ -f /workdir/sources/poky/${TEMPLATECONF}/local.conf.sample.ori ]; then
        # let's restore the original without sca
        mv -f /workdir/sources/poky/${TEMPLATECONF}/local.conf.sample.ori /workdir/sources/poky/${TEMPLATECONF}/local.conf.sample
     fi
     # <-- more SCA stuff
  fi


  # rootfs which can host docker,
  # virt kernel from multi-v7-ml,
  # fdt
  # sd card image e.g. core-image-minimal-virt-docker-ce
  # for imx6q-phytec-mira-rdk-nand wic image
  # but here also multiconfig - attempt to build rootfs with docker plus
  # application container

  if [ "$machine" == "imx6q-phytec-mira-rdk-nand-virt-wic-mc-master" ]; then
     export TEMPLATECONF="../meta-u-boot-wic-bsp-master/template-imx6q-phytec-mira-rdk-nand-virt-mc-master"
     echo "TEMPLATECONF: ${TEMPLATECONF}"
     # --> let's try to merge in sca stuff
     #if [ ! -d ../build/${machine}/conf ]; then
     #  echo "../build/${machine}/ does not exist - creating it via TEMPLATECONF"
     #  mv -f /workdir/sources/poky/${TEMPLATECONF}/local.conf.sample  /workdir/sources/poky/${TEMPLATECONF}/local.conf.sample.ori
     #  cat /workdir/sources/poky/${TEMPLATECONF}/local.conf.sample.ori  /workdir/sources/meta-resy/template-common/sca.conf.sample > /workdir/sources/poky/${TEMPLATECONF}/local.conf.sample
     #  cat /workdir/sources/poky/${TEMPLATECONF}/local.conf.sample
     #else
     #  echo "../build/${machine}/ already exists - not recreating it via TEMPLATECONF"
     #fi
     # <-- let's try to merge in sca stuff
     echo "source ../sources/poky-master/oe-init-build-env ${machine}"
     source ../sources/poky-master/oe-init-build-env ${machine}
     # only copy site.conf if it's not already there
     if [ ! -f conf/site.conf ]; then
        #cp ${SITE_CONF} conf/site.conf
        cp ../../sources/meta-u-boot-wic-bsp-master/template-imx6q-phytec-mira-rdk-nand-virt-mc-master/site.conf conf/site.conf
        tree conf
     fi
     # --> more SCA stuff 
     #if [ -f /workdir/sources/poky/${TEMPLATECONF}/local.conf.sample.ori ]; then
     #   # let's restore the original without sca
     #   mv -f /workdir/sources/poky/${TEMPLATECONF}/local.conf.sample.ori /workdir/sources/poky/${TEMPLATECONF}/local.conf.sample
     #fi
     # <-- more SCA stuff
  fi

  # rootfs which can host docker
  # virt kernel from multi-v7-ml,
  # fdt
  # sd card image e.g. core-image-minimal-virt-docker

  if [ "$machine" == "imx6q-phytec-mira-rdk-nand-virt-docker-master" ]; then
     export TEMPLATECONF="../meta-u-boot-wic-bsp-master/template-${machine}"
     echo "TEMPLATECONF: ${TEMPLATECONF}"
     echo "source ../sources/poky-master/oe-init-build-env ${machine}"
     source ../sources/poky-master/oe-init-build-env ${machine}
     # only copy site.conf if it's not already there
     if [ ! -f conf/site.conf ]; then
        #cp ${SITE_CONF} conf/site.conf
        cp ../../sources/meta-u-boot-wic-bsp-master/template-${machine}/site.conf conf/site.conf
        tree conf
     fi
  fi

  # rootfs which can host podman
  # virt kernel from multi-v7-ml,
  # fdt
  # sd card image e.g. core-image-minimal-virt-docker

  if [ "$machine" == "imx6q-phytec-mira-rdk-nand-virt-podman-master" ]; then
     export TEMPLATECONF="../meta-u-boot-wic-bsp-master/template-${machine}"
     echo "TEMPLATECONF: ${TEMPLATECONF}"
     echo "source ../sources/poky-master/oe-init-build-env ${machine}"
     source ../sources/poky-master/oe-init-build-env ${machine}
     # only copy site.conf if it's not already there
     if [ ! -f conf/site.conf ]; then
        #cp ${SITE_CONF} conf/site.conf
        cp ../../sources/meta-u-boot-wic-bsp-master/template-${machine}/site.conf conf/site.conf
        tree conf
     fi
  fi

  if [ "$machine" == "imx6q-phytec-mira-rdk-nand-virt-mender" ]; then
     export TEMPLATECONF="../meta-u-boot-mender-bsp/template-imx6q-phytec-mira-rdk-nand-virt"
     echo "TEMPLATECONF: ${TEMPLATECONF}"
     # --> let's try to merge in sca stuff
    if [ ! -d ../build/${machine}/conf ]; then
       echo "../build/${machine}/ does not exist - creating it via TEMPLATECONF"
       mv -f /workdir/sources/poky/${TEMPLATECONF}/local.conf.sample  /workdir/sources/poky/${TEMPLATECONF}/local.conf.sample.ori
       cat /workdir/sources/poky/${TEMPLATECONF}/local.conf.sample.ori  /workdir/sources/meta-resy/template-common/sca.conf.sample > /workdir/sources/poky/${TEMPLATECONF}/local.conf.sample
       cat /workdir/sources/poky/${TEMPLATECONF}/local.conf.sample
     else
       echo "../build/${machine}/ already exists - not recreating it via TEMPLATECONF"
     fi
     # <-- let's try to merge in sca stuff
     echo "source ../sources/poky/oe-init-build-env ${machine}"
     source ../sources/poky/oe-init-build-env ${machine}
     # only copy site.conf if it's not already there
     if [ ! -f conf/site.conf ]; then
        cp ${SITE_CONF} conf/site.conf
        # let's restore the original without sca
        tree conf
     fi
     # --> more SCA stuff 
     if [ -f /workdir/sources/poky/${TEMPLATECONF}/local.conf.sample.ori ]; then
        # let's restore the original without sca
        mv -f /workdir/sources/poky/${TEMPLATECONF}/local.conf.sample.ori /workdir/sources/poky/${TEMPLATECONF}/local.conf.sample
     fi
     # <-- more SCA stuff
  fi

  # mender sd card image
  if [ "$machine" == "imx6q-phytec-mira-rdk-nand-mender" ]; then
     export TEMPLATECONF="../meta-u-boot-mender-bsp/template-imx6q-phytec-mira-rdk-nand"
     echo "TEMPLATECONF: ${TEMPLATECONF}"
     echo "source ../sources/poky/oe-init-build-env ${machine}"
     source ../sources/poky/oe-init-build-env ${machine}
     # only copy site.conf if it's not already there
     if [ ! -f conf/site.conf ]; then
        cp ${SITE_CONF} conf/site.conf
        tree conf
     fi
  fi


  # rootfs,
  # kernel/fdt 
  # std kernel from multi-v7-ml, 
  # sd card image e.g. core-image-minimal
  # for beagle-bone-black

  if [ "$machine" == "beagle-bone-black-wic" ]; then
     export TEMPLATECONF="../meta-u-boot-wic-bsp/template-beagle-bone-black"
     echo "TEMPLATECONF: ${TEMPLATECONF}"
     echo "source ../sources/poky/oe-init-build-env ${machine}"
     source ../sources/poky/oe-init-build-env ${machine}
     # only copy site.conf if it's not already there
     if [ ! -f conf/site.conf ]; then
        cp ${SITE_CONF} conf/site.conf
        tree conf
     fi
  fi

  # machine:beaglebone-yocto (from poky)
  # distro:resy
  # sd card image e.g. core-image-minimal
  # for beagle-bone-black

  if [ "$machine" == "beaglebone-yocto-master" ]; then
     export TEMPLATECONF="../meta-resy-master/conf/templates/template-${machine}"
     echo "TEMPLATECONF: ${TEMPLATECONF}"
     echo "source ../sources/poky-master/oe-init-build-env ${machine}"
     source ../sources/poky-master/oe-init-build-env ${machine}
     # only copy site.conf if it's not already there
     if [ ! -f conf/site.conf ]; then
        #cp ${SITE_CONF} conf/site.conf
        # custom site.conf
	pwd
        cp ../../sources/meta-resy-master/conf/templates/template-${machine}/site.conf conf/site.conf
        tree conf
     fi
  fi

  # machine:beaglebone-yocto (from poky)
  # distro:resy
  # swupdate added
  # sd card image e.g. core-image-minimal
  # for beagle-bone-black

  if [ "$machine" == "beaglebone-yocto-swupdate-master" ]; then
     export TEMPLATECONF="../meta-resy-master/conf/templates/template-${machine}"
     echo "TEMPLATECONF: ${TEMPLATECONF}"
     echo "source ../sources/poky-master/oe-init-build-env ${machine}"
     source ../sources/poky-master/oe-init-build-env ${machine}
     # only copy site.conf if it's not already there
     if [ ! -f conf/site.conf ]; then
        #cp ${SITE_CONF} conf/site.conf
        # custom site.conf
        pwd
        cp ../../sources/meta-resy-master/conf/templates/template-${machine}/site.conf conf/site.conf
        tree conf
     fi
  fi



  # rootfs,
  # kernel/fdt
  # std kernel from multi-v7-ml,
  # sd card image e.g. core-image-minimal
  # for beagle-bone-black

  if [ "$machine" == "beagle-bone-black-wic-master" ]; then
     export TEMPLATECONF="../meta-u-boot-wic-bsp-master/template-beagle-bone-black-master"
     echo "TEMPLATECONF: ${TEMPLATECONF}"
     echo "source ../sources/poky-master/oe-init-build-env ${machine}"
     source ../sources/poky-master/oe-init-build-env ${machine}
     # only copy site.conf if it's not already there
     if [ ! -f conf/site.conf ]; then
        #cp ${SITE_CONF} conf/site.conf
        # custom site.conf
        cp ../../sources/meta-u-boot-wic-bsp-master/template-beagle-bone-black-master/site.conf conf/site.conf
        tree conf
     fi
  fi

  # rootfs,
  # kernel/fdt
  # std kernel from multi-v7-ml, plus some additional fragments
  # sd card image e.g. conserver-beagle-bone-black-wic-master
  # for beagle-bone-black

  if [ "$machine" == "conserver-beagle-bone-black-wic-master" ]; then
     export TEMPLATECONF="../meta-conserver-master/conf/templates/template-${machine}"
     echo "TEMPLATECONF: ${TEMPLATECONF}"
     echo "source ../sources/poky-master/oe-init-build-env ${machine}"
     source ../sources/poky-master/oe-init-build-env ${machine}
     # only copy site.conf if it's not already there
     if [ ! -f conf/site.conf ]; then
        #cp ${SITE_CONF} conf/site.conf
        # custom site.conf
        pwd
        cp ../../sources/meta-conserver-master/conf/templates/template-${machine}/site.conf conf/site.conf
        tree conf
     fi
  fi

  # rootfs,
  # kernel/fdt
  # std kernel from multi-v7-ml, plus some additional fragments
  # sd card image e.g. conserver-beagle-bone-black-wic-master
  # for beagle-bone-black
  # swupdate

  if [ "$machine" == "conserver-beagle-bone-black-wic-swupdate-master" ]; then
     export TEMPLATECONF="../meta-conserver-master/conf/templates/template-${machine}"
     echo "TEMPLATECONF: ${TEMPLATECONF}"
     echo "source ../sources/poky-master/oe-init-build-env ${machine}"
     source ../sources/poky-master/oe-init-build-env ${machine}
     # only copy site.conf if it's not already there
     if [ ! -f conf/site.conf ]; then
        #cp ${SITE_CONF} conf/site.conf
        # custom site.conf
        pwd
        cp ../../sources/meta-conserver-master/conf/templates/template-${machine}/site.conf conf/site.conf
        tree conf
     fi
  fi

  # mender sd card image
  if [ "$machine" == "beagle-bone-black-mender" ]; then
     export TEMPLATECONF="../meta-u-boot-mender-bsp/template-beagle-bone-black"
     echo "TEMPLATECONF: ${TEMPLATECONF}"
     echo "source ../sources/poky/oe-init-build-env ${machine}"
     source ../sources/poky/oe-init-build-env ${machine}
     # only copy site.conf if it's not already there
     if [ ! -f conf/site.conf ]; then
        cp ${SITE_CONF} conf/site.conf
        tree conf
     fi
  fi


  # rootfs,
  # kernel/fdt
  # std kernel from multi-v7-ml,
  # sd card image e.g. core-image-minimal
  # for pocketbeagle

  if [ "$machine" == "am335x-pocketbeagle-wic-master" ]; then
     export TEMPLATECONF="../meta-u-boot-wic-bsp-master/template-am335x-pocketbeagle-master"
     echo "TEMPLATECONF: ${TEMPLATECONF}"
     echo "source ../sources/poky-master/oe-init-build-env ${machine}"
     source ../sources/poky-master/oe-init-build-env ${machine}
     # only copy site.conf if it's not already there
     if [ ! -f conf/site.conf ]; then
        #cp ${SITE_CONF} conf/site.conf
        # custom site.conf
        cp ../../sources/meta-u-boot-wic-bsp-master/template-am335x-pocketbeagle-master/site.conf conf/site.conf
        tree conf
     fi
  fi

  # rootfs,
  # kernel/fdt
  # std kernel from multi-v7-ml,
  # sd card image e.g. core-image-minimal
  # for beagle-xm

  if [ "$machine" == "omap3-beagle-xm-wic-master" ]; then
     export TEMPLATECONF="../meta-u-boot-wic-bsp-master/template-omap3-beagle-xm-master"
     echo "TEMPLATECONF: ${TEMPLATECONF}"
     echo "source ../sources/poky-master/oe-init-build-env ${machine}"
     source ../sources/poky-master/oe-init-build-env ${machine}
     # only copy site.conf if it's not already there
     if [ ! -f conf/site.conf ]; then
        #cp ${SITE_CONF} conf/site.conf
        # custom site.conf
        cp ../../sources/meta-u-boot-wic-bsp-master/template-omap3-beagle-xm-master/site.conf conf/site.conf
        tree conf
     fi
  fi


  # rootfs,
  # kernel/fdt
  # std kernel from multi-v7-ml,
  # sd card image e.g. core-image-minimal
  # for stm32mp157c-dk2

  if [ "$machine" == "stm32mp157c-dk2-wic-master" ]; then
     export TEMPLATECONF="../meta-u-boot-wic-bsp-master/template-stm32mp157c-dk2-master"
     echo "TEMPLATECONF: ${TEMPLATECONF}"
     echo "source ../sources/poky-master/oe-init-build-env ${machine}"
     source ../sources/poky-master/oe-init-build-env ${machine}
     # only copy site.conf if it's not already there
     if [ ! -f conf/site.conf ]; then
        #cp ${SITE_CONF} conf/site.conf
        # custom site.conf
        cp ../../sources/meta-u-boot-wic-bsp-master/template-stm32mp157c-dk2-master/site.conf conf/site.conf
        tree conf
     fi
  fi

  # rootfs,
  # kernel/fdt
  # std kernel from multi-v7-ml,
  # sd card image e.g. core-image-minimal
  # for stm32mp157c-dk2, systemd

  if [ "$machine" == "stm32mp157c-dk2-systemd-wic-master" ]; then
     export TEMPLATECONF="../meta-u-boot-wic-bsp-master/template-stm32mp157c-dk2-systemd-master"
     echo "TEMPLATECONF: ${TEMPLATECONF}"
     echo "source ../sources/poky-master/oe-init-build-env ${machine}"
     source ../sources/poky-master/oe-init-build-env ${machine}
     # only copy site.conf if it's not already there
     if [ ! -f conf/site.conf ]; then
        #cp ${SITE_CONF} conf/site.conf
        # custom site.conf
        cp ../../sources/meta-u-boot-wic-bsp-master/template-stm32mp157c-dk2-systemd-master/site.conf conf/site.conf
        tree conf
     fi
  fi

  # rootfs,
  # kernel/fdt
  # std kernel from???
  # sd card image e.g. core-image-minimal
  # for the sargas board with phycore-stm32mp1-2, systemd

  if [ "$machine" == "sargas-phycore-stm32mp1-2-systemd-master" ]; then
     export TEMPLATECONF="../meta-phy-stm-resy-collection/meta-phy-bsp-stm-resy/template-sargas-phycore-stm32mp1-2-systemd-master/"
     echo "TEMPLATECONF: ${TEMPLATECONF}"
     echo "source ../sources/poky-master/oe-init-build-env ${machine}"
     source ../sources/poky-master/oe-init-build-env ${machine}
     # only copy site.conf if it's not already there
     if [ ! -f conf/site.conf ]; then
        #cp ${SITE_CONF} conf/site.conf
        # custom site.conf
        cp ../../sources/meta-phy-stm-resy-collection/meta-phy-bsp-stm-resy/template-sargas-phycore-stm32mp1-2-systemd-master/site.conf conf/site.conf
        tree conf
     fi
  fi

  # rootfs,
  # kernel/fdt
  # magic kernel from microsemi/aries
  # sd card image e.g. core-image-minimal
  # for the m100pfsevp with a polarfire soc, poky/systemd

  if [ "$machine" == "m100pfsevp-polarfire-poky" ]; then
     export TEMPLATECONF="../meta-polarfire-soc-yocto-bsp-addon/template-${machine}/"
     echo "TEMPLATECONF: ${TEMPLATECONF}"
     echo "source ../sources/meta-aries-polarfire-resy-collection/poky/oe-init-build-env ${machine}"
     source ../sources/meta-aries-polarfire-resy-collection/poky/oe-init-build-env ${machine}

     # only copy site.conf if it's not already there
     if [ ! -f conf/site.conf ]; then
        #cp ${SITE_CONF} conf/site.conf
        # custom site.conf
        cp ../../sources/meta-aries-polarfire-resy-collection/meta-polarfire-soc-yocto-bsp-addon/template-${machine}/site.conf conf/site.conf
        tree conf
     fi
  fi

  # rootfs,
  # kernel/fdt
  # magic kernel from microsemi/aries
  # sd card image e.g. core-image-minimal
  # for the m100pfsevp with a polarfire soc, poky-master/systemd

  if [ "$machine" == "m100pfsevp-polarfire-poky-master" ]; then
     export TEMPLATECONF="../meta-aries-polarfire-resy-collection/meta-polarfire-soc-yocto-bsp-addon/template-${machine}/"
     echo "TEMPLATECONF: ${TEMPLATECONF}"
     echo "source ../sources/poky-master/oe-init-build-env ${machine}"
     source ../sources/poky-master/oe-init-build-env ${machine}
     # only copy site.conf if it's not already there
     if [ ! -f conf/site.conf ]; then
        #cp ${SITE_CONF} conf/site.conf
        # custom site.conf
        cp ../../sources/meta-aries-polarfire-resy-collection/meta-polarfire-soc-yocto-bsp-addon/template-${machine}/site.conf conf/site.conf
        tree conf
     fi
  fi


  # rootfs,
  # kernel/fdt
  # magic kernel from microsemi/aries
  # sd card image e.g. core-image-minimal
  # for the m100pfsevp with a polarfire soc, resy/systemd

  if [ "$machine" == "m100pfsevp-polarfire-resy" ]; then
     export TEMPLATECONF="../meta-polarfire-soc-yocto-bsp-addon/template-${machine}/"
     echo "TEMPLATECONF: ${TEMPLATECONF}"
     echo "source ../sources/meta-aries-polarfire-resy-collection/poky/oe-init-build-env ${machine}"
     source ../sources/meta-aries-polarfire-resy-collection/poky/oe-init-build-env ${machine}

     # only copy site.conf if it's not already there
     if [ ! -f conf/site.conf ]; then
        #cp ${SITE_CONF} conf/site.conf
        # custom site.conf
        cp ../../sources/meta-aries-polarfire-resy-collection/meta-polarfire-soc-yocto-bsp-addon/template-${machine}/site.conf conf/site.conf
        tree conf
     fi
  fi


  # rootfs,
  # kernel/fdt
  # magic kernel from microsemi/aries
  # sd card image e.g. core-image-minimal
  # for the m100pfsevp with a polarfire soc, resy/systemd with poky master

  if [ "$machine" == "m100pfsevp-polarfire-resy-master" ]; then
     export TEMPLATECONF="../meta-aries-polarfire-resy-collection/meta-polarfire-soc-yocto-bsp-addon/template-${machine}/"
     echo "TEMPLATECONF: ${TEMPLATECONF}"
     echo "source ../sources/poky-master/oe-init-build-env ${machine}"
     source ../sources/poky-master/oe-init-build-env ${machine}
     # only copy site.conf if it's not already there
     if [ ! -f conf/site.conf ]; then
        #cp ${SITE_CONF} conf/site.conf
        # custom site.conf
        cp ../../sources/meta-aries-polarfire-resy-collection/meta-polarfire-soc-yocto-bsp-addon/template-${machine}/site.conf conf/site.conf
        tree conf
     fi
  fi


  # rootfs,
  # kernel/fdt
  # magic kernel from microsemi/aries
  # sd card image e.g. core-image-minimal
  # for the m100pfsevp with a polarfire soc, resy/systemd with poky master

  if [ "$machine" == "m100pfsevp-polarfire-resy-master-minimal" ]; then
     export TEMPLATECONF="../meta-aries-polarfire-resy-collection/meta-polarfire-soc-yocto-bsp-addon/template-${machine}/"
     echo "TEMPLATECONF: ${TEMPLATECONF}"
     echo "source ../sources/poky-master/oe-init-build-env ${machine}"
     source ../sources/poky-master/oe-init-build-env ${machine}
     # only copy site.conf if it's not already there
     if [ ! -f conf/site.conf ]; then
        #cp ${SITE_CONF} conf/site.conf
        # custom site.conf
        cp ../../sources/meta-aries-polarfire-resy-collection/meta-polarfire-soc-yocto-bsp-addon/template-${machine}/site.conf conf/site.conf
        tree conf
     fi
  fi

  # rootfs,
  # kernel/fdt
  # std kernel from multi-v7-ml,
  # sd card image e.g. core-image-minimal
  # for de0-nano-soc-kit

  if [ "$machine" == "de0-nano-soc-kit-wic-master" ]; then
     export TEMPLATECONF="../meta-u-boot-wic-bsp-master/template-de0-nano-soc-kit-master"
     echo "TEMPLATECONF: ${TEMPLATECONF}"
     echo "source ../sources/poky-master/oe-init-build-env ${machine}"
     source ../sources/poky-master/oe-init-build-env ${machine}
     # only copy site.conf if it's not already there
     if [ ! -f conf/site.conf ]; then
        #cp ${SITE_CONF} conf/site.conf
        # custom site.conf
        cp ../../sources/meta-u-boot-wic-bsp-master/template-de0-nano-soc-kit-master/site.conf conf/site.conf
        tree conf
     fi
  fi

  # rootfs,
  # kernel/fdt
  # std kernel from multi-v7-ml,
  # sd card image e.g. core-image-minimal
  # for stm32mp157c-dk2 with meta-stm32mp1

  #if [ "$machine" == "stm32mp157c-dk2-meta-stm32mp1-wic-master" ]; then
  #   export TEMPLATECONF="../meta-stm32mp157c-dk2-addon/template-meta-stm32mp1-master"
  #   echo "TEMPLATECONF: ${TEMPLATECONF}"
  #   echo "source ../sources/poky-master/oe-init-build-env ${machine}"
  #   source ../sources/poky-master/oe-init-build-env ${machine}
  #   # only copy site.conf if it's not already there
  #   if [ ! -f conf/site.conf ]; then
  #      #cp ${SITE_CONF} conf/site.conf
  #      # custom site.conf
  #      cp ../../sources/meta-stm32mp157c-dk2-addon/template-meta-stm32mp1-master/site.conf conf/site.conf
  #      tree conf
  #   fi
  #fi

  # rootfs,
  # kernel/fdt 
  # std kernel from multi-v7-ml, 
  # sd card image e.g. core-image-minimal
  # for beagle-bone-green

  if [ "$machine" == "beagle-bone-green-wic" ]; then
     export TEMPLATECONF="../meta-u-boot-wic-bsp/template-beagle-bone-green"
     echo "TEMPLATECONF: ${TEMPLATECONF}"
     echo "source ../sources/poky/oe-init-build-env ${machine}"
     source ../sources/poky/oe-init-build-env ${machine}
     # only copy site.conf if it's not already there
     if [ ! -f conf/site.conf ]; then
        cp ${SITE_CONF} conf/site.conf
        tree conf
     fi
  fi

  # rootfs,
  # kernel/fdt
  # std kernel from multi-v7-ml,
  # sd card image e.g. core-image-minimal
  # for beagle-bone-green

  if [ "$machine" == "beagle-bone-green-wic-master" ]; then
     export TEMPLATECONF="../meta-u-boot-wic-bsp-master/template-beagle-bone-green-master"
     echo "TEMPLATECONF: ${TEMPLATECONF}"
     echo "source ../sources/poky-master/oe-init-build-env ${machine}"
     source ../sources/poky-master/oe-init-build-env ${machine}
     # only copy site.conf if it's not already there
     if [ ! -f conf/site.conf ]; then
        #cp ${SITE_CONF} conf/site.conf
        # custom site.conf
        cp ../../sources/meta-u-boot-wic-bsp-master/template-beagle-bone-green-master/site.conf conf/site.conf
        tree conf
     fi
  fi

  # rootfs,
  # kernel/fdt
  # std kernel from multi-v7-ml,
  # sd card image e.g. core-image-minimal
  # for regor

  if [ "$machine" == "am335x-regor-rdk-wic-master" ]; then
     export TEMPLATECONF="../meta-u-boot-wic-bsp-master/template-am335x-regor-rdk-master"
     echo "TEMPLATECONF: ${TEMPLATECONF}"
     echo "source ../sources/poky-master/oe-init-build-env ${machine}"
     source ../sources/poky-master/oe-init-build-env ${machine}
     # only copy site.conf if it's not already there
     if [ ! -f conf/site.conf ]; then
        #cp ${SITE_CONF} conf/site.conf
        # custom site.conf
        cp ../../sources/meta-u-boot-wic-bsp-master/template-am335x-regor-rdk-master/site.conf conf/site.conf
        tree conf
     fi
  fi

  # rootfs, 
  # kernel/fdt
  # std kernel from multi-v7-ml, 
  # sd card image e.g. core-image-minimal
  # for am335x-phytec-wega

  if [ "$machine" == "am335x-phytec-wega-wic" ]; then
     export TEMPLATECONF="../meta-u-boot-wic-bsp/template-am335x-phytec-wega"
     echo "TEMPLATECONF: ${TEMPLATECONF}"
     echo "source ../sources/poky/oe-init-build-env ${machine}"
     source ../sources/poky/oe-init-build-env ${machine}
     # only copy site.conf if it's not already there
     if [ ! -f conf/site.conf ]; then
        cp ${SITE_CONF} conf/site.conf
        tree conf
     fi
  fi


  # rootfs,
  # kernel/fdt
  # std kernel from multi-v7-ml,
  # sd card image e.g. core-image-minimal
  # for am335x-phytec-wega

  if [ "$machine" == "am335x-phytec-wega-wic-master" ]; then
     export TEMPLATECONF="../meta-u-boot-wic-bsp-master/template-am335x-phytec-wega-master"
     echo "TEMPLATECONF: ${TEMPLATECONF}"
     echo "source ../sources/poky-master/oe-init-build-env ${machine}"
     source ../sources/poky-master/oe-init-build-env ${machine}
     # only copy site.conf if it's not already there
     if [ ! -f conf/site.conf ]; then
        #cp ${SITE_CONF} conf/site.conf
        # custom site.conf
        cp ../../sources/meta-u-boot-wic-bsp-master/template-am335x-phytec-wega-master/site.conf conf/site.conf
        tree conf
     fi
  fi


  # mender sd card image

  if [ "$machine" == "am335x-phytec-wega-mender" ]; then
     export TEMPLATECONF="../meta-u-boot-mender-bsp/template-am335x-phytec-wega"
     echo "TEMPLATECONF: ${TEMPLATECONF}"
     echo "source ../sources/poky/oe-init-build-env ${machine}"
     source ../sources/poky/oe-init-build-env ${machine}
     # only copy site.conf if it's not already there
     if [ ! -f conf/site.conf ]; then
        cp ${SITE_CONF} conf/site.conf
        tree conf
     fi
  fi

  # kernel/fdt
  # std kernel from multi-v7-ml,
  # sd card image e.g. core-image-minimal
  # for imx6ul-phytec-segin

  if [ "$machine" == "imx6ul-phytec-segin-wic-master" ]; then
     export TEMPLATECONF="../meta-u-boot-wic-bsp-master/template-imx6ul-phytec-segin-master"
     echo "TEMPLATECONF: ${TEMPLATECONF}"
     echo "source ../sources/poky-master/oe-init-build-env ${machine}"
     source ../sources/poky-master/oe-init-build-env ${machine}
     # only copy site.conf if it's not already there
     if [ ! -f conf/site.conf ]; then
        #cp ${SITE_CONF} conf/site.conf
        # custom site.conf
        cp ../../sources/meta-u-boot-wic-bsp-master/template-imx6ul-phytec-segin-master/site.conf conf/site.conf
        tree conf
     fi
  fi

  # kernel/fdt
  # std kernel from multi-v7-ml,
  # sd card image e.g. core-image-minimal
  # for imx6ul-phytec-segin

  if [ "$machine" == "imx6ul-phytec-segin-systemd-wic-master" ]; then
     export TEMPLATECONF="../meta-u-boot-wic-bsp-master/template-imx6ul-phytec-segin-systemd-master"
     echo "TEMPLATECONF: ${TEMPLATECONF}"
     echo "source ../sources/poky-master/oe-init-build-env ${machine}"
     source ../sources/poky-master/oe-init-build-env ${machine}
     # only copy site.conf if it's not already there
     if [ ! -f conf/site.conf ]; then
        #cp ${SITE_CONF} conf/site.conf
        # custom site.conf
        cp ../../sources/meta-u-boot-wic-bsp-master/template-imx6ul-phytec-segin-systemd-master/site.conf conf/site.conf
        tree conf
     fi
  fi


  # rootfs,
  # kernel/fdt
  # virt kernel from multi-v7-ml, systemd, docker, telegraf
  # sd card image e.g. core-image-minimal
  # for imx6ul-phytec-segin

  if [ "$machine" == "imx6ul-phytec-segin-virt-telegraf-wic-master" ]; then
     export TEMPLATECONF="../meta-u-boot-wic-bsp-master/template-imx6ul-phytec-segin-virt-telegraf-master"
     echo "TEMPLATECONF: ${TEMPLATECONF}"
     echo "source ../sources/poky-master/oe-init-build-env ${machine}"
     source ../sources/poky-master/oe-init-build-env ${machine}
     # only copy site.conf if it's not already there
     if [ ! -f conf/site.conf ]; then
        #cp ${SITE_CONF} conf/site.conf
        # custom site.conf
        cp ../../sources/meta-u-boot-wic-bsp-master/template-imx6ul-phytec-segin-virt-telegraf-master/site.conf conf/site.conf
        tree conf
     fi
  fi

  # rootfs,
  # kernel/fdt
  # virt kernel from multi-v7-ml, systemd, docker, telegraf
  # sd card image e.g. core-image-minimal
  # for de0-nano-soc-kit

  if [ "$machine" == "de0-nano-soc-kit-virt-telegraf-wic-master" ]; then
     export TEMPLATECONF="../meta-u-boot-wic-bsp-master/template-de0-nano-soc-kit-virt-telegraf-master"
     echo "TEMPLATECONF: ${TEMPLATECONF}"
     echo "source ../sources/poky-master/oe-init-build-env ${machine}"
     source ../sources/poky-master/oe-init-build-env ${machine}
     # only copy site.conf if it's not already there
     if [ ! -f conf/site.conf ]; then
        #cp ${SITE_CONF} conf/site.conf
        # custom site.conf
        cp ../../sources/meta-u-boot-wic-bsp-master/template-de0-nano-soc-kit-virt-telegraf-master/site.conf conf/site.conf
        tree conf
     fi
  fi

  # rootfs,
  # kernel/fdt
  # virt kernel from multi-v7-ml, systemd, docker, telegraf
  # sd card image e.g. core-image-minimal
  # for imx6q-phytec-mira-rdk-nand

  if [ "$machine" == "imx6q-phytec-mira-rdk-nand-virt-telegraf-wic-master" ]; then
     export TEMPLATECONF="../meta-u-boot-wic-bsp-master/template-imx6q-phytec-mira-rdk-nand-virt-telegraf-master"
     echo "TEMPLATECONF: ${TEMPLATECONF}"
     echo "source ../sources/poky-master/oe-init-build-env ${machine}"
     source ../sources/poky-master/oe-init-build-env ${machine}
     # only copy site.conf if it's not already there
     if [ ! -f conf/site.conf ]; then
        #cp ${SITE_CONF} conf/site.conf
        # custom site.conf
        cp ../../sources/meta-u-boot-wic-bsp-master/template-imx6q-phytec-mira-rdk-nand-virt-telegraf-master/site.conf conf/site.conf
        tree conf
     fi
  fi

  # rootfs,
  # kernel/fdt
  # virt kernel from multi-v7-ml, systemd, docker, telegraf
  # sd card image e.g. core-image-minimal
  # for imx6q-phytec-mira-rdk-nand - full metal update?

#  if [ "$machine" == "imx6q-phytec-mira-rdk-nand-virt-fmu-wic-master" ]; then
#     export TEMPLATECONF="../meta-u-boot-wic-bsp-master/template-imx6q-phytec-mira-rdk-nand-virt-fmu-master"
#     echo "TEMPLATECONF: ${TEMPLATECONF}"
#     echo "source ../sources/poky-master/oe-init-build-env ${machine}"
#     source ../sources/poky-master/oe-init-build-env ${machine}
#     # only copy site.conf if it's not already there
#     if [ ! -f conf/site.conf ]; then
#        #cp ${SITE_CONF} conf/site.conf
#        # custom site.conf
#        cp ../../sources/meta-u-boot-wic-bsp-master/template-imx6q-phytec-mira-rdk-nand-virt-fmu-master/site.conf conf/site.conf
#        tree conf
#     fi
#  fi

  # rootfs,
  # kernel/fdt
  # std kernel from multi-v7-ml,
  # sd card image e.g. core-image-minimal
  # for imx6sx-udoo-neo-full

  if [ "$machine" == "imx6sx-udoo-neo-full-wic-master" ]; then
     export TEMPLATECONF="../meta-u-boot-wic-bsp-master/template-imx6sx-udoo-neo-full-master"
     echo "TEMPLATECONF: ${TEMPLATECONF}"
     echo "source ../sources/poky-master/oe-init-build-env ${machine}"
     source ../sources/poky-master/oe-init-build-env ${machine}
     # only copy site.conf if it's not already there
     if [ ! -f conf/site.conf ]; then
        #cp ${SITE_CONF} conf/site.conf
        # custom site.conf
        cp ../../sources/meta-u-boot-wic-bsp-master/template-imx6sx-udoo-neo-full-master/site.conf conf/site.conf
        tree conf
     fi
  fi

  # rootfs, std kernel 4.14.x - patched for karo-imx6ul-txul, sd card image e.g. core-image-minimal
  # artefacts kernel/fdt over tftp and rootfs over nfs are also available
  # potentially we could build u-boot only, since u-boot resides on NAND flash
  # and use karo-imx6ul-txul for development
  # broken/deprecated at the moment???

  #if [ "$machine" == "karo-imx6ul-txul-uboot-wic" ]; then
  #   export TEMPLATECONF="../meta-u-boot-karo-wic-bsp/template-karo-imx6ul-txul"
  #   echo "TEMPLATECONF: ${TEMPLATECONF}"
  #   echo "source ../sources/poky/oe-init-build-env ${machine}"
  #   source ../sources/poky/oe-init-build-env ${machine}
  #   # only copy site.conf if it's not already there
  #   if [ ! -f conf/site.conf ]; then
  #      cp ${SITE_CONF} conf/site.conf
  #      tree conf
  #   fi
  #fi

  # rootfs, std kernel 4.14.x - patched for karo-imx6ul-txul, tftp/nfs image e.g. core-image-minimal
  # u-boot is not being built (mkimage is being built from poky)

  if [ "$machine" == "karo-imx6ul-txul" ]; then
     export TEMPLATECONF="../meta-karo-bsp/template-karo-imx6ul-txul"
     echo "TEMPLATECONF: ${TEMPLATECONF}"
     echo "source ../sources/poky/oe-init-build-env ${machine}"
     source ../sources/poky/oe-init-build-env ${machine}
     # only copy site.conf if it's not already there
     if [ ! -f conf/site.conf ]; then
        cp ${SITE_CONF} conf/site.conf
        tree conf
     fi
  fi

popd # from /workdir
fi

echo "--> \$#: $#"

# needed for killall_bitbake.sh
export BUILDDIR="/workdir/build/${machine}"

# --> interactive mode
if [ "$#" -eq "1" ]; then
# we pass the MACHINE, but not what to bake
  if [ "$BUILD_ALL" == "yes" ]; then
  # we want to build all images defined here above
     echo "BUILD_ALL = yes"
     # here we switch to the array contents
     set ${MYMAP["${1}"]}
       for var in "$@"
       do
        /workdir/killall_bitbake.sh
        if [[ $WORKSPACE = *jenkins* ]]; then
           #echo "+ (1) bitbake $var ;[ $? -ne 0 ] && echo "ERRORS foound" && exit 1"
           echo "+ (1) bitbake $var"
           bitbake $var ;[ $? -ne 0 ] && printf "\e[31m+ bitbake $var ERRORS found (1)\e[0m\n" && exit 1
        else
           echo "+ (1) bitbake $var"
           bitbake $var
        fi
       done
  else # BUILD_ALL != yes
     /workdir/killall_bitbake.sh
     echo "to ./resy-poky-container.sh:"
     echo " -- non-interactive mode -- "
     echo " add the image you want to build to the command line ./resy-poky-container.sh <MACHINE> <image>"
     echo " -- interactive mode --"
     echo "   enter it with - ./resy-poky-container.sh <no param> "
     echo "   bitbake <image>"
     echo "   source /workdir/resy-cooker.sh <MACHINE>"
  fi # BUILD_ALL =  yes
fi # only machine passed along
# <-- interactive mode

if [ "$#" -eq "2" ]; then
   /workdir/killall_bitbake.sh
   if [[ $WORKSPACE = *jenkins* ]]; then
      #echo "+ (2) bitbake $2 ;[ $? -ne 0 ] && echo "ERRORS foound" && exit 1"
      echo "+ (2) bitbake $2"
      #bitbake $2 ;[ $? -ne 0 ] && echo "ERRORS found" && exit 1
      bitbake $2 ;[ $? -ne 0 ] && printf "\e[31m+ bitbake $2 ERRORS found (2)\e[0m\n" && exit 1
   else
      echo "+ (2) bitbake $2"
      bitbake $2
      # WORKSPACE can be empty although we run from jenkins here
      if [ $? -ne 0 ]; then
         #echo "WORKSPACE: $WORKSPACE"
         printf "\e[31m+ bitbake $2 ERRORS found (2) WORKSPACE: $WORKSPACE - empty\e[0m\n"
         exit 1
      fi
   fi
fi

if [ "$#" -gt "2" ]; then
# we assume we came here from something like
# ./resy-poky-container.sh multi-v7-ml 'core-image-sato-sdk -c populate_sdk'
  FIRST_ARG="$1"
  shift
  REST_ARGS="$@"

  /workdir/killall_bitbake.sh
  if [[ $WORKSPACE = *jenkins* ]]; then
     #echo "+ (3) bitbake $@ ;[ $? -ne 0 ] && echo "ERRORS foound" && exit 1"
     echo "+ (3) bitbake $@"
     #bitbake $@ ;[ $? -ne 0 ] && echo "ERRORS foound" && exit 1
     bitbake $@ ;[ $? -ne 0 ] && printf "\e[31m+ bitbake $@ ERRORS found (3)\e[0m\n" && exit 1
  else
     echo "+ (3) bitbake $@"
     bitbake $@
  fi
fi
