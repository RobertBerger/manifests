#!/bin/bash
SCRIPTPATH="$( cd -- "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"
echo ${SCRIPTPATH}
set -x

git checkout meta/recipes-connectivity/connman/connman/connman
if ! patch -R -p1 -s -f --dry-run <${SCRIPTPATH}/against-1bbdc674aef8abada28d130a23752c1d8a4620b9/0001-connman-allow-rootfs-over-nfs.patch; then
     patch -p1 <${SCRIPTPATH}/against-1bbdc674aef8abada28d130a23752c1d8a4620b9/0001-connman-allow-rootfs-over-nfs.patch
fi

git checkout meta-poky/conf/distro/poky.conf
if ! patch -R -p1 -s -f --dry-run <${SCRIPTPATH}/against-1bbdc674aef8abada28d130a23752c1d8a4620b9/0002-poky-snapshot-.66.patch; then
     patch -p1 <${SCRIPTPATH}/against-1bbdc674aef8abada28d130a23752c1d8a4620b9/0002-poky-snapshot-.66.patch
fi

git checkout meta/recipes-connectivity/resolvconf/resolvconf_1.92.bb
if ! patch -R -p1 -s -f --dry-run <${SCRIPTPATH}/against-1bbdc674aef8abada28d130a23752c1d8a4620b9/0003-RDEPENDS-skip-e.g.-normalize-resolvconf-with-busybox.patch; then
     patch -p1 <${SCRIPTPATH}/against-1bbdc674aef8abada28d130a23752c1d8a4620b9/0003-RDEPENDS-skip-e.g.-normalize-resolvconf-with-busybox.patch
fi

# made it upstream
#git checkout meta/classes-recipe/populate_sdk_base.bbclass
#if ! patch -R -p1 -s -f --dry-run <${SCRIPTPATH}/against-1bbdc674aef8abada28d130a23752c1d8a4620b9/0009-uninative-tarball.xz-reproducibility-fix.patch; then
#     patch -p1 <${SCRIPTPATH}/against-1bbdc674aef8abada28d130a23752c1d8a4620b9/0009-uninative-tarball.xz-reproducibility-fix.patch
#     cat meta/classes-recipe/populate_sdk_base.bbclass | grep SDKTAROPTS
#fi
#cat meta/classes-recipe/populate_sdk_base.bbclass | grep SDKTAROPTS

git checkout scripts/lib/wic/plugins/source/bootimg-pcbios.py
if ! patch -R -p1 -s -f --dry-run <${SCRIPTPATH}/against-1bbdc674aef8abada28d130a23752c1d8a4620b9/0010-optionally-pass-initrd-from-.wks-.in-via-sourceparam.patch; then
     patch -p1 <${SCRIPTPATH}/against-1bbdc674aef8abada28d130a23752c1d8a4620b9/0010-optionally-pass-initrd-from-.wks-.in-via-sourceparam.patch
fi

git checkout meta/classes/buildhistory.bbclass
if ! patch -R -p1 -s -f --dry-run <${SCRIPTPATH}/against-1bbdc674aef8abada28d130a23752c1d8a4620b9/0011-avoid-do_rootfs-Function-buildhistory_get_image_inst.patch; then
     patch -p1 <${SCRIPTPATH}/against-1bbdc674aef8abada28d130a23752c1d8a4620b9/0011-avoid-do_rootfs-Function-buildhistory_get_image_inst.patch
fi

git checkout meta/recipes-core/busybox/busybox-inittab_1.36.1.bb
if ! patch -R -p1 -s -f --dry-run <${SCRIPTPATH}/against-1bbdc674aef8abada28d130a23752c1d8a4620b9/0031-busybox-add-SERIAL_CONSOLES_CHECK.patch; then
     patch -p1 <${SCRIPTPATH}/against-1bbdc674aef8abada28d130a23752c1d8a4620b9/0031-busybox-add-SERIAL_CONSOLES_CHECK.patch
fi

git checkout meta/recipes-core/sysvinit/sysvinit-inittab_2.88dsf.bb
if ! patch -R -p1 -s -f --dry-run <${SCRIPTPATH}/against-1bbdc674aef8abada28d130a23752c1d8a4620b9/0032-sysvinit-inittab-add-SERIAL_CONSOLES_CHECK.patch; then
     patch -p1 <${SCRIPTPATH}/against-1bbdc674aef8abada28d130a23752c1d8a4620b9/0032-sysvinit-inittab-add-SERIAL_CONSOLES_CHECK.patch
fi

git diff --stat
set +x
