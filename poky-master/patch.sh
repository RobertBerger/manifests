#!/bin/bash
SCRIPTPATH="$( cd -- "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"
echo ${SCRIPTPATH}
set -x

git checkout meta/recipes-connectivity/connman/connman/connman
if ! patch -R -p1 -s -f --dry-run <${SCRIPTPATH}/against-d221e59a5067266c3f620259a1e56a56823df1fb/0001-connman-allow-rootfs-over-nfs.patch; then
     patch -p1 <${SCRIPTPATH}/against-d221e59a5067266c3f620259a1e56a56823df1fb/0001-connman-allow-rootfs-over-nfs.patch
fi

git checkout meta-poky/conf/distro/poky.conf
if ! patch -R -p1 -s -f --dry-run <${SCRIPTPATH}/against-d221e59a5067266c3f620259a1e56a56823df1fb/0002-poky-snapshot-.66.patch; then
     patch -p1 <${SCRIPTPATH}/against-d221e59a5067266c3f620259a1e56a56823df1fb/0002-poky-snapshot-.66.patch
fi

git checkout meta/recipes-connectivity/resolvconf/resolvconf_1.91.bb
if ! patch -R -p1 -s -f --dry-run <${SCRIPTPATH}/against-d221e59a5067266c3f620259a1e56a56823df1fb/0003-RDEPENDS-skip-e.g.-normalize-resolvconf-with-busybox.patch; then
     patch -p1 <${SCRIPTPATH}/against-d221e59a5067266c3f620259a1e56a56823df1fb/0003-RDEPENDS-skip-e.g.-normalize-resolvconf-with-busybox.patch
fi

if ! patch -R -p1 -s -f --dry-run <${SCRIPTPATH}/against-d221e59a5067266c3f620259a1e56a56823df1fb/0004-resolveconf-more-explanations-still-unclear.patch; then
     patch -p1 <${SCRIPTPATH}/against-d221e59a5067266c3f620259a1e56a56823df1fb/0004-resolveconf-more-explanations-still-unclear.patch
fi

git diff --stat
set +x
