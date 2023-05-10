#!/bin/bash

SOURCES="/workdir/sources"
PHY_STM_RESY_COLLECTION="/workdir/sources/meta-phy-stm-resy-collection"
ARIES_POLARFIRE_RESY_COLLECTION="/workdir/sources/meta-aries-polarfire-resy-collection"
RASPBERRYPI_RESY_COLLECTION_BOSC="/workdir/sources/meta-raspberrypi-resy-collection-bosc"
SCRIPTS="/workdir/scripts"
JENKINS="/workdir/jenkins"
FOSSOLOGY="/workdir/fossology"
BITBAKE="/workdir/bitbake"
OCI_CONTAINER_X86_64="/workdir/oci-container-x86-64"
APP_CONTAINER_X86_64="/workdir/app-container-x86-64"
APP_CONTAINER_ARM_V7="/workdir/app-container-arm-v7"
APP_CONTAINER_AARCH64="/workdir/app-container-aarch64"
APP_CONTAINER_MULTI_ARCH="/workdir/app-container-multi-arch"
CROPS_CONTAINER_X86_64="/workdir/crops-container-x86-64"
GITHUB="https://github.com"
GITLAB="https://gitlab.com"
GIT_YP="git://git.yoctoproject.org"
GIT_OE="git://git.openembedded.org"

echo "This script will kill everything"
echo "and grab everything from scratch"

if [[ $WORKSPACE = *jenkins* ]]; then
  echo "WORKSPACE '$WORKSPACE' contains jenkins"
  echo "would normally wait here, but now I just go on"
else
  read -r -p "Are you sure? [y/N] " response
  case "$response" in
      [yY][eE][sS]|[yY]) 
          echo "killing!"

	  set -x
	  rm -rf .repo
          rm -rf sources
          rm -rf scripts
          sudo rm -rf build
          rm -rf app-container-arm-v7
          rm -rf app-container-multi-arch
          rm -rf app-container-x86-64
          rm -rf app-container-aarch64
          rm -rf crops-container-x86-64
          rm -rf oci-container-x86-64
          rm -rf jenkins
          rm -rf fossology
          rm -rf bitbake
          ls /workdir
          set +x
          if [[ $WORKSPACE = *jenkins* ]]; then
             echo "WORKSPACE '$WORKSPACE' contains jenkins"
             echo "would normally wait here, but now I just go on"
          else
             echo "press <ENTER> to go on"
             read r
          fi
          ;;
      *)
          #exit
          echo "not killing!"
          ;;
  esac
fi

# choose manifest

if [[ $WORKSPACE = *jenkins* ]]; then
  echo "WORKSPACE '$WORKSPACE' contains jenkins"
  echo "we would choose stable/[experimental] here"
  echo "we choose bleeding"
  export manifest="bleeding"
else
  echo "use bleeding for now"
  select manifest in 'stable' 'experimental'
  do
    echo "MANIFEST: $manifest"
    break;
  done
