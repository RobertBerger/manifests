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

  select machine in 'container-x86-64' 'native'
  do
    echo "MACHINE: $machine"
    break;
  done

  if [ "$machine" == "container-x86-64" ]; then
     export TEMPLATECONF="../meta-resy/template-${machine}"
     echo "TEMPLATECONF: ${TEMPLATECONF}"
     echo "source ../sources/poky/oe-init-build-env ${machine}"
     source ../sources/poky/oe-init-build-env ${machine}
     cp ../../sources/meta-resy/template-common/site.conf.sample conf/site.conf
     tree conf
  fi

