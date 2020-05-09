#!/bin/bash

SOURCES="/workdir/sources-new"
GITHUB="git://github.com"
GITLAB="https://gitlab.com"

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
          ;;
      *)
          exit
          ;;
  esac
fi

#set -x
#rm -rf .repo
#rm -rf sources
#rm -rf scripts
#rm -rf build
#rm -rf app-container-x86-64
#rm -rf crops-container-x86-64
#rm -rf oci-container-x86-64
#set +x

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
     #export MANIFEST="resy-experimental.xml"
     export META_RESY_BRANCH="dunfell"
     export META_POKY_BRANCH="2020-04-30-dunfell-3.1"
     export META_VIRTUALIZATION_BRANCH="2020-04-30-dunfell-3.1"
     export META_DESIRE_BRANCH="master"
     export META_MULTI_V7_ML_BSP_BRANCH="dunfell"
     export META_U_BOOT_WIC_BSP_BRANCH="dunfell"
     export META_U_BOOT_MENDER_BSP_BRANCH="dunfell"
     export META_U_BOOT_KARO_WIC_BSP_BRANCH="dunfell"
     export META_KARO_BSP_BRANCH="dunfell"
     export META_SCA_BRANCH="dunfell"
     export META_OPENEMBEDDED_BRANCH="2020-04-30-dunfell-3.1"
     export META_JAVA_BRANCH="2020-05-08-dunfell"
     export META_TENSORFLOW_BRANCH="master-as-dunfell"
     export MANIFESTS_BRANCH="dunfell"
  fi

  if [ "$manifest" == "bleeding" ]; then
     #export MANIFEST="resy-bleeding.xml"
     export META_RESY_BRANCH="master"
     export META_POKY_BRANCH="master"
     export META_VIRTUALIZATION_BRANCH="2020-01-03-zeus-3.0+"
     export META_DESIRE_BRANCH="master"
     export META_MULTI_V7_ML_BSP_BRANCH="master"
     export META_U_BOOT_WIC_BSP_BRANCH="master"
     export META_U_BOOT_MENDER_BSP_BRANCH="master"
     export META_U_BOOT_KARO_WIC_BSP_BRANCH="master"
     export META_KARO_BSP_BRANCH="master"
     export META_SCA_BRANCH="2020-01-03-zeus"
     export META_OPENEMBEDDED_BRANCH="2020-01-03-zeus-3.0+"
     export META_JAVA_BRANCH="2020-02-13-master-next-as-zeus-3.0+"
     export META_TENSORFLOW_BRANCH="zeus"
     export MANIFESTS_BRANCH="master"
  fi

  if [ "$manifest" == "stable" ]; then
     #export MANIFEST="resy.xml"
     export META_RESY_BRANCH="zeus"
     export META_POKY_BRANCH="2020-01-03-zeus-3.0.1+"
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
     export META_TENSORFLOW_BRANCH="zeus"
     export MAIFESTS_BRANCH="master"
  fi

#set -x
#repo init -u https://github.com/RobertBerger/manifests -m ${MANIFEST}
#repo sync

declare -A MYMAP
#MYMAP[poky]="${GITHUB}/RobertBerger/poky ${SOURCES}/poky ${META_POKY_BRANCH}"
#MYMAP[poky-training]="${GITHUB}/RobertBerger/poky ${SOURCES}/poky-training ${META_POKY_BRANCH}"
# my-mender-layer (encrypted)
#MYMAP[my-mender-layer]="${GITHUB}/RobertBerger/my-mender-layer ${SOURCES}/my-mender-layer master"
#MYMAP[meta-virtualization]="${GITHUB}/RobertBerger/meta-virtualization ${SOURCES}/meta-virtualization ${META_VIRTUALIZATION_BRANCH}"
# my meta-u-boot-wic-bsp bsp u-boot is here
#MYMAP[meta-u-boot-wic-bsp]="${GITLAB}/meta-layers/meta-u-boot-wic-bsp ${SOURCES}/meta-u-boot-wic-bsp ${META_U_BOOT_WIC_BSP_BRANCH}"
# my meta-u-boot-mender-bsp bsp u-boot is here
#MYMAP[meta-u-boot-mender-bsp]="${GITLAB}/meta-layers/meta-u-boot-mender-bsp ${SOURCES}/meta-u-boot-mender-bsp ${META_U_BOOT_MENDER_BSP_BRANCH}"
#MYMAP[meta-u-boot-karo-wic-bsp]="${GITLAB}/meta-layers/meta-u-boot-karo-wic-bsp ${SOURCES}/meta-u-boot-karo-wic-bsp ${META_U_BOOT_KARO_WIC_BSP_BRANCH}"
#MYMAP[meta-sca]="${GITHUB}/RobertBerger/meta-sca  ${SOURCES}/meta-sca ${META_SCA_BRANCH}"
# my resy distro 
#MYMAP[resy]="${GITLAB}/meta-layers/meta-resy.git ${SOURCES}/meta-resy ${META_RESY_BRANCH}"
#MYMAP[meta-openembedded]="${GITHUB}/RobertBerger/meta-openembedded ${SOURCES}/meta-openembedded ${META_OPENEMBEDDED_BRANCH}"
#MYMAP[meta-multi-v7-ml-bsp]="${GITLAB}/meta-layers/meta-multi-v7-ml-bsp ${SOURCES}/meta-multi-v7-ml-bsp ${META_MULTI_V7_ML_BSP_BRANCH}"
#MYMAP[meta-java]="${GITHUB}/RobertBerger/meta-java ${SOURCES}/meta-java ${META_JAVA_BRANCH}"
#MYMAP[meta-tensorflow]="${GITHUB}/RobertBerger/meta-tensorflow ${SOURCES}/meta-tensorflow ${META_TENSORFLOW_BRANCH}"
MYMAP[manifests]="${GITHUB}/RobertBerger/manifests ${SOURCES}/manifests ${MANIFESTS_BRANCH}"