fi

  # experimental: master as langdale
  if [ "$manifest" == "experimental" ]; then
     export BRANCH_GENERIC="langdale"
     export META_RESY_BRANCH="${BRANCH_GENERIC}"
     export META_POKY_BRANCH="2022-12-28-master-as-${BRANCH_GENERIC}"
     export META_POKY_TRAINING_BRANCH="2022-12-28-master-as-${BRANCH_GENERIC}"
     export META_MULTI_V7_ML_BSP_BRANCH="${BRANCH_GENERIC}"
     export META_U_BOOT_WIC_BSP_BRANCH="${BRANCH_GENERIC}"
     export META_OPENEMBEDDED_BRANCH="2022-12-28-master-as-${BRANCH_GENERIC}"

     # did above for u-boot-wic-bsp, poky-training and friends on master-as-langdale
     # below nothing is tested - needs to be fixed as needed

     export META_VIRTUALIZATION_BRANCH="2021-05-10-master-as-hardknott-3.3"
     export META_DESIRE_BRANCH="master"
     
     # u-boot-mender only dummy here - needs fixing
     export META_U_BOOT_MENDER_BSP_BRANCH="master"
     export META_SCA_BRANCH="2021-05-10-master-as-hardknott"
     export META_JAVA_BRANCH="2021-05-10-master-as-hardknott"
     export META_TENSORFLOW_BRANCH="2021-05-10-master-as-hardknott"
     export MANIFESTS_BRANCH="master"

     ######## --> those need fixing
     export META_XENOMAI_BRANCH="xeno-3.1-4.19.128-gatesgarth"
     export META_PRT_BRANCH="gatesgarth"

     # u-boot-karo-wic-bsp only dummy here - needs fixing
     export META_U_BOOT_KARO_WIC_BSP_BRANCH="master"
     # meta-karo-bsp only dummy here - needs fixing
     export META_KARO_BSP_BRANCH="dunfell-5.4.x"

     export META_BFE_BRANCH="gatesgarth"

     # meta-mender only dummy here - needs fixing
     export META_MENDER_BRANCH="2020-06-05-thud-as-dunfell"

     export META_RASPBERRYPI_BRANCH="dunfell"
     export META_RASPBERRYPI_ML_BSP_BRANCH="dunfell"
     export META_FREESCALE_BRANCH="2020-08-28-dunfell"
     export META_PHYBOARD_POLIS_IMX8MM_BSP_BRANCH="v5.10.x-upstream"
     export META_SYSTEMD_NFSROOT_BRANCH="master"
     export META_QT5_BRANCH="2020-09-08-dunfell"
     export META_QT5_EXAMPLES_BRANCH="dunfell"
     export META_PKG_BRANCH="master"
     ####### <-- those need fixing

     export SKOPEO_BRANCH="skopeo-v1.1.0"
     export TERRIER_BRANCH="2020-07-24"

     export JENKINS_BRANCH="2022-11-26-jenkins-2.361.4"
     export FOSSOLOGY_BRANCH="2021-01-04-fossology"

     # --> those need to be added below
     export META_BUILDUTILS_BRANCH="2021-05-10-master-as-hardknott"
     export META_CLANG_BRANCH="2021-05-10-master-as-hardknott"
     # <-- those need to be added below
  fi


  # stable: master as honister
  if [ "$manifest" == "stable" ]; then
     export BRANCH_GENERIC="honister"
     export META_RESY_BRANCH="${BRANCH_GENERIC}"
     export META_POKY_BRANCH="2022-01-15-master-as-honister-3.4.66+"
     export META_POKY_TRAINING_BRANCH="2022-01-15-master-as-honister-3.4.66+"
     export META_MULTI_V7_ML_BSP_BRANCH="${BRANCH_GENERIC}"
     export META_U_BOOT_WIC_BSP_BRANCH="${BRANCH_GENERIC}"
     export META_OPENEMBEDDED_BRANCH="2022-01-15-master-next-as-honister"

     # did above for u-boot-wic-bsp on honister

     export META_VIRTUALIZATION_BRANCH="2021-05-10-master-as-hardknott-3.3"
     export META_DESIRE_BRANCH="master"
     
     # u-boot-mender only dummy here - needs fixing
     export META_U_BOOT_MENDER_BSP_BRANCH="master"
     export META_SCA_BRANCH="2021-05-10-master-as-hardknott"
     export META_JAVA_BRANCH="2021-05-10-master-as-hardknott"
     export META_TENSORFLOW_BRANCH="2021-05-10-master-as-hardknott"
     export MANIFESTS_BRANCH="master"

     ######## --> those need fixing
     export META_XENOMAI_BRANCH="xeno-3.1-4.19.128-gatesgarth"
     export META_PRT_BRANCH="gatesgarth"

     # u-boot-karo-wic-bsp only dummy here - needs fixing
     export META_U_BOOT_KARO_WIC_BSP_BRANCH="master"
     # meta-karo-bsp only dummy here - needs fixing
     export META_KARO_BSP_BRANCH="dunfell-5.4.x"

     export META_BFE_BRANCH="gatesgarth"

     # meta-mender only dummy here - needs fixing
     export META_MENDER_BRANCH="2020-06-05-thud-as-dunfell"

     export META_RASPBERRYPI_BRANCH="dunfell"
     export META_RASPBERRYPI_ML_BSP_BRANCH="dunfell"
     export META_FREESCALE_BRANCH="2020-08-28-dunfell"
     export META_PHYBOARD_POLIS_IMX8MM_BSP_BRANCH="v5.10.x-upstream"
     export META_SYSTEMD_NFSROOT_BRANCH="master"
     export META_QT5_BRANCH="2020-09-08-dunfell"
     export META_QT5_EXAMPLES_BRANCH="dunfell"
     export META_PKG_BRANCH="master"
     ####### <-- those need fixing

     export SKOPEO_BRANCH="skopeo-v1.1.0"
     export TERRIER_BRANCH="2020-07-24"

     export JENKINS_BRANCH="2022-11-26-jenkins-2.361.4"
     export FOSSOLOGY_BRANCH="2021-01-04-fossology"

     # --> those need to be added below
     export META_BUILDUTILS_BRANCH="2021-05-10-master-as-hardknott"
     export META_CLANG_BRANCH="2021-05-10-master-as-hardknott"
     # <-- those need to be added below
  fi

  # master as hardknott (before override syntax change)
  if [ "$manifest" == "hardknott" ]; then
     export META_RESY_BRANCH="hardknott"
     export META_POKY_BRANCH="2021-05-10-master-as-hardknott-3.3.66"
     export META_POKY_TRAINING_BRANCH="2021-05-10-master-as-hardknott-3.3.66"
     export META_VIRTUALIZATION_BRANCH="2021-05-10-master-as-hardknott-3.3"
     export META_DESIRE_BRANCH="master"
     export META_MULTI_V7_ML_BSP_BRANCH="hardknott"
     export META_U_BOOT_WIC_BSP_BRANCH="hardknott"
     # u-boot-mender only dummy here - needs fixing
     export META_U_BOOT_MENDER_BSP_BRANCH="master"
     export META_SCA_BRANCH="2021-05-10-master-as-hardknott"
     export META_OPENEMBEDDED_BRANCH="2021-05-10-master-as-hardknott"
     export META_JAVA_BRANCH="2021-05-10-master-as-hardknott"
     export META_TENSORFLOW_BRANCH="2021-05-10-master-as-hardknott"
     export MANIFESTS_BRANCH="master"

     ######## --> those need fixing
     export META_XENOMAI_BRANCH="xeno-3.1-4.19.128-gatesgarth"
     export META_PRT_BRANCH="gatesgarth"

     # u-boot-karo-wic-bsp only dummy here - needs fixing
     export META_U_BOOT_KARO_WIC_BSP_BRANCH="master"
     # meta-karo-bsp only dummy here - needs fixing
     export META_KARO_BSP_BRANCH="dunfell-5.4.x"

     export META_BFE_BRANCH="gatesgarth"

     # meta-mender only dummy here - needs fixing
     export META_MENDER_BRANCH="2020-06-05-thud-as-dunfell"

     export META_RASPBERRYPI_BRANCH="dunfell"
     export META_RASPBERRYPI_ML_BSP_BRANCH="dunfell"
     export META_FREESCALE_BRANCH="2020-08-28-dunfell"
     export META_PHYBOARD_POLIS_IMX8MM_BSP_BRANCH="v5.10.x-upstream"
     export META_SYSTEMD_NFSROOT_BRANCH="master"
     export META_QT5_BRANCH="2020-09-08-dunfell"
     export META_QT5_EXAMPLES_BRANCH="dunfell"
     export META_PKG_BRANCH="master"
     ####### <-- those need fixing

     export SKOPEO_BRANCH="skopeo-v1.1.0"
     export TERRIER_BRANCH="2020-07-24"

     export JENKINS_BRANCH="2021-08-13-jenkins-2.289.3"
     export FOSSOLOGY_BRANCH="2021-01-04-fossology"

     # --> those need to be added below
     export META_BUILDUTILS_BRANCH="2021-05-10-master-as-hardknott"
     export META_CLANG_BRANCH="2021-05-10-master-as-hardknott"
     # <-- those need to be added below
  fi

  # stable: dunfell
  if [ "$manifest" == "dunfell" ]; then
     export META_RESY_BRANCH="dunfell"
     export META_POKY_BRANCH="2020-08-28-dunfell-3.1.2++"
     export META_POKY_TRAINING_BRANCH="2020-08-28-dunfell-3.1.2+"
     export META_VIRTUALIZATION_BRANCH="2020-04-30-dunfell-3.1"
     export META_DESIRE_BRANCH="master"
     export META_MULTI_V7_ML_BSP_BRANCH="dunfell"
     export META_U_BOOT_WIC_BSP_BRANCH="dunfell"
     export META_U_BOOT_MENDER_BSP_BRANCH="dunfell"
     export META_U_BOOT_KARO_WIC_BSP_BRANCH="dunfell"
     export META_KARO_BSP_BRANCH="dunfell-5.4.x"
     export META_SCA_BRANCH="2020-06-05-dunfell"
     export META_OPENEMBEDDED_BRANCH="2020-04-30-dunfell-3.1"
     export META_JAVA_BRANCH="2020-05-08-dunfell"
     export META_TENSORFLOW_BRANCH="2020-05-10-master-as-dunfell"
     export MANIFESTS_BRANCH="dunfell"
     export META_PYTHON2_BRANCH="dunfell"
     export META_MENDER_BRANCH="2020-06-05-thud-as-dunfell"
     export META_PYTHON2_BRANCH="dunfell"
     export META_BFE_BRANCH="dunfell"
     export META_XENOMAI_BRANCH="xeno-3.1-4.19.128"
     export META_PRT_BRANCH="dunfell"
     export SKOPEO_BRANCH="skopeo-v1.1.0"
     export TERRIER_BRANCH="2020-07-24"
     export META_RASPBERRYPI_BRANCH="dunfell"
     export META_RASPBERRYPI_ML_BSP_BRANCH="dunfell"
     export META_FREESCALE_BRANCH="2020-08-28-dunfell"
     export META_PHYBOARD_POLIS_IMX8MM_BSP_BRANCH="v5.10.x-upstream"
     export META_SYSTEMD_NFSROOT_BRANCH="dunfell"
     export META_QT5_BRANCH="2020-09-08-dunfell"
     export META_QT5_EXAMPLES_BRANCH="dunfell"
     export META_TENSORFLOW_MASTER_BRANCH="2020-10-27-master-as-gatesgarth"
     export META_PKG_BRANCH="master"
     export JENKINS_BRANCH="2021-05-07-jenkins-2.277.4"
     export FOSSOLOGY_BRANCH="2021-01-04-fossology"
  fi

