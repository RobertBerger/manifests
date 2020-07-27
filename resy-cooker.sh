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

# --> container-x86-64-java
MYMAP[container-x86-64-java]="app-container-image-java"
# <-- container-x86-64-java

# --> container-x86-64-tensorflow
MYMAP[container-x86-64-tensorflow]="app-container-image-tensorflow"
# <-- container-x86-64-tensorflow

# --> container-x86-64-golang
MYMAP[container-x86-64-golang]="app-container-image-go"
# <-- container-x86-64-golang

# --> container-x86-64-tig
MYMAP[container-x86-64-tig]="image-influxdb-prebuilt image-influxdb-from-source app-container-image-influxdb-prebuilt app-container-image-influxdb-prebuilt-oci"
# <-- container-x86-64-tig

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

# --> multi-v7-ml-debug-training-libs
# jenkins:
# HERE=$(pwd)
# cd /workdir
# ./resy-poky-container.sh multi-v7-ml-debug-training-libs core-image-minimal
# pwd
# cd ${HERE}
MYMAP[multi-v7-ml-debug-training-libs]="core-image-minimal"
# <-- multi-v7-ml-debug-training-libs

# --> multi-v7-ml-debug-training-pkgs
# jenkins:
# HERE=$(pwd)
# cd /workdir
# ./resy-poky-container.sh multi-v7-ml-debug-training-pkgs core-image-minimal
# pwd
# cd ${HERE}
MYMAP[multi-v7-ml-debug-training-pkgs]="core-image-minimal"
# <-- multi-v7-ml-debug-training-pkgs

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

# --> imx6q-phytec-mira-rdk-nand-virt-wic-mc
# jenkins:
# HERE=$(pwd)
# cd /workdir
# ./resy-poky-container.sh imx6q-phytec-mira-rdk-nand-virt-wic-mc mc:imx6q-phytec-mira-rdk-nand-resy-virt:core-image-minimal-virt-docker-ce-mc
# pwd
# cd ${HERE}
MYMAP[imx6q-phytec-mira-rdk-nand-virt-wic-mc]="mc:imx6q-phytec-mira-rdk-nand-resy-virt:core-image-minimal-virt-docker-ce-mc"
# <-- imx6q-phytec-mira-rdk-nand-virt-wic-mc

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

# --> beagle-bone-black-wic
# jenkins:
# HERE=$(pwd)
# cd /workdir
# ./resy-poky-container.sh beagle-bone-black-wic core-image-minimal
# pwd
# cd ${HERE}
MYMAP[beagle-bone-black-wic]="core-image-minimal"
# <-- beagle-bone-black-wic

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

# --> am335x-phytec-wega-mender
# jenkins:
# HERE=$(pwd)
# cd /workdir
# ./resy-poky-container.sh am335x-phytec-wega-mender core-image-minimal
# pwd
# cd ${HERE}
MYMAP[am335x-phytec-wega-mender]="core-image-minimal"
# <-- am335x-phytec-wega-mender

# --> karo-imx6ul-txul
# jenkins:
# HERE=$(pwd)
# cd /workdir
# ./resy-poky-container.sh karo-imx6ul-txul core-image-minimal
# pwd
# cd ${HERE}
MYMAP[karo-imx6ul-txul]="core-image-minimal"
# <-- karo-imx6ul-txul

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
     usage 
     #exit 0
fi
# <-- usage


if [ ! ${MYMAP[${1}]+_} ]; then
  echo "--> $1 not found <--" 
  usage
  #exit 0
fi

# choose machine  to init 

#  select machine in 'container-x86-64' 'container-arm-v7' \
#                    'multi-v7-ml' 'multi-v7-ml-debug' 'multi-v7-ml-virt' \
#                    'multi-v7-ml-debug-training' 'multi-v7-ml-debug-training-libs' \
#                    'multi-v7-ml-debug-training-pkgs' 'multi-v7-ml-debug-training-lic' \
#                    'multi-v7-mender' \
#                    'imx6q-phytec-mira-rdk-nand-wic' 'imx6q-phytec-mira-rdk-nand-mender' \
#                    'imx6q-phytec-mira-rdk-nand-virt-wic' 'imx6q-phytec-mira-rdk-nand-virt-mender' \
#                    'beagle-bone-black-wic' 'beagle-bone-black-mender' \
#                    'am335x-phytec-wega-wic' 'am335x-phytec-wega-mender' \
#                    'karo-imx6ul-txul' 'karo-imx6ul-txul-uboot-wic'
#  do
#    echo "MACHINE or MACHINE-sw-variant: $machine"
#    break;
#  done


if [ "$#" -gt "0" ]; then
# here we have a MACHINE or MACHINE-sw-variant defined

machine="$1"
echo "MACHINE or MACHINE-sw-variant: $machine"

if [ ! ${MYMAP[${1}]+_} ]; then
  echo "--> $1 not found <--" 
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
 
  echo "SITE_CONF=${SITE_CONF}"

  # x86-64 container e.g. for Python development and testing

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

  # rootfs, std kernel 4.14.x - patched for karo-imx6ul-txul, sd card image e.g. core-image-minimal
  # artefacts kernel/fdt over tftp and rootfs over nfs are also available
  # potentially we could build u-boot only, since u-boot resides on NAND flash
  # and use karo-imx6ul-txul for development

  if [ "$machine" == "karo-imx6ul-txul-uboot-wic" ]; then
     export TEMPLATECONF="../meta-u-boot-karo-wic-bsp/template-karo-imx6ul-txul"
     echo "TEMPLATECONF: ${TEMPLATECONF}"
     echo "source ../sources/poky/oe-init-build-env ${machine}"
     source ../sources/poky/oe-init-build-env ${machine}
     # only copy site.conf if it's not already there
     if [ ! -f conf/site.conf ]; then
        cp ${SITE_CONF} conf/site.conf
        tree conf
     fi
  fi

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
