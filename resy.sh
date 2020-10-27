#!/bin/bash

SOURCES="/workdir/sources"
SCRIPTS="/workdir/scripts"
JENKINS="/workdir/jenkins"
OCI_CONTAINER_X86_64="/workdir/oci-container-x86-64"
APP_CONTAINER_X86_64="/workdir/app-container-x86-64"
APP_CONTAINER_ARM_V7="/workdir/app-container-arm-v7"
APP_CONTAINER_MULTI_ARCH="/workdir/app-container-multi-arch"
CROPS_CONTAINER_X86_64="/workdir/crops-container-x86-64"
GITHUB="git://github.com"
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
          rm -rf crops-container-x86-64
          rm -rf oci-container-x86-64
          rm -rf jenkins
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
  echo "we would choose stable/bleeding here"
  echo "we choose bleeding"
  export manifest="bleeding"
else
  echo "use bleeding for now"
  select manifest in 'stable' 'bleeding' 'experimental'
  do
    echo "MANIFEST: $manifest"
    break;
  done
fi

  if [ "$manifest" == "experimental" ]; then
     export META_RESY_BRANCH="dunfell"
     export META_POKY_BRANCH="2020-08-28-dunfell-3.1.2+"
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
     export META_PHYBOARD_POLIS_IMX8MM_BSP_BRANCH="v5.8.x-upstream"
     export META_SYSTEMD_NFSROOT_BRANCH="dunfell"
     export META_QT5_BRANCH="2020-09-08-dunfell"
     export META_QT5_EXAMPLES_BRANCH="dunfell"
     export META_TENSORFLOW_MASTER_BRANCH="2020-10-27-master-as-gatesgarth"
     export JENKINS_BRANCH="2020-08-28-jenkins-2.235.5"
  fi

  if [ "$manifest" == "bleeding" ]; then
     export META_RESY_BRANCH="dunfell"
     export META_POKY_BRANCH="2020-06-29-dunfell-3.1.1++"
     export META_POKY_TRAINING_BRANCH="2020-06-29-dunfell-3.1.1+"
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
     # used before dunfell on origial meta-freescale
     export META_FREESCALE_BRANCH="2020-08-28-dunfell"
     export META_PHYBOARD_POLIS_IMX8MM_BSP_BRANCH="v5.8.0-upstream"
     export META_SYSTEMD_NFSROOT_BRANCH="dunfell"
     export META_QT5_BRANCH="2020-09-08-dunfell"
     export META_QT5_EXAMPLES_BRANCH="dunfell"
     export META_TENSORFLOW_MASTER_BRANCH="2020-10-27-master-as-gatesgarth"
     export JENKINS_BRANCH="2020-06-08-jenkins-2.222.4"
  fi

  if [ "$manifest" == "stable" ]; then
     #export MANIFEST="resy.xml"
     export META_RESY_BRANCH="zeus"
     export META_POKY_BRANCH="2020-01-03-zeus-3.0.1+"
     export META_POKY_TRAINING_BRANCH="2020-06-29-dunfell-3.1.1+"
     export META_VIRTUALIZATION_BRANCH="2020-01-03-zeus-3.0+"
     export META_DESIRE_BRANCH="zeus"
     export META_MULTI_V7_ML_BSP_BRANCH="zeus-v5.4.x"
     export META_U_BOOT_WIC_BSP_BRANCH="zeus-v5.4.x"
     export META_U_BOOT_MENDER_BSP_BRANCH="zeus-v5.4.x"
     export META_U_BOOT_KARO_WIC_BSP_BRANCH="zeus"
     export META_KARO_BSP_BRANCH="zeus"
     export META_SCA_BRANCH="2020-01-03-zeus"
     export META_OPENEMBEDDED_BRANCH="2020-01-03-zeus-3.0+"
     export META_JAVA_BRANCH="2020-02-13-master-next-as-zeus-3.0+"
     export META_TENSORFLOW_BRANCH="2020-05-10-master-as-zeus"
     export MAIFESTS_BRANCH="master"
     export META_PYTHON2_BRANCH="zeus"
     export META_MENDER_BRANCH="2019-11-19-thud-as-zeus"
     # not needed since we still have python2 support
     export META_PYTHON2_BRANCH="zeus"
     export META_BFE_BRANCH="master"
     export META_XENOMAI_BRANCH="xeno-3.1-4.19.128"
     export META_PRT_BRANCH="dunfell"
     export SKOPEO_BRANCH="skopeo-v1.1.0"
     export TERRIER_BRANCH="2020-07-24"
     export META_RASPBERRYPI_BRANCH="dunfell"
     export META_RASPBERRYPI_ML_BSP_BRANCH="dunfell"
     export META_FREESCALE_BRANCH="2020-08-28-dunfell"
     export META_PHYBOARD_POLIS_IMX8MM_BSP_BRANCH="v5.8.0-upstream"
     export META_SYSTEMD_NFSROOT_BRANCH="dunfell"
     export META_QT5_BRANCH="2020-09-08-dunfell"
     export META_QT5_EXAMPLES_BRANCH="dunfell"
     export META_TENSORFLOW_MASTER_BRANCH="2020-10-27-master-as-gatesgarth"
     export JENKINS_BRANCH="2020-06-08-jenkins-2.222.4"
  fi