declare -A MYMAP
MYMAP[convenience-scripts]="${GITLAB}/meta-layers/convenience-scripts.git ${SCRIPTS}/convenience-scripts master"
MYMAP[poky]="${GITHUB}/RobertBerger/poky ${SOURCES}/poky ${META_POKY_BRANCH}"
MYMAP[poky-master]="${GIT_YP}/poky ${SOURCES}/poky-master master ${SOURCES}/manifests/poky-master/patch.sh"
MYMAP[poky-training]="${GITHUB}/RobertBerger/poky ${SOURCES}/poky-training ${META_POKY_TRAINING_BRANCH}"
MYMAP[poky-training-master]="${GIT_YP}/poky ${SOURCES}/poky-training-master master ${SOURCES}/manifests/poky-training-master/patch.sh"
MYMAP[meta-zephyr-master]="${GIT_YP}/meta-zephyr ${SOURCES}/meta-zephyr-master master"

# my-mender-layer (encrypted)
MYMAP[my-mender-layer]="${GITHUB}/RobertBerger/my-mender-layer ${SOURCES}/my-mender-layer master"
#MYMAP[keys-for-signing]="${GITHUB}/RobertBerger/keys-for-signing ${SOURCES}/keys-for-signing master"
MYMAP[keys-for-ipk-signing]="${GITLAB}/robert.berger/keys-for-ipk-signing.git ${SOURCES}/keys-for-ipk-signing master"

# hashsrv-docker
MYMAP[bitbake]="${GITHUB}/RobertBerger/bitbake-containers ${BITBAKE} master"

# deprecated (hopefully)
#MYMAP[meta-python2]="${GITHUB}/RobertBerger/meta-python2 ${SOURCES}/meta-python2 ${META_PYTHON2_BRANCH}"
MYMAP[meta-virtualization]="${GITHUB}/RobertBerger/meta-virtualization ${SOURCES}/meta-virtualization ${META_VIRTUALIZATION_BRANCH}"
MYMAP[meta-virtualization-master]="${GIT_YP}/meta-virtualization ${SOURCES}/meta-virtualization-master master ${SOURCES}/manifests/meta-virtualization-master/patch.sh"
MYMAP[meta-wifi-credentials]="${GITHUB}/RobertBerger/meta-wifi-credentials ${SOURCES}/meta-wifi-credentials hardknott"
# my meta-u-boot-wic-bsp bsp u-boot is here
MYMAP[meta-u-boot-wic-bsp]="${GITLAB}/meta-layers/meta-u-boot-wic-bsp.git ${SOURCES}/meta-u-boot-wic-bsp ${META_U_BOOT_WIC_BSP_BRANCH}"
MYMAP[meta-u-boot-wic-bsp-master]="${GITLAB}/meta-layers/meta-u-boot-wic-bsp.git ${SOURCES}/meta-u-boot-wic-bsp-master master"
# my meta-u-boot-mender-bsp bsp u-boot is here
MYMAP[meta-u-boot-mender-bsp]="${GITLAB}/meta-layers/meta-u-boot-mender-bsp.git ${SOURCES}/meta-u-boot-mender-bsp ${META_U_BOOT_MENDER_BSP_BRANCH}"
# meta-u-boot-karo-wic-bsp: deprecated?
#MYMAP[meta-u-boot-karo-wic-bsp]="${GITLAB}/meta-layers/meta-u-boot-karo-wic-bsp.git ${SOURCES}/meta-u-boot-karo-wic-bsp ${META_U_BOOT_KARO_WIC_BSP_BRANCH}"
MYMAP[meta-sca]="${GITHUB}/RobertBerger/meta-sca ${SOURCES}/meta-sca ${META_SCA_BRANCH}"
MYMAP[meta-sca-master]="${GITHUB}/priv-kweihmann/meta-sca ${SOURCES}/meta-sca-master master"
MYMAP[meta-spdxscanner-master]="${GIT_YP}/meta-spdxscanner ${SOURCES}/meta-spdxscanner-master master"
# my resy distro 
MYMAP[resy]="${GITLAB}/meta-layers/meta-resy.git ${SOURCES}/meta-resy ${META_RESY_BRANCH}"
MYMAP[resy-master]="${GITLAB}/meta-layers/meta-resy.git ${SOURCES}/meta-resy-master master"
MYMAP[meta-conserver-master]="${GITLAB}/meta-layers/meta-conserver.git ${SOURCES}/meta-conserver-master master"
MYMAP[meta-openembedded]="${GITHUB}/RobertBerger/meta-openembedded ${SOURCES}/meta-openembedded ${META_OPENEMBEDDED_BRANCH}"
MYMAP[meta-openembedded-master]="${GIT_OE}/meta-openembedded ${SOURCES}/meta-openembedded-master master"
MYMAP[meta-multi-v7-ml-bsp]="${GITLAB}/meta-layers/meta-multi-v7-ml-bsp.git ${SOURCES}/meta-multi-v7-ml-bsp ${META_MULTI_V7_ML_BSP_BRANCH}"
MYMAP[meta-multi-v7-ml-bsp-master]="${GITLAB}/meta-layers/meta-multi-v7-ml-bsp.git ${SOURCES}/meta-multi-v7-ml-bsp-master master"
MYMAP[meta-multi-v7-ml-linux-yocto-custom-virt]="${GITLAB}/meta-layers/meta-multi-v7-ml-linux-yocto-custom-virt.git ${SOURCES}/meta-multi-v7-ml-linux-yocto-custom-virt ${BRANCH_GENERIC}"

