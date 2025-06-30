#!/bin/bash
SCRIPTPATH="$( cd -- "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"
echo ${SCRIPTPATH}
set -x

git checkout meta/recipes-connectivity/connman/connman/connman
if ! patch -R -p1 -s -f --dry-run <${SCRIPTPATH}/against-b88519519fc59298ba6905453cb34d19b26ab794/0001-connman-allow-rootfs-over-nfs.patch; then
     patch -p1 <${SCRIPTPATH}/against-b88519519fc59298ba6905453cb34d19b26ab794/0001-connman-allow-rootfs-over-nfs.patch
fi

git checkout meta-poky/conf/distro/poky.conf
if ! patch -R -p1 -s -f --dry-run <${SCRIPTPATH}/against-b88519519fc59298ba6905453cb34d19b26ab794/0002-poky-snapshot-.66.patch; then
     patch -p1 <${SCRIPTPATH}/against-b88519519fc59298ba6905453cb34d19b26ab794/0002-poky-snapshot-.66.patch
fi

git checkout meta/recipes-connectivity/resolvconf/resolvconf_1.93.bb
rm -f meta/recipes-connectivity/resolvconf/resolvconf/0001-fix-path-to-normalize-resolvconf.patch
rm -f meta/recipes-connectivity/resolvconf/resolvconf/0002-fix-path-to-list-records.patch
rm -f meta/recipes-connectivity/resolvconf/resolvconf/0003-fix-path-to-list-records.patch
rm -f meta/recipes-connectivity/resolvconf
if ! patch -R -p1 -s -f --dry-run <${SCRIPTPATH}/against-b88519519fc59298ba6905453cb34d19b26ab794/0003-fix-path-to-normalize-resolvconf-list-records.patch; then
     patch -p1 <${SCRIPTPATH}/against-b88519519fc59298ba6905453cb34d19b26ab794/0003-fix-path-to-normalize-resolvconf-list-records.patch
fi

# @@@TODO: needs fixing:
git checkout scripts/lib/wic/plugins/source/bootimg-pcbios.py
if ! patch -R -p1 -s -f --dry-run <${SCRIPTPATH}/against-b88519519fc59298ba6905453cb34d19b26ab794/0010-optionally-pass-initrd-from-.wks-.in-via-sourceparam.patch; then
     patch -p1 <${SCRIPTPATH}/against-b88519519fc59298ba6905453cb34d19b26ab794/0010-optionally-pass-initrd-from-.wks-.in-via-sourceparam.patch
fi

git checkout  meta/classes-recipe/cargo.bbclass
git checkout  meta/classes-recipe/cargo_common.bbclass
if ! patch -R -p1 -s -f --dry-run <${SCRIPTPATH}/against-b88519519fc59298ba6905453cb34d19b26ab794/0050-cargo-add-CARGO_NO_FROZEN.patch; then
     patch -p1 <${SCRIPTPATH}/against-b88519519fc59298ba6905453cb34d19b26ab794/0050-cargo-add-CARGO_NO_FROZEN.patch
fi

# yocto kernel tooling follows

#rm -rf scripts/lib/bsp
#rm -rf scripts/yocto-bsp
#rm -rf scripts/yocto-kernel
#if ! patch -R -p1 -s -f --dry-run <${SCRIPTPATH}/against-626031da74b31d0a8c5ca9d5a1acac9a2d55e998/0021-added-kernel-tooling-back-in-bsp-tooling-updated.patch; then
#     patch -p1 <${SCRIPTPATH}/against-626031da74b31d0a8c5ca9d5a1acac9a2d55e998/0021-added-kernel-tooling-back-in-bsp-tooling-updated.patch
#fi
#
#if ! patch -R -p1 -s -f --dry-run <${SCRIPTPATH}/against-626031da74b31d0a8c5ca9d5a1acac9a2d55e998/0022-bsp-initial-styhead-support.patch; then
#     patch -p1 <${SCRIPTPATH}/against-626031da74b31d0a8c5ca9d5a1acac9a2d55e998/0022-bsp-initial-styhead-support.patch
#fi
#
#if ! patch -R -p1 -s -f --dry-run <${SCRIPTPATH}/against-626031da74b31d0a8c5ca9d5a1acac9a2d55e998/0023-SERIAL_CONSOLES-switched-from-many-to-console.patch; then
#     patch -p1 <${SCRIPTPATH}/against-626031da74b31d0a8c5ca9d5a1acac9a2d55e998/0023-SERIAL_CONSOLES-switched-from-many-to-console.patch
#fi

git diff --stat

git add .
git commit -m "patch typically only against upstream master"
set +x