declare -A MYMAP
MYMAP[manifests]="${GITHUB}/RobertBerger/manifests ${SOURCES}/manifests ${MANIFESTS_BRANCH}"
MYMAP[convenience-scripts]="${GITLAB}/meta-layers/convenience-scripts.git ${SCRIPTS}/convenience-scripts master"
MYMAP[poky]="${GITHUB}/RobertBerger/poky ${SOURCES}/poky ${META_POKY_BRANCH}"
MYMAP[poky-master]="${GIT_YP}/poky ${SOURCES}/poky-master master"
MYMAP[poky-training]="${GITHUB}/RobertBerger/poky ${SOURCES}/poky-training ${META_POKY_TRAINING_BRANCH}"
# my-mender-layer (encrypted)
MYMAP[my-mender-layer]="${GITHUB}/RobertBerger/my-mender-layer ${SOURCES}/my-mender-layer master"
#MYMAP[keys-for-signing]="${GITHUB}/RobertBerger/keys-for-signing ${SOURCES}/keys-for-signing master"
MYMAP[meta-python2]="${GITHUB}/RobertBerger/meta-python2 ${SOURCES}/meta-python2 ${META_PYTHON2_BRANCH}"
MYMAP[meta-virtualization]="${GITHUB}/RobertBerger/meta-virtualization ${SOURCES}/meta-virtualization ${META_VIRTUALIZATION_BRANCH}"
MYMAP[meta-virtualization-master]="${GIT_YP}/meta-virtualization ${SOURCES}/meta-virtualization-master master"
MYMAP[meta-wifi-credentials]="${GITHUB}/RobertBerger/meta-wifi-credentials ${SOURCES}/meta-wifi-credentials dunfell"
# my meta-u-boot-wic-bsp bsp u-boot is here
MYMAP[meta-u-boot-wic-bsp]="${GITLAB}/meta-layers/meta-u-boot-wic-bsp.git ${SOURCES}/meta-u-boot-wic-bsp ${META_U_BOOT_WIC_BSP_BRANCH}"
# my meta-u-boot-mender-bsp bsp u-boot is here
MYMAP[meta-u-boot-mender-bsp]="${GITLAB}/meta-layers/meta-u-boot-mender-bsp.git ${SOURCES}/meta-u-boot-mender-bsp ${META_U_BOOT_MENDER_BSP_BRANCH}"
# meta-u-boot-karo-wic-bsp: deprecated?
#MYMAP[meta-u-boot-karo-wic-bsp]="${GITLAB}/meta-layers/meta-u-boot-karo-wic-bsp.git ${SOURCES}/meta-u-boot-karo-wic-bsp ${META_U_BOOT_KARO_WIC_BSP_BRANCH}"
MYMAP[meta-sca]="${GITHUB}/RobertBerger/meta-sca  ${SOURCES}/meta-sca ${META_SCA_BRANCH}"
# my resy distro 
MYMAP[resy]="${GITLAB}/meta-layers/meta-resy.git ${SOURCES}/meta-resy ${META_RESY_BRANCH}"
MYMAP[resy-master]="${GITLAB}/meta-layers/meta-resy.git ${SOURCES}/meta-resy-master master"
MYMAP[meta-openembedded]="${GITHUB}/RobertBerger/meta-openembedded ${SOURCES}/meta-openembedded ${META_OPENEMBEDDED_BRANCH}"
MYMAP[meta-openembedded-master]="${GIT_OE}/meta-openembedded ${SOURCES}/meta-openembedded-master master"
MYMAP[meta-multi-v7-ml-bsp]="${GITLAB}/meta-layers/meta-multi-v7-ml-bsp.git ${SOURCES}/meta-multi-v7-ml-bsp ${META_MULTI_V7_ML_BSP_BRANCH}"
MYMAP[meta-multi-v7-ml-linux-yocto-custom-virt]="${GITLAB}/meta-layers/meta-multi-v7-ml-linux-yocto-custom-virt.git ${SOURCES}/meta-multi-v7-ml-linux-yocto-custom-virt ${META_MULTI_V7_ML_BSP_BRANCH}"