MYMAP[meta-u-boot-wic-bsp-beagle-bone-black-conserver-master]="${GITLAB}/meta-layers/meta-u-boot-wic-bsp-beagle-bone-black-conserver.git ${SOURCES}/meta-u-boot-wic-bsp-beagle-bone-black-conserver-master master"

MYMAP[meta-systemd-nfsroot]="${GITLAB}/meta-layers/meta-systemd-nfsroot.git ${SOURCES}/meta-systemd-nfsroot ${META_SYSTEMD_NFSROOT_BRANCH}"

MYMAP[meta-java]="${GITHUB}/RobertBerger/meta-java ${SOURCES}/meta-java ${META_JAVA_BRANCH}"
MYMAP[meta-java-master]="${GIT_YP}/meta-java ${SOURCES}/meta-java-master master"
MYMAP[meta-java-examples]="${GITLAB}/meta-layers/meta-java-examples.git ${SOURCES}/meta-java-examples master"
MYMAP[meta-web-examples]="${GITLAB}/meta-layers/meta-web-examples.git ${SOURCES}/meta-web-examples master"
MYMAP[meta-rust-examples]="${GITLAB}/meta-layers/meta-rust-examples.git ${SOURCES}/meta-rust-examples master"

MYMAP[meta-tensorflow]="${GITHUB}/RobertBerger/meta-tensorflow ${SOURCES}/meta-tensorflow ${META_TENSORFLOW_BRANCH}"
#MYMAP[meta-tensorflow-master]="${GITHUB}/RobertBerger/meta-tensorflow ${SOURCES}/meta-tensorflow-master ${META_TENSORFLOW_MASTER_BRANCH}"
MYMAP[meta-tensorflow-master]="${GIT_YP}/meta-tensorflow ${SOURCES}/meta-tensorflow-master master"
MYMAP[meta-tensorflow-examples]="${GITLAB}/meta-layers/meta-tensorflow-examples.git ${SOURCES}/meta-tensorflow-examples master"
MYMAP[meta-tensorflow-examples-master]="${GITLAB}/meta-layers/meta-tensorflow-examples.git ${SOURCES}/meta-tensorflow-examples-master master"
MYMAP[meta-golang-examples]="${GITLAB}/meta-layers/meta-golang-examples.git ${SOURCES}/meta-golang-examples master"
MYMAP[gobyexample]="${GITHUB}/RobertBerger/gobyexample ${SOURCES}/gobyexample master"
MYMAP[meta-qt5]="${GITHUB}/RobertBerger/meta-qt5 ${SOURCES}/meta-qt5 ${META_QT5_BRANCH}"
MYMAP[meta-qt5-examples]="${GITLAB}/meta-layers/meta-qt5-examples.git ${SOURCES}/meta-qt5-examples ${META_QT5_EXAMPLES_BRANCH}"
MYMAP[meta-freescale]="${GITHUB}/RobertBerger/meta-freescale ${SOURCES}/meta-freescale ${META_FREESCALE_BRANCH}"
MYMAP[meta-freescale-master]="${GIT_YP}/meta-freescale ${SOURCES}/meta-freescale-master master"
MYMAP[meta-fsl-common-master]="${GITLAB}/meta-layers/meta-fsl-common.git ${SOURCES}/meta-fsl-common-master master"
MYMAP[meta-imx8mm-lpddr4-evk-ml-bsp-master]="${GITLAB}/meta-layers/meta-imx8mm-lpddr4-evk-ml-bsp.git ${SOURCES}/meta-imx8mm-lpddr4-evk-ml-bsp-master master"
MYMAP[meta-phyboard-polis-imx8mm-bsp]="${GITLAB}/meta-layers/meta-phyboard-polis-imx8mm-bsp ${SOURCES}/meta-phyboard-polis-imx8mm-bsp ${META_PHYBOARD_POLIS_IMX8MM_BSP_BRANCH}"

# let's remove the patch from here, since it does not cleanly apply:
#MYMAP[meta-xilinx-master]="${GIT_YP}/meta-xilinx ${SOURCES}/meta-xilinx-master master ${SOURCES}/manifests/meta-xilinx-master/patch.sh"
# patch removed for now, since it does not cleanly apply:
MYMAP[meta-xilinx-master]="${GIT_YP}/meta-xilinx ${SOURCES}/meta-xilinx-master master"
MYMAP[meta-xilinx-common-master]="${GITLAB}/meta-layers/meta-xilinx-common.git ${SOURCES}/meta-xilinx-common-master master"

MYMAP[meta-bb-syntax]="${GITLAB}/meta-layers/meta-bb-syntax ${SOURCES}/meta-bb-syntax master"

