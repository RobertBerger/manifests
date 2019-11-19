#!/bin/bash

echo "This script will kill everything"
echo "and grab everything from scratch"

read -r -p "Are you sure? [y/N] " response
case "$response" in
    [yY][eE][sS]|[yY]) 
        echo "killing!"
        ;;
    *)
        exit
        ;;
esac

set -x
rm -rf .repo
rm -rf sources
rm -rf scripts
rm -rf build
rm -rf app-container-x86-64
set +x

# choose manifest

  select manifest in 'bleeding' 'stable'
  do
    echo "MANIFEST: $manifest"
    break;
  done


  if [ "$manifest" == "bleeding" ]; then
     export MANIFEST="resy-bleeding.xml"
     export META_RESY_BRANCH="master"
     export META_DESIRE_BRANCH="master"
     export META_U_BOOT_KARO_WIC_BSP_BRANCH="master"
     export META_U_BOOT_MENDER_BSP_BRANCH="master"
     export META_KARO_BSP_BRANCH="master"
  fi

  if [ "$manifest" == "stable" ]; then
     export MANIFEST="resy.xml"
     export META_RESY_BRANCH="warrior"
     export META_DESIRE_BRANCH="warrior"
     export META_U_BOOT_KARO_WIC_BSP_BRANCH="warrior"
     export META_U_BOOT_MENDER_BSP_BRANCH="warrior"
     export META_KARO_BSP_BRANCH="warrior"
  fi

set -x
repo init -u https://github.com/RobertBerger/manifests -m ${MANIFEST}
repo sync

pushd sources

pushd poky
git checkout -b 2019-05-13-warrior-2.7+
git branch --set-upstream-to=github/2019-05-13-warrior-2.7+ 2019-05-13-warrior-2.7+
popd

pushd my-mender-layer
git checkout -b master
git branch --set-upstream-to=github/master master
popd

pushd meta-virtualization
git checkout -b 2019-09-09-warrior-2.7+
git branch --set-upstream-to=yocto/2019-09-09-warrior-2.7+ 2019-09-09-warrior-2.7+
popd

pushd meta-u-boot-wic-bsp
git checkout -b warrior
git branch --set-upstream-to=gitlab/warrior warrior
popd

pushd meta-u-boot-mender-bsp
git checkout -b ${META_U_BOOT_MENDER_BSP_BRANCH}
git branch --set-upstream-to=gitlab/${META_U_BOOT_MENDER_BSP_BRANCH} ${META_U_BOOT_MENDER_BSP_BRANCH}
popd

pushd meta-u-boot-karo-wic-bsp
git checkout -b ${META_U_BOOT_KARO_WIC_BSP_BRANCH}
git branch --set-upstream-to=gitlab/${META_U_BOOT_KARO_WIC_BSP_BRANCH} ${META_U_BOOT_KARO_WIC_BSP_BRANCH}
popd

pushd meta-sca
git checkout -b 2019-09-10-sca-v1.16-warrior-2.7
git branch --set-upstream-to=github/2019-09-10-sca-v1.16-warrior-2.7 2019-09-10-sca-v1.16-warrior-2.7
popd

pushd meta-resy
git checkout -b ${META_RESY_BRANCH}
git branch --set-upstream-to=gitlab/${META_RESY_BRANCH} ${META_RESY_BRANCH}
popd

pushd meta-openembedded
git checkout -b warrior
git branch --set-upstream-to=github/warrior warrior
popd

pushd meta-multi-v7-ml-bsp
git checkout -b warrior-v4.19.x
git branch --set-upstream-to=gitlab/warrior-v4.19.x warrior-v4.19.x
popd

pushd meta-mender
git checkout -b 2019-09-10-thud-as-warrior
git branch --set-upstream-to=github/2019-09-10-thud-as-warrior 2019-09-10-thud-as-warrior
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
git checkout -b 2019-09-10-warrior
git branch --set-upstream-to=github/2019-09-10-warrior 2019-09-10-warrior
popd

pushd keys-for-signing
git checkout -b master
git branch --set-upstream-to=github/master master
popd

pushd meta-buildutils
git checkout -b 2019-09-10-warrior
git branch --set-upstream-to=github/2019-09-10-warrior 2019-09-10-warrior
popd

pushd meta-bfe
git checkout -b master
git branch --set-upstream-to=gitlab/master master
popd


# popd sources
popd

pushd scripts

pushd convenience-scripts
git checkout -b master
popd

# popd scripts
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

set +x

echo "new resy.sh:"
echo "rm -f resy.sh && wget https://raw.githubusercontent.com/RobertBerger/manifests/master/resy.sh && chmod +x resy.sh"
echo "use resy-cooker.sh to set up build environment"

set +x


