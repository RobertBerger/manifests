#!/bin/bash
SCRIPTPATH="$( cd -- "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"
echo ${SCRIPTPATH}
set -x

git checkout meta/recipes-connectivity/connman/connman/connman
if ! patch -R -p1 -s -f --dry-run <${SCRIPTPATH}/against-7ec846be8be10183e2d69bc272a82a7611dfe286/0001-connman-allow-rootfs-over-nfs.patch; then
     patch -p1 <${SCRIPTPATH}/against-7ec846be8be10183e2d69bc272a82a7611dfe286/0001-connman-allow-rootfs-over-nfs.patch
fi

git checkout meta-poky/conf/distro/poky.conf
if ! patch -R -p1 -s -f --dry-run <${SCRIPTPATH}/against-7ec846be8be10183e2d69bc272a82a7611dfe286/0002-poky-snapshot-.66.patch; then
     patch -p1 <${SCRIPTPATH}/against-7ec846be8be10183e2d69bc272a82a7611dfe286/0002-poky-snapshot-.66.patch
fi

git checkout meta/recipes-connectivity/resolvconf/resolvconf_1.91.bb
if ! patch -R -p1 -s -f --dry-run <${SCRIPTPATH}/against-7ec846be8be10183e2d69bc272a82a7611dfe286/0003-RDEPENDS-skip-e.g.-normalize-resolvconf-with-busybox.patch; then
     patch -p1 <${SCRIPTPATH}/against-7ec846be8be10183e2d69bc272a82a7611dfe286/0003-RDEPENDS-skip-e.g.-normalize-resolvconf-with-busybox.patch
fi

rm -rf scripts/lib/bsp
rm -rf scripts/yocto-bsp
rm -rf scripts/yocto-kernel
if ! patch -R -p1 -s -f --dry-run <${SCRIPTPATH}/against-7ec846be8be10183e2d69bc272a82a7611dfe286/0011-added-kernel-tooling-back-in-bsp-tooling-updated.patch; then
     patch -p1 <${SCRIPTPATH}/against-7ec846be8be10183e2d69bc272a82a7611dfe286/0011-added-kernel-tooling-back-in-bsp-tooling-updated.patch
fi

if ! patch -R -p1 -s -f --dry-run <${SCRIPTPATH}/against-7ec846be8be10183e2d69bc272a82a7611dfe286/0012-bsp-initial-langdale-support.patch; then
     patch -p1 <${SCRIPTPATH}/against-7ec846be8be10183e2d69bc272a82a7611dfe286/0012-bsp-initial-langdale-support.patch
fi

git diff --stat
set +x