MYMAP[meta-clang]="${GITHUB}/RobertBerger/meta-clang ${SOURCES}/meta-clang ${META_CLANG_BRANCH}"
MYMAP[meta-clang-master]="${GITHUB}/kraj/meta-clang ${SOURCES}/meta-clang-master master"
MYMAP[meta-buildutils]="${GITHUB}/RobertBerger/meta-buildutils ${SOURCES}/meta-buildutils ${META_BUILDUTILS_BRANCH}"
MYMAP[meta-mender]="${GITHUB}/RobertBerger/meta-mender ${SOURCES}/meta-mender ${META_MENDER_BRANCH}"
MYMAP[meta-karo-bsp]="${GITLAB}/meta-layers/meta-karo-bsp.git ${SOURCES}/meta-karo-bsp ${META_KARO_BSP_BRANCH}"
MYMAP[meta-bfe]="${GITLAB}/meta-layers/meta-bfe.git ${SOURCES}/meta-bfe ${META_BFE_BRANCH}"
MYMAP[meta-tig]="${GITLAB}/meta-layers/meta-tig.git ${SOURCES}/meta-tig ${BRANCH_GENERIC}"
MYMAP[meta-tig-master]="${GITLAB}/meta-layers/meta-tig.git ${SOURCES}/meta-tig-master master"
MYMAP[meta-xenomai]="${GITLAB}/meta-layers/meta-xenomai.git ${SOURCES}/meta-xenomai ${META_XENOMAI_BRANCH}"
MYMAP[meta-prt]="${GITLAB}/meta-layers/meta-prt.git ${SOURCES}/meta-prt ${META_PRT_BRANCH}"

MYMAP[meta-raspberrypi]="${GITHUB}/RobertBerger/meta-raspberrypi ${SOURCES}/meta-raspberrypi ${META_RASPBERRYPI_BRANCH}"
MYMAP[meta-raspberrypi-master]="${GIT_YP}/meta-raspberrypi ${SOURCES}/meta-raspberrypi-master master"
MYMAP[meta-raspberrypi-addon-master]="${GITLAB}/meta-layers/meta-raspberrypi-addon.git ${SOURCES}/meta-raspberrypi-addon-master master"
MYMAP[meta-raspberrypi-common-master]="${GITLAB}/meta-layers/meta-raspberrypi-common.git ${SOURCES}/meta-raspberrypi-common-master master"
MYMAP[meta-raspberrypi-ml-bsp]="${GITLAB}/meta-layers/meta-raspberrypi-ml-bsp.git ${SOURCES}/meta-raspberrypi-ml-bsp ${META_RASPBERRYPI_ML_BSP_BRANCH}"
MYMAP[meta-raspberrypi-yocto-kernel]="${GITLAB}/meta-layers/meta-raspberrypi-yocto-kernel.git ${SOURCES}/meta-raspberrypi-yocto-kernel-master master"


MYMAP[meta-container-ex-compact-docker-only]="${GITLAB}/meta-layers/meta-container-ex-compact.git ${SOURCES}/meta-container-ex-compact-docker-only docker-only"
MYMAP[meta-container-ex-compact-oci]="${GITLAB}/meta-layers/meta-container-ex-compact.git ${SOURCES}/meta-container-ex-compact-oci oci"

MYMAP[meta-pkg]="${GITLAB}/meta-layers/meta-pkg.git ${SOURCES}/meta-pkg ${META_PKG_BRANCH}"
MYMAP[meta-lib]="${GITLAB}/meta-layers/meta-lib.git ${SOURCES}/meta-lib master"

# --> meta-phy-stm-resy-collection
MYMAP[meta-phy-bsp-stm-resy]="${GITLAB}/meta-layers/meta-phy-bsp-stm-resy.git ${PHY_STM_RESY_COLLECTION}/meta-phy-bsp-stm-resy master"
MYMAP[meta-phy-bsp-stm-resy-meta-phytec]="${GITHUB}/RobertBerger/meta-phytec ${PHY_STM_RESY_COLLECTION}/meta-phytec 2021-06-09-pd21.1.0-stm-dunfell-as-hardknott"
MYMAP[meta-phy-bsp-stm-resy-meta-st-stm32mp]="${GITHUB}/RobertBerger/meta-st-stm32mp ${PHY_STM_RESY_COLLECTION}/meta-st-stm32mp 2021-06-09-pd21.1.0-subset-dunfell-as-hardknott"
# <-- meta-phy-stm-resy-collection

# --> meta-aries-polarfire-resy-collection
# upstream
MYMAP[meta-riscv]="${GITHUB}/RobertBerger/meta-riscv ${ARIES_POLARFIRE_RESY_COLLECTION}/meta-riscv 2021-06-25-hardknott"
MYMAP[poky-meta-aries-polarfire-resy-collection]="${GITHUB}/RobertBerger/poky ${ARIES_POLARFIRE_RESY_COLLECTION}/poky 2021-06-25-hardknott"

# upstream hacked
# aries hacked and res hacked on aires-res branch:
MYMAP[meta-polarfire-soc-yocto-bsp-aries]="${GITHUB}/RobertBerger/meta-polarfire-soc-yocto-bsp-aries ${ARIES_POLARFIRE_RESY_COLLECTION}/meta-polarfire-soc-yocto-bsp-aries 2021-06-25-hardknott-aries-res"

# res
# in order to work with yocto we need this u-boot version, which is originally in oe-core:
# we can also add the templateconf here:
MYMAP[meta-polarfire-soc-yocto-bsp-addon]="${GITLAB}/meta-layers/meta-polarfire-soc-yocto-bsp-addon.git ${ARIES_POLARFIRE_RESY_COLLECTION}/meta-polarfire-soc-yocto-bsp-addon master"
# <-- meta-aries-polarfire-resy-collection

MYMAP[meta-swupdate-master]="${GITHUB}/sbabic/meta-swupdate ${SOURCES}/meta-swupdate-master master ${SOURCES}/manifests/meta-swupdate-master/patch.sh"
MYMAP[meta-swupdate-boards-master]="${GITHUB}/sbabic/meta-swupdate-boards ${SOURCES}/meta-swupdate-boards-master master ${SOURCES}/manifests/meta-swupdate-boards-master/patch.sh"
MYMAP[meta-swupdate-boards-res-master]="${GITLAB}/meta-layers/meta-swupdate-boards-res ${SOURCES}/meta-swupdate-boards-res-master master"
MYMAP[meta-yocto-res-bsp-custom-master]="${GITLAB}/meta-layers/meta-yocto-res-bsp-custom.git ${SOURCES}/meta-yocto-res-bsp-custom-master master"

