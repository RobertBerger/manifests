#!/bin/bash
SCRIPTPATH="$( cd -- "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"
echo ${SCRIPTPATH}
set -x

git checkout meta/recipes-connectivity/connman/connman/connman
if ! patch -R -p1 -s -f --dry-run <${SCRIPTPATH}/against-3eff0eb5ea77de20d85a2ffc64652579cbd7755c/0001-connman-allow-rootfs-over-nfs.patch; then
     patch -p1 <${SCRIPTPATH}/against-3eff0eb5ea77de20d85a2ffc64652579cbd7755c/0001-connman-allow-rootfs-over-nfs.patch
fi

git checkout meta-poky/conf/distro/poky.conf
if ! patch -R -p1 -s -f --dry-run <${SCRIPTPATH}/against-3eff0eb5ea77de20d85a2ffc64652579cbd7755c/0002-poky-snapshot-.66.patch; then
     patch -p1 <${SCRIPTPATH}/against-3eff0eb5ea77de20d85a2ffc64652579cbd7755c/0002-poky-snapshot-.66.patch
fi

git checkout meta/recipes-connectivity/resolvconf/resolvconf_1.91.bb
if ! patch -R -p1 -s -f --dry-run <${SCRIPTPATH}/against-3eff0eb5ea77de20d85a2ffc64652579cbd7755c/0003-RDEPENDS-skip-e.g.-normalize-resolvconf-with-busybox.patch; then
     patch -p1 <${SCRIPTPATH}/against-3eff0eb5ea77de20d85a2ffc64652579cbd7755c/0003-RDEPENDS-skip-e.g.-normalize-resolvconf-with-busybox.patch
fi

if ! patch -R -p1 -s -f --dry-run <${SCRIPTPATH}/against-3eff0eb5ea77de20d85a2ffc64652579cbd7755c/0004-resolveconf-more-explanations-still-unclear.patch; then
     patch -p1 <${SCRIPTPATH}/against-3eff0eb5ea77de20d85a2ffc64652579cbd7755c/0004-resolveconf-more-explanations-still-unclear.patch
fi

git checkout meta/classes-recipe/populate_sdk_base.bbclass
if ! patch -R -p1 -s -f --dry-run <${SCRIPTPATH}/against-3eff0eb5ea77de20d85a2ffc64652579cbd7755c/0009-uninative-tarball.xz-reproducibility-fix.patch; then
     patch -p1 <${SCRIPTPATH}/against-3eff0eb5ea77de20d85a2ffc64652579cbd7755c/0009-uninative-tarball.xz-reproducibility-fix.patch
fi

git checkout scripts/lib/wic/plugins/source/bootimg-pcbios.py
if ! patch -R -p1 -s -f --dry-run <${SCRIPTPATH}/against-3eff0eb5ea77de20d85a2ffc64652579cbd7755c/0010-optionally-pass-initrd-from-.wks-.in-via-sourceparam.patch; then
     patch -p1 <${SCRIPTPATH}/against-3eff0eb5ea77de20d85a2ffc64652579cbd7755c/0010-optionally-pass-initrd-from-.wks-.in-via-sourceparam.patch
fi

git diff --stat
set +x
