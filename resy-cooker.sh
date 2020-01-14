#!/bin/bash

# only if this script is sourced it will be able to bitbake

if [[ $_ == $0 ]]; then
   echo "you need to source me:"
   echo "source $(basename ${0})"
   exit
fi

HERE=$(pwd)

if [ ! -d build ]; then
   mkdir build
fi

cd build

# choose machine  to init 

  select machine in 'container-x86-64' 'container-arm-v7' \
                    'multi-v7-ml' 'multi-v7-ml-debug' 'multi-v7-ml-virt' 'multi-v7-ml-debug-training' \
                    'multi-v7-mender' \
                    'imx6q-phytec-mira-rdk-nand-wic' 'imx6q-phytec-mira-rdk-nand-mender' \
                    'imx6q-phytec-mira-rdk-nand-virt-wic' 'imx6q-phytec-mira-rdk-nand-virt-mender' \
                    'beagle-bone-black-wic' 'beagle-bone-black-mender' \
                    'am335x-phytec-wega-wic' 'am335x-phytec-wega-mender' \
                    'karo-imx6ul-txul' 'karo-imx6ul-txul-uboot-wic'
  do
    echo "MACHINE or MACHINE-sw-variant: $machine"
    break;
  done

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
     mv -f ../sources/poky/${TEMPLATECONF}/local.conf.sample  ../sources/poky/${TEMPLATECONF}/local.conf.sample.ori
     cat ../sources/poky/${TEMPLATECONF}/local.conf.sample.ori  ../sources/meta-resy/template-common/sca.conf.sample > ../sources/poky/${TEMPLATECONF}/local.conf.sample
     cat ../sources/poky/${TEMPLATECONF}/local.conf.sample
     # <-- let's try to merge in sca stuff
     echo "source ../sources/poky/oe-init-build-env ${machine}"
     source ../sources/poky/oe-init-build-env ${machine}
     # only copy site.conf if it's not already there
     if [ ! -f conf/site.conf ]; then
        cp ${SITE_CONF} conf/site.conf
        # let's restore the original without sca
        mv -f ../../sources/poky/${TEMPLATECONF}/local.conf.sample.ori ../../sources/poky/${TEMPLATECONF}/local.conf.sample
        tree conf
     fi
  fi

  if [ "$machine" == "imx6q-phytec-mira-rdk-nand-virt-mender" ]; then
     export TEMPLATECONF="../meta-u-boot-mender-bsp/template-imx6q-phytec-mira-rdk-nand-virt"
     echo "TEMPLATECONF: ${TEMPLATECONF}"
     # --> let's try to merge in sca stuff 
     mv -f ../sources/poky/${TEMPLATECONF}/local.conf.sample  ../sources/poky/${TEMPLATECONF}/local.conf.sample.ori
     cat ../sources/poky/${TEMPLATECONF}/local.conf.sample.ori  ../sources/meta-resy/template-common/sca.conf.sample > ../sources/poky/${TEMPLATECONF}/local.conf.sample
     cat ../sources/poky/${TEMPLATECONF}/local.conf.sample
     # <-- let's try to merge in sca stuff
     echo "source ../sources/poky/oe-init-build-env ${machine}"
     source ../sources/poky/oe-init-build-env ${machine}
     # only copy site.conf if it's not already there
     if [ ! -f conf/site.conf ]; then
        cp ${SITE_CONF} conf/site.conf
        # let's restore the original without sca
        mv -f ../../sources/poky/${TEMPLATECONF}/local.conf.sample.ori ../../sources/poky/${TEMPLATECONF}/local.conf.sample
        tree conf
     fi
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
  # potentially we could build u-boot only, since u-boot resideson NAND flash
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