# --> meta-raspberrypi-resy-collection
# my own layers:
# 3rd party layers:
# bosc - before override syntax change
# poky-master - no patches, master, specific commit
MYMAP[meta-raspberrypi-resy-collection-poky-master-bosc]="${GIT_YP}/poky ${RASPBERRYPI_RESY_COLLECTION_BOSC}/poky-master-bosc master none f735627e7c5aeb421338db55f3905d74751d4b71"
# meta-raspberrypi-master - no patches, master, specific commit
MYMAP[meta-raspberrypi-resy-collection-meta-raspberrypi-master-bosc]="${GIT_YP}/meta-raspberrypi ${RASPBERRYPI_RESY_COLLECTION_BOSC}/meta-raspberrypi-master-bosc master none 8dc3a310883ea87cd9900442f46f20bb08e57583"
# meta-openembedded-master - no patches, master, specific commit
MYMAP[meta-raspberrypi-resy-collection-meta-openembedded-master-bosc]="${GIT_OE}/meta-openembedded ${RASPBERRYPI_RESY_COLLECTION_BOSC}/meta-openembedded-master-bosc master none 5a9eef2f531cfb051661c53de34e4c6ba6915138"
# meta-virtualization-master - patches needed, master, specific commit
MYMAP[meta-raspberrypi-resy-collection-meta-virtualization-master-bosc]="${GIT_YP}/meta-virtualization ${RASPBERRYPI_RESY_COLLECTION_BOSC}/meta-virtualization-master-bosc master ${SOURCES}/manifests/meta-raspberrypi-resy-collection-meta-virtualization-master-bosc/patch.sh 5fdf66c1e2ec0c6b08573bf0a6aa9f84d2fc4ae6"

# meta-resy-master - master-bosc
MYMAP[meta-raspberrypi-resy-collection-meta-resy-master-bosc]="${GITLAB}/meta-layers/meta-resy.git ${RASPBERRYPI_RESY_COLLECTION_BOSC}/meta-resy-master-bosc master-bosc"
MYMAP[meta-raspberrypi-resy-collection-meta-raspberrypi-common-master-bosc]="${GITLAB}/meta-layers/meta-raspberrypi-common.git ${RASPBERRYPI_RESY_COLLECTION_BOSC}/meta-raspberrypi-common-master-bosc master-bosc"
MYMAP[meta-raspberrypi-resy-collection-meta-raspberrypi-addon-master-bosc]="${GITLAB}/meta-layers/meta-raspberrypi-addon.git ${RASPBERRYPI_RESY_COLLECTION_BOSC}/meta-raspberrypi-addon-master-bosc master-bosc"
# <-- meta-raspberrypi-resy-collection

# jenkins
MYMAP[jenkins-docker]="${GITHUB}/RobertBerger/jenkins-docker ${JENKINS}/jenkins-docker ${JENKINS_BRANCH}"

# fossology
MYMAP[fossology]="${GITHUB}/RobertBerger/fossology ${FOSSOLOGY}/fossology ${FOSSOLOGY_BRANCH}"

# --> oci
MYMAP[skopeo-container]="${GITHUB}/RobertBerger/skopeo-container ${OCI_CONTAINER_X86_64}/skopeo-container ${SKOPEO_BRANCH}"
MYMAP[terrier-container]="${GITHUB}/RobertBerger/terrier-container ${OCI_CONTAINER_X86_64}/terrier-container ${TERRIER_BRANCH}"
# <-- oci

# --> crops
# extsdk-container is deprecated and replaced by sdk-container
MYMAP[extsdk-container]="${GITHUB}/RobertBerger/extsdk-container ${CROPS_CONTAINER_X86_64}/extsdk-container 2020-09-17-master-local"
MYMAP[sdk-container]="${GITHUB}/RobertBerger/sdk-container ${CROPS_CONTAINER_X86_64}/sdk-container 2021-05-31-master-local-gcc-9-ub18-esdk-exp"
# for training:
# MYMAP[poky-container]="${GITHUB}/RobertBerger/poky-container ${CROPS_CONTAINER_X86_64}/poky-container 2021-06-09-master-local-gcc-9-gui-icecc-ub18"
# new:
MYMAP[poky-container]="${GITHUB}/RobertBerger/poky-container ${CROPS_CONTAINER_X86_64}/poky-container 2021-08-31-master-local-icecc-ub20"
# for training:
# MYMAP[yocto-dockerfiles]="${GITHUB}/RobertBerger/yocto-dockerfiles ${CROPS_CONTAINER_X86_64}/yocto-dockerfiles 2020-05-30-master-local-ub18"
# new:
MYMAP[yocto-dockerfiles]="${GITHUB}/RobertBerger/yocto-dockerfiles ${CROPS_CONTAINER_X86_64}/yocto-dockerfiles 2021-08-31-master-local-ub20"
MYMAP[icecc-container]="${GITHUB}/RobertBerger/icecc-container ${CROPS_CONTAINER_X86_64}/icecc-container 2021-04-08"
# <-- crops

# --> app-container-x86-64
MYMAP[app-container-tensorflow]="${GITLAB}/app-container/app-container-tensorflow.git ${APP_CONTAINER_X86_64}/app-container-tensorflow master"
MYMAP[app-container-tensorflow-oci]="${GITLAB}/app-container/app-container-tensorflow-oci.git ${APP_CONTAINER_X86_64}/app-container-tensorflow-oci master"
MYMAP[app-container-java-oci]="${GITLAB}/app-container/app-container-java-oci.git ${APP_CONTAINER_X86_64}/app-container-java-oci master"
MYMAP[app-container-java-examples-oci]="${GITLAB}/app-container/app-container-java-examples-oci.git ${APP_CONTAINER_X86_64}/app-container-java-examples-oci master"
MYMAP[app-container-go]="${GITLAB}/app-container/app-container-go.git ${APP_CONTAINER_X86_64}/app-container-go master"
MYMAP[app-container-influxdb-prebuilt]="${GITLAB}/app-container/app-container-influxdb-prebuilt.git ${APP_CONTAINER_X86_64}/app-container-influxdb-prebuilt master"
MYMAP[app-container-influxdb-prebuilt-oci]="${GITLAB}/app-container/app-container-influxdb-prebuilt-oci.git ${APP_CONTAINER_X86_64}/app-container-influxdb-prebuilt-oci master"
MYMAP[app-container-telegraf-prebuilt]="${GITLAB}/app-container/app-container-telegraf-prebuilt.git ${APP_CONTAINER_X86_64}/app-container-telegraf-prebuilt master"
# <-- app-container-x86-64

