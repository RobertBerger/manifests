#!/bin/bash
SCRIPTPATH="$( cd -- "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"
echo ${SCRIPTPATH}
set -x

git checkout meta/recipes-connectivity/resolvconf/resolvconf_1.91.bb
if ! patch -R -p1 -s -f --dry-run <${SCRIPTPATH}/against-3670f3685e63345df0501f26acad2044e3544d7b/0001-added-normalize-resolvconf.patch; then
     patch -p1 <${SCRIPTPATH}/against-3670f3685e63345df0501f26acad2044e3544d7b/0001-added-normalize-resolvconf.patch
fi

git checkout meta/recipes-connectivity/connman/connman/connman
if ! patch -R -p1 -s -f --dry-run <${SCRIPTPATH}/against-3670f3685e63345df0501f26acad2044e3544d7b/0002-connman-allow-rootfs-over-nfs.patch; then
     patch -p1 <${SCRIPTPATH}/against-3670f3685e63345df0501f26acad2044e3544d7b/0002-connman-allow-rootfs-over-nfs.patch
fi

git checkout meta-poky/conf/distro/poky.conf
if ! patch -R -p1 -s -f --dry-run <${SCRIPTPATH}/against-3670f3685e63345df0501f26acad2044e3544d7b/0003-poky-snapshot-.66.patch; then
     patch -p1 <${SCRIPTPATH}/against-3670f3685e63345df0501f26acad2044e3544d7b/0003-poky-snapshot-.66.patch
fi

rm -rf scripts/lib/bsp
rm -rf scripts/yocto-bsp
rm -rf scripts/yocto-kernel
if ! patch -R -p1 -s -f --dry-run <${SCRIPTPATH}/against-3670f3685e63345df0501f26acad2044e3544d7b/0011-added-kernel-tooling-back-in-bsp-tooling-update.patch; then
     patch -p1 <${SCRIPTPATH}/against-3670f3685e63345df0501f26acad2044e3544d7b/0011-added-kernel-tooling-back-in-bsp-tooling-update.patch
fi

if ! patch -R -p1 -s -f --dry-run <${SCRIPTPATH}/against-3670f3685e63345df0501f26acad2044e3544d7b/0012-bsp-initial-langdale-support.patch; then
     patch -p1 <${SCRIPTPATH}/against-3670f3685e63345df0501f26acad2044e3544d7b/0012-bsp-initial-langdale-support.patch
fi

git diff --stat
set +x