#if [ -d ${SOURCES} ]; then
#   rm -rf ${SOURCES}
#fi

#mkdir ${SOURCES}

#pushd ${SOURCES}

for K in "${!MYMAP[@]}"
do
  echo "--> $K"
  set ${MYMAP["${K}"]}
  # if dir already exists we remove it 
  if [ -d $2 ]; then
     rm -rf $2 
  fi
  echo "git clone -b $3 $1 $2"
  git clone -b $3 $1 $2
  retVal=$?
  if [ $retVal -ne 0 ]; then
     echo "Error $retVal"
     echo "Press <ENTER> to go on"
     read r
     exit $retVal
  fi
  echo "pushd $2"
  pushd $2
  echo "git branch"
  git branch
  echo "popd"
  popd
  echo "<-- $K"
done

read r

# popd SOURCES
#popd

#read r

#pushd poky
#git checkout -b 2020-01-03-zeus-3.0.1+
#git branch --set-upstream-to=github/2020-01-03-zeus-3.0.1+ 2020-01-03-zeus-3.0.1+
#popd

#pushd poky-training
#git checkout -b 2020-01-03-zeus-3.0.1+
#git branch --set-upstream-to=github/2020-01-03-zeus-3.0.1+ 2020-01-03-zeus-3.0.1+
#popd

#pushd my-mender-layer
#git checkout -b master
#git branch --set-upstream-to=github/master master
#popd

#pushd meta-virtualization
#git checkout -b 2020-01-03-zeus-3.0+
#git branch --set-upstream-to=github/2020-01-03-zeus-3.0+ 2020-01-03-zeus-3.0+
#popd

#pushd meta-u-boot-wic-bsp
#git checkout -b ${META_U_BOOT_WIC_BSP_BRANCH}
#git branch --set-upstream-to=gitlab/${META_U_BOOT_WIC_BSP_BRANCH} ${META_U_BOOT_WIC_BSP_BRANCH}
#popd

#pushd meta-u-boot-mender-bsp
#git checkout -b ${META_U_BOOT_MENDER_BSP_BRANCH}
#git branch --set-upstream-to=gitlab/${META_U_BOOT_MENDER_BSP_BRANCH} ${META_U_BOOT_MENDER_BSP_BRANCH}
#popd

#pushd meta-u-boot-karo-wic-bsp
#git checkout -b ${META_U_BOOT_KARO_WIC_BSP_BRANCH}
#git branch --set-upstream-to=gitlab/${META_U_BOOT_KARO_WIC_BSP_BRANCH} ${META_U_BOOT_KARO_WIC_BSP_BRANCH}
#popd

#pushd meta-sca
#git checkout -b 2020-01-03-zeus
#git branch --set-upstream-to=github/2020-01-03-zeus 2020-01-03-zeus
#popd

#pushd meta-resy
#git checkout -b ${META_RESY_BRANCH}
#git branch --set-upstream-to=gitlab/${META_RESY_BRANCH} ${META_RESY_BRANCH}
#popd

#pushd meta-openembedded
#git checkout -b 2020-01-03-zeus-3.0+
#git branch --set-upstream-to=github/2020-01-03-zeus-3.0+ 2020-01-03-zeus-3.0+
#popd

#pushd meta-multi-v7-ml-bsp
#git checkout -b ${META_MULTI_V7_ML_BSP_BRANCH}
#git branch --set-upstream-to=gitlab/${META_MULTI_V7_ML_BSP_BRANCH} ${META_MULTI_V7_ML_BSP_BRANCH}
#popd

pushd meta-mender
git checkout -b 2019-11-19-thud-as-zeus
git branch --set-upstream-to=github/2019-11-19-thud-as-zeus 2019-11-19-thud-as-zeus
popd