# --> app-containers
# Note: same repo - 3 different branches
MYMAP[app-container-lighttpd-oci-x86-64]="${GITLAB}/app-container/app-container-lighttpd-oci.git ${APP_CONTAINER_X86_64}/app-container-lighttpd-oci x86-64"
MYMAP[app-container-lighttpd-oci-arm-v7]="${GITLAB}/app-container/app-container-lighttpd-oci.git ${APP_CONTAINER_ARM_V7}/app-container-lighttpd-oci arm-v7"
MYMAP[app-container-lighttpd-oci-multi-arch]="${GITLAB}/app-container/app-container-lighttpd-oci.git ${APP_CONTAINER_MULTI_ARCH}/oci-lighttpd multi-arch"

# Note: same repo - 3 different branches
MYMAP[app-container-telegraf-prebuilt-oci-x86-64]="${GITLAB}/app-container/app-container-telegraf-prebuilt-oci.git ${APP_CONTAINER_X86_64}/app-container-telegraf-prebuilt-oci x86-64"
MYMAP[app-container-telegraf-prebuilt-oci-arm-v7]="${GITLAB}/app-container/app-container-telegraf-prebuilt-oci.git ${APP_CONTAINER_ARM_V7}/app-container-telegraf-prebuilt-oci arm-v7"
MYMAP[app-container-telegraf-prebuilt-oci-multi-arch]="${GITLAB}/app-container/app-container-telegraf-prebuilt-oci.git ${APP_CONTAINER_MULTI_ARCH}/oci-telegraf-prebuilt multi-arch"

# Note: same repo - different branches
MYMAP[app-container-tensorflow-examples-x86-64]="${GITLAB}/app-container/app-container-tensorflow-examples.git ${APP_CONTAINER_X86_64}/app-container-tensorflow-examples x86-64"
MYMAP[app-container-tensorflow-examples-aarch64]="${GITLAB}/app-container/app-container-tensorflow-examples.git ${APP_CONTAINER_AARCH64}/app-container-tensorflow-examples imx8mm-lpddr4-evk-ml"




MYMAP[oci-phoronix-arm-v7]="${GITLAB}/app-container/oci-phoronix.git ${APP_CONTAINER_ARM_V7}/oci-phoronix arm-v7"

# app-container-lighttpd (docker) are just some experiments - does not work
MYMAP[app-container-lighttpd-x86-64]="${GITLAB}/app-container/app-container-lighttpd.git ${APP_CONTAINER_X86_64}/app-container-lighttpd x86-64"
MYMAP[app-container-lighttpd-multi-arch]="${GITLAB}/app-container/app-container-lighttpd.git ${APP_CONTAINER_MULTI_ARCH}/docker-lighttpd multi-arch"
# <-- app-containers

# I think we did the manifests above with a question - not always (e.g. when we erase everything)
MYMAP[manifests]="${GITHUB}/RobertBerger/manifests ${SOURCES}/manifests ${MANIFESTS_BRANCH}"

# e.g.:
#      MYMAP[meta-virtualization-master]="${GIT_YP}/meta-virtualization ${SOURCES}/meta-virtualization-master master ${SOURCES}/manifests/meta-virtualization-master/patch.sh"
# $1: git repo to clone/pull from
# $2: local name of git repo
# $3: branch (to pull from)
# $4: patch.sh contains patches to be applied - this needs to be a file!!
# $5: commit id (note we also need $4 for this to work)

# --> I guess we should update manifests first
  echo "+ Do you want to replace manifests first?"
  read -r -p "Are you sure? [y/N] " response
  case "$response" in
      [yY][eE][sS]|[yY])
          echo "+ replacing manifests!"
	  set ${MYMAP["manifests"]}
	  echo "+ rm -rf $2"
          rm -rf $2
          echo "+ git clone -b $3 $1 $2 --single-branch"
          git clone -b $3 $1 $2 --single-branch
          echo "+ rerun resy.sh and pick [N] next time"
          exit
          ;;
      *)
          #exit
          echo "+ manifests might be replaced later"
          echo "+ you might need to run resy.sh again"
          ;;
  esac
# <-- I guess we should update manifests first