MYMAP[meta-systemd-nfsroot]="${GITLAB}/meta-layers/meta-systemd-nfsroot.git ${SOURCES}/meta-systemd-nfsroot ${META_SYSTEMD_NFSROOT_BRANCH}"

MYMAP[meta-java]="${GITHUB}/RobertBerger/meta-java ${SOURCES}/meta-java ${META_JAVA_BRANCH}"
MYMAP[meta-java-examples]="${GITLAB}/meta-layers/meta-java-examples.git ${SOURCES}/meta-java-examples master"
MYMAP[meta-tensorflow]="${GITHUB}/RobertBerger/meta-tensorflow ${SOURCES}/meta-tensorflow ${META_TENSORFLOW_BRANCH}"
MYMAP[meta-tensorflow-master]="${GIT_YP}/meta-tensorflow ${SOURCES}/meta-tensorflow-master ${META_TENSORFLOW_MASTER_BRANCH}"
MYMAP[meta-tensorflow-examples]="${GITLAB}/meta-layers/meta-tensorflow-examples.git ${SOURCES}/meta-tensorflow-examples master"
MYMAP[meta-tensorflow-examples-master]="${GITLAB}/meta-layers/meta-tensorflow-examples.git ${SOURCES}/meta-tensorflow-examples-master master"
MYMAP[meta-golang-examples]="${GITLAB}/meta-layers/meta-golang-examples.git ${SOURCES}/meta-golang-examples master"
MYMAP[meta-python2]="${GITHUB}/RobertBerger/meta-python2 ${SOURCES}/meta-python2 ${META_PYTHON2_BRANCH}"
MYMAP[meta-qt5]="${GITHUB}/RobertBerger/meta-qt5 ${SOURCES}/meta-qt5 ${META_QT5_BRANCH}"
MYMAP[meta-qt5-examples]="${GITLAB}/meta-layers/meta-qt5-examples.git ${SOURCES}/meta-qt5-examples ${META_QT5_EXAMPLES_BRANCH}"
MYMAP[meta-freescale]="${GITHUB}/RobertBerger/meta-freescale ${SOURCES}/meta-freescale ${META_FREESCALE_BRANCH}"
MYMAP[meta-phyboard-polis-imx8mm-bsp]="${GITLAB}/meta-layers/meta-phyboard-polis-imx8mm-bsp ${SOURCES}/meta-phyboard-polis-imx8mm-bsp ${META_PHYBOARD_POLIS_IMX8MM_BSP_BRANCH}"