pushd meta-karo-bsp
git checkout -b ${META_KARO_BSP_BRANCH}
git branch --set-upstream-to=gitlab/${META_KARO_BSP_BRANCH} ${META_KARO_BSP_BRANCH}
popd

pushd meta-desire
git checkout -b ${META_DESIRE_BRANCH}
git branch --set-upstream-to=gitlab/${META_DESIRE_BRANCH} ${META_DESIRE_BRANCH}
popd

pushd meta-clang
git checkout -b 2020-01-03-zeus
git branch --set-upstream-to=github/2020-01-03-zeus 2020-01-03-zeus
popd

pushd keys-for-signing
git checkout -b master
git branch --set-upstream-to=github/master master
popd

pushd meta-buildutils
git checkout -b 2020-01-03-zeus
git branch --set-upstream-to=github/2020-01-03-zeus 2020-01-03-zeus
popd

pushd meta-bfe
git checkout -b master
git branch --set-upstream-to=gitlab/master master
popd

#pushd meta-java
#git checkout -b 2020-02-13-master-next-as-zeus-3.0+
#git branch --set-upstream-to=github/2020-02-13-master-next-as-zeus-3.0+ 2020-02-13-master-next-as-zeus-3.0+
#popd

# popd sources
popd

pushd scripts

pushd convenience-scripts
git checkout -b master
popd

# popd scripts
popd

pushd crops-container-x86-64

pushd yocto-dockerfiles
git checkout -b 2019-11-19-master-local
git branch
popd

pushd poky-container
git checkout -b 2019-11-19-master-local
git branch
popd

pushd extsdk-container
git checkout -b 2020-01-06-master-local
git branch
popd

# popd crops-container-x86-64
popd


pushd oci-container-x86-64

pushd skopeo-container
git checkout -b master
git branch
popd

# popd oci-container-x86-64
popd

pushd app-container-x86-64

pushd app-container-redis
git checkout master
git branch
popd

pushd app-container-mosquitto
git checkout master
git branch
popd 

pushd app-container-python3-nmap-srv
git checkout master
git branch
popd

pushd app-container-python3-data-collector
git checkout master
git branch
popd

pushd app-container-image-lighttpd-oci
git checkout master
git branch
popd

pushd app-container-mosquitto-oci
git checkout master
git branch
popd

pushd app-container-oci
git checkout master
git branch
popd

pushd app-container-python3-data-collector-oci
git checkout master
git branch
popd

pushd app-container-python3-mastermind-oci
git checkout master
git branch
popd

pushd app-container-python3-mqttbrokerclient-oci
git checkout master
git branch
popd

pushd app-container-python3-nmap-srv-oci
git checkout master
git branch
popd

pushd app-container-redis-oci
git checkout master
git branch
popd

# popd app-container-x86-64
popd

pushd sources

pushd poky
git branch
popd

pushd my-mender-layer
git branch
popd

pushd meta-virtualization
git branch
popd

pushd meta-u-boot-wic-bsp
git branch
popd

pushd meta-u-boot-mender-bsp
git branch
popd

pushd meta-u-boot-karo-wic-bsp
git branch
popd

pushd meta-sca
git branch
popd

pushd meta-resy
git branch
popd

pushd meta-openembedded
git branch
popd

pushd meta-multi-v7-ml-bsp
git branch
popd

pushd meta-mender
git branch
popd

pushd meta-karo-bsp
git branch
popd

pushd meta-desire
git branch
popd

pushd meta-clang
git branch
popd

pushd keys-for-signing
git branch
popd

pushd meta-buildutils
git branch
popd

pushd meta-bfe
git branch
popd

# popd sources
popd

rm -f resy-cooker.sh
wget https://raw.githubusercontent.com/RobertBerger/manifests/master/resy-cooker.sh
chmod +x resy-cooker.sh

rm -f resy-poky-container.sh
wget https://raw.githubusercontent.com/RobertBerger/manifests/master/resy-poky-container.sh
chmod +x resy-poky-container.sh

rm -f resy-sdk-container-installer.sh
wget https://raw.githubusercontent.com/RobertBerger/manifests/master/resy-sdk-container-installer.sh
chmod +x resy-sdk-container-installer.sh

rm -f resy-sdk-container.sh
wget https://raw.githubusercontent.com/RobertBerger/manifests/master/resy-sdk-container.sh
chmod +x resy-sdk-container.sh

rm -f oci-copy-to-docker.sh
wget https://raw.githubusercontent.com/RobertBerger/manifests/master/oci-copy-to-docker.sh
chmod +x oci-copy-to-docker.sh

set +x

echo "new resy.sh:"
echo "rm -f resy.sh.* && wget --no-cache https://raw.githubusercontent.com/RobertBerger/manifests/master/resy.sh && chmod +x resy.sh"
echo "use resy-poky-container.sh to start poky build container"
echo "use resy-cooker.sh inside poky container to set up cooker and bitbake"

set +x


