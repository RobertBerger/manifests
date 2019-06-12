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
popd

pushd sources
pushd poky
git branch
popd
pushd meta-multi-v7-ml-bsp
git branch
popd
popd

set +x