MYMAP[meta-bb-syntax]="${GITLAB}/meta-layers/meta-bb-syntax ${SOURCES}/meta-bb-syntax master"

MYMAP[meta-clang]="${GITHUB}/RobertBerger/meta-clang ${SOURCES}/meta-clang 2020-06-05-master-as-dunfell"
MYMAP[meta-buildutils]="${GITHUB}/RobertBerger/meta-buildutils ${SOURCES}/meta-buildutils 2020-06-05-master-as-dunfell"
MYMAP[meta-mender]="${GITHUB}/RobertBerger/meta-mender ${SOURCES}/meta-mender ${META_MENDER_BRANCH}" 
MYMAP[meta-karo-bsp]="${GITLAB}/meta-layers/meta-karo-bsp.git ${SOURCES}/meta-karo-bsp ${META_KARO_BSP_BRANCH}"
MYMAP[meta-bfe]="${GITLAB}/meta-layers/meta-bfe.git ${SOURCES}/meta-bfe ${META_BFE_BRANCH}"
MYMAP[meta-tig]="${GITLAB}/meta-layers/meta-tig.git ${SOURCES}/meta-tig master"
MYMAP[meta-tig-master]="${GITLAB}/meta-layers/meta-tig.git ${SOURCES}/meta-tig-master master"
MYMAP[meta-xenomai]="${GITLAB}/meta-layers/meta-xenomai.git ${SOURCES}/meta-xenomai ${META_XENOMAI_BRANCH}"
MYMAP[meta-prt]="${GITLAB}/meta-layers/meta-prt.git ${SOURCES}/meta-prt ${META_PRT_BRANCH}"

MYMAP[meta-raspberrypi]="${GITHUB}/RobertBerger/meta-raspberrypi ${SOURCES}/meta-raspberrypi ${META_RASPBERRYPI_BRANCH}"
MYMAP[meta-raspberrypi-ml-bsp]="${GITLAB}/meta-layers/meta-raspberrypi-ml-bsp.git ${SOURCES}/meta-raspberrypi-ml-bsp ${META_RASPBERRYPI_ML_BSP_BRANCH}"

# jenkins
MYMAP[jenkins-docker]="${GITHUB}/RobertBerger/jenkins-docker ${JENKINS}/jenkins-docker ${JENKINS_BRANCH}"


# --> oci
MYMAP[skopeo-container]="${GITHUB}/RobertBerger/skopeo-container ${OCI_CONTAINER_X86_64}/skopeo-container ${SKOPEO_BRANCH}"
MYMAP[terrier-container]="${GITHUB}/RobertBerger/terrier-container ${OCI_CONTAINER_X86_64}/terrier-container ${TERRIER_BRANCH}"
# <-- oci

# --> crops
# deprecated:
MYMAP[extsdk-container]="${GITHUB}/RobertBerger/extsdk-container ${CROPS_CONTAINER_X86_64}/extsdk-container 2020-09-17-master-local"
MYMAP[sdk-container]="${GITHUB}/RobertBerger/sdk-container ${CROPS_CONTAINER_X86_64}/sdk-container 2020-10-03-master-local-gcc-9-ub18"
MYMAP[poky-container]="${GITHUB}/RobertBerger/poky-container ${CROPS_CONTAINER_X86_64}/poky-container 2020-07-26-master-local-gcc-9-gui-ub18"
MYMAP[yocto-dockerfiles]="${GITHUB}/RobertBerger/yocto-dockerfiles ${CROPS_CONTAINER_X86_64}/yocto-dockerfiles 2019-11-19-master-local"
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
# Note: same repo - 3 differernt branches
MYMAP[app-container-lighttpd-oci-x86-64]="${GITLAB}/app-container/app-container-lighttpd-oci.git ${APP_CONTAINER_X86_64}/app-container-lighttpd-oci x86-64"
MYMAP[app-container-lighttpd-oci-arm-v7]="${GITLAB}/app-container/app-container-lighttpd-oci.git ${APP_CONTAINER_ARM_V7}/app-container-lighttpd-oci arm-v7"
MYMAP[app-container-lighttpd-oci-multi-arch]="${GITLAB}/app-container/app-container-lighttpd-oci.git ${APP_CONTAINER_MULTI_ARCH}/oci-lighttpd multi-arch"

