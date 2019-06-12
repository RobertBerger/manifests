#!/bin/bash
set -x
rm -rf .repo
rm -rf sources
repo init -u https://github.com/RobertBerger/manifests -m resy.xml
repo sync

pushd sources

pushd poky
git checkout -b 2019-05-13-warrior-2.7+
popd
pushd meta-multi-v7-ml-bsp
git checkout -b warrior-v4.19.x
popd
pushd meta-resy
git checkout -b warrior
popd
pushd meta-openembedded
git checkout -b warrior
popd
pushd meta-virtualization
git checkout -b warrior
popd

# popd sources
popd

pushd sources

pushd poky
git branch
popd
pushd meta-multi-v7-ml-bsp
git branch
popd
pushd meta-resy
git branch
popd
pushd meta-openembedded
git branch
popd
pushd meta-virtualization
git branch
popd

# popd sources
popd

set +x