for K in "${!MYMAP[@]}"
do
  echo "--> $K"
  set ${MYMAP["${K}"]}

  # if dir already exists we need to check if it's the correct remote uri
  if [ -d $2 ]; then
    pushd $2
    REMOTE_URI=$(git remote get-url origin)
    if [[ $REMOTE_URI = ${1} ]]; then
       echo -e "\e[32m correct\e[39m REMOTE_URI: ${REMOTE_URI}"
    else
       echo -e "\e[31m wrong\e[39m REMOTE_URI: ${REMOTE_URI}"
       echo "+ should be ${1}"
       # we can just erase it and will get the right one
       echo "+ rm -rf $2"
       rm -rf $2
    fi
    popd
  fi
  # if dir already exists we need to check if it needs update
  if [ -d $2 ]; then
    pushd $2

    # let's get the latest from remote
    echo "+ git remote update"
    git remote update

    # are we on the right branch?
    LOCAL_BRANCH="$(git rev-parse --abbrev-ref HEAD)"
    echo "LOCAL_BRANCH: ${LOCAL_BRANCH}"

    # if we have a commit id we create a special local branch _LOCAL
    # so let's compare against this as well
    if [ ! -z "$5" ]; then
        BRANCH_WE_WANT="${3}_LOCAL"
    else
        BRANCH_WE_WANT="$3"
    fi
    echo "BRANCH_WE_WANT: ${BRANCH_WE_WANT}"

    if [ "$LOCAL_BRANCH" == "$BRANCH_WE_WANT" ]; then
       echo "branch is already what we want: ${LOCAL_BRANCH}"
    else
       echo -e "\e[31mbranch mismatch\e[39m"
       echo "because we clone with --single-branch"
      # echo "pwd: $(pwd)"
      #  echo "1: $1"
      #  echo "2: $2"
      #  echo "3: $3"
      #  echo "4: $4"
      #  echo "5: $5"
      #  echo "6: $6"
       echo "+ rm -rf $2"
       echo "Press <ENTER> to go on"
       rm -rf $2
       echo "+ "
       echo "+ git clone -b $3 $1 $2 --single-branch"
       echo "Press <ENTER> to go on"
       cd ..
       git clone -b $3 $1 $2 --single-branch
       cd $2
       #echo "+ git checkout $3"
       #git checkout $3
    fi    

    #echo "+ git remote update"
    #git remote update
    #UPSTREAM=${1:-'@{u}'}
    UPSTREAM="origin/$3"
    echo "UPSTREAM: ${UPSTREAM}"
    LOCAL=$(git rev-parse @)
    echo "LOCAL: ${LOCAL}"
    REMOTE=$(git rev-parse "$UPSTREAM")
    echo "REMOTE: ${REMOTE}"
    BASE=$(git merge-base @ "$UPSTREAM")
    echo "BASE: ${BASE}"

  # if we have a special commit we can ignore this block
  # so only if $5 is empty do it:
  if [ -z "$5" ]; then
    if [ $LOCAL = $REMOTE ]; then
        echo -e "\e[32mUp-to-date\e[39m"
    elif [ $LOCAL = $BASE ]; then
        echo -e "\e[31mNeed to pull\e[39m"
        echo "+ git pull"
        echo "Press <ENTER> to go on"
        read r
        git pull
    elif [ $REMOTE = $BASE ]; then
        echo -e "\e[31mNeed to push\e[39m"
        echo -e "\e[31mError\e[39m"
        if [ -f "$4" ]; then
           echo "Looks like it's a custom patch:"
           echo "${4}"
           echo -e "\e[31mtrying:\e[39m"
           echo -e "\e[32mpushd $2\e[39m"
           echo -e "\e[32mgit reset --hard HEAD~1\e[39m"
           echo -e "\e[32mpopd\e[39m"
           pushd $2
           git reset --hard HEAD~1
           popd
           echo "Press <ENTER> to go on"
           read r
        else
           echo "Press <ENTER> to go on"
           read r
           exit -1
        fi
    else
        echo -e "\e[31mDiverged\e[39m"
        echo -e "\e[31mError\e[39m"
        if [ -f "$4" ]; then
           echo "Looks like it's a custom patch:"
           echo "${4}"
           echo -e "\e[31mtrying:\e[39m"
           echo -e "\e[32mpushd $2\e[39m"
           echo -e "\e[32mgit reset --hard HEAD~1\e[39m"
           echo -e "\e[32mpopd\e[39m"
           pushd $2
           git reset --hard HEAD~1
           popd
        else
           echo "Press <ENTER> to go on"
           read r
           exit -1
        fi
    fi
  fi # ignore the whole block due to specific commit
    popd
 echo "Press <ENTER> to go on"
 read r
else # dir exists above
# dir does not exists here
# so we need to clone 
  # if dir already exists we remove it 
  #if [ -d $2 ]; then
  #   echo "+ rm -rf $2"
  #   rm -rf $2 
  #fi

  echo "git clone -b $3 $1 $2 --single-branch"
  git clone -b $3 $1 $2 --single-branch
  retVal=$?
  if [ $retVal -ne 0 ]; then
     echo "Error $retVal"
     echo "Press <ENTER> to go on"
     read r
     exit $retVal
  fi

  # looks like here we cloned a specific branch
  # if we need a specific commit it needs to be $5 for now
  if [ ! -z "$5" ]; then
     echo -e "\e[32mLooks like it's a commit id:\e[39m"
     echo "${5}"
     echo "Press <ENTER> to go on"
     read r
     pushd $2
     echo "git checkout -b ${3}_LOCAL $5"
     git checkout -b ${3}_LOCAL $5
     retVal=$?
     popd
     if [ $retVal -ne 0 ]; then
        echo "Error $retVal"
        echo "Press <ENTER> to go on"
        read r
        exit $retVal
     fi
  fi
fi # dir does not exist

  # --> patch upstream branch
  # if e.g. /workdir/sources/manifests/meta-virtualization-master/patch.sh exists
  if [ -f "$4" ]; then
     echo -e "\e[32mtrying to apply this patch: $4\e[39m"
     echo "Press <ENTER> to go on"
     read r
     set -x
     # go into the git repo which should be patched
     # e.g. /workdir/sources/meta-virtualization-master
     pushd $2
     # apply the patch
     ${4}
     #pwd
     # git add/commit
     git add .
     git commit -m "patch typically only against upstream master"
     # back where we came from
     popd
     # apply from git
     set +x
  fi
  # <-- patch upstream branch

  echo "pushd $2"
  pushd $2
  echo "git branch"
  git branch
  echo "popd"
  popd
  echo "<-- $K"
done

#read r

# popd SOURCES
#popd

#read r

set -x
if [ ! -L resy-poky-container.sh ]; then
   ln -sf sources/manifests/resy-poky-container.sh resy-poky-container.sh
fi
if [ ! -L resy-sdk-container.sh ]; then
   ln -sf sources/manifests/resy-sdk-container.sh resy-sdk-container.sh
fi
if [ ! -L resy-cooker.sh ]; then
   ln -sf sources/manifests/resy-cooker.sh resy-cooker.sh
fi
if [ ! -L killall_bitbake.sh ]; then
   ln -sf sources/manifests/killall_bitbake.sh killall_bitbake.sh
fi
if [ ! -L oci-copy-to-docker.sh ]; then
   ln -sf sources/manifests/oci-copy-to-docker.sh oci-copy-to-docker.sh
fi
if [ ! -L oci-copy-to-docker.sh ]; then
   ln -sf sources/manifests/oci-remove-remote-docker-tag.sh oci-remove-remote-docker-tag.sh
fi
if [ ! -L build-and-shutdown.sh ]; then
   ln -sf sources/manifests/build-and-shutdown.sh build-and-shutdown.sh
fi
#if [ ! -L jenkins-resy.sh ]; then
#   ln -sf sources/manifests/jenkins-resy.sh jenkins-resy.sh
#fi


if [ ! -L resy.sh ]; then
   ln -sf sources/manifests/resy.sh resy.sh
fi
set +x


echo "symlinks ready"

#read r