# Note: same repo - 3 differernt branches
MYMAP[app-container-telegraf-prebuilt-oci-x86-64]="${GITLAB}/app-container/app-container-telegraf-prebuilt-oci.git ${APP_CONTAINER_X86_64}/app-container-telegraf-prebuilt-oci x86-64"
MYMAP[app-container-telegraf-prebuilt-oci-arm-v7]="${GITLAB}/app-container/app-container-telegraf-prebuilt-oci.git ${APP_CONTAINER_ARM_V7}/app-container-telegraf-prebuilt-oci arm-v7"
MYMAP[app-container-telegraf-prebuilt-oci-multi-arch]="${GITLAB}/app-container/app-container-telegraf-prebuilt-oci.git ${APP_CONTAINER_MULTI_ARCH}/oci-telegraf-prebuilt multi-arch"


MYMAP[oci-phoronix-arm-v7]="${GITLAB}/app-container/oci-phoronix.git ${APP_CONTAINER_ARM_V7}/oci-phoronix arm-v7"

# app-container-lighttpd (docker) are just some experiments - does not work
MYMAP[app-container-lighttpd-x86-64]="${GITLAB}/app-container/app-container-lighttpd.git ${APP_CONTAINER_X86_64}/app-container-lighttpd x86-64"
MYMAP[app-container-lighttpd-multi-arch]="${GITLAB}/app-container/app-container-lighttpd.git ${APP_CONTAINER_MULTI_ARCH}/docker-lighttpd multi-arch"
# <-- app-containers

for K in "${!MYMAP[@]}"
do
  echo "--> $K"
  set ${MYMAP["${K}"]}


  # if dir already exists we need to check if it needs update
  if [ -d $2 ]; then
    pushd $2

    # let's get the latest from remote
    echo "+ git remote update"
    git remote update

    # are we on the right branch?
    LOCAL_BRANCH="$(git rev-parse --abbrev-ref HEAD)"
    echo "LOCAL_BRANCH: ${LOCAL_BRANCH}"

    BRANCH_WE_WANT="$3"
    echo "BRANCH_WE_WANT: ${BRANCH_WE_WANT}"

    if [ "$LOCAL_BRANCH" == "$BRANCH_WE_WANT" ]; then
       echo "branch is already what we want: ${LOCAL_BRANCH}"
    else
       echo -e "\e[31mbranch mismatch\e[39m"
       echo "+ git checkout $3"
       git checkout $3
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

    if [ $LOCAL = $REMOTE ]; then
        echo -e "\e[32mUp-to-date\e[39m"
    elif [ $LOCAL = $BASE ]; then
        echo -e "\e[31mNeed to pull\e[39m"
        #echo "+ rm -rf ../$2"
        echo "+ git pull"
        echo "Press <ENTER> to go on"
        read r
        git pull
        #rm -rf ../$2
    elif [ $REMOTE = $BASE ]; then
        echo "Need to push"
        echo "Error"
        echo "Press <ENTER> to go on"
        read r
        exit -1
    else
        echo "Diverged"
        echo "Error"
        echo "Press <ENTER> to go on"
        read r
        exit -1
    fi
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

  echo "git clone -b $3 $1 $2"
  git clone -b $3 $1 $2
  retVal=$?
  if [ $retVal -ne 0 ]; then
     echo "Error $retVal"
     echo "Press <ENTER> to go on"
     read r
     exit $retVal
  fi
fi # dir does not exist

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
