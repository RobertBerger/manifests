#!/bin/bash
SCRIPTPATH="$( cd -- "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"
echo ${SCRIPTPATH}
set -x

git checkout meta/recipes-connectivity/connman/connman/connman
if ! patch -R -p1 -s -f --dry-run <${SCRIPTPATH}/against-5d88faa0f35f0205c1475893d8589d1e6533dcc0/0001-connman-allow-rootfs-over-nfs.patch; then
     patch -p1 <${SCRIPTPATH}/against-5d88faa0f35f0205c1475893d8589d1e6533dcc0/0001-connman-allow-rootfs-over-nfs.patch
fi

git checkout meta-poky/conf/distro/poky.conf
if ! patch -R -p1 -s -f --dry-run <${SCRIPTPATH}/against-5d88faa0f35f0205c1475893d8589d1e6533dcc0/0002-poky-snapshot-.66.patch; then
     patch -p1 <${SCRIPTPATH}/against-5d88faa0f35f0205c1475893d8589d1e6533dcc0/0002-poky-snapshot-.66.patch
fi

git checkout meta/recipes-connectivity/resolvconf/resolvconf_1.92.bb
if ! patch -R -p1 -s -f --dry-run <${SCRIPTPATH}/against-5d88faa0f35f0205c1475893d8589d1e6533dcc0/0003-RDEPENDS-skip-e.g.-normalize-resolvconf-with-busybox.patch; then
     patch -p1 <${SCRIPTPATH}/against-5d88faa0f35f0205c1475893d8589d1e6533dcc0/0003-RDEPENDS-skip-e.g.-normalize-resolvconf-with-busybox.patch
fi

git checkout meta/classes-recipe/devicetree.bbclass
if ! patch -R -p1 -s -f --dry-run <${SCRIPTPATH}/against-5d88faa0f35f0205c1475893d8589d1e6533dcc0/0004-devicetreeclass-S-WORKDIR-replaced-with-UNPACKDIR-S-WORKDIR-sources.patch; then
     patch -p1 <${SCRIPTPATH}/against-5d88faa0f35f0205c1475893d8589d1e6533dcc0/0004-devicetreeclass-S-WORKDIR-replaced-with-UNPACKDIR-S-WORKDIR-sources.patch
fi

# made it upstream
#git checkout meta/classes-recipe/populate_sdk_base.bbclass
#if ! patch -R -p1 -s -f --dry-run <${SCRIPTPATH}/against-5d88faa0f35f0205c1475893d8589d1e6533dcc0/0009-uninative-tarball.xz-reproducibility-fix.patch; then
#     patch -p1 <${SCRIPTPATH}/against-5d88faa0f35f0205c1475893d8589d1e6533dcc0/0009-uninative-tarball.xz-reproducibility-fix.patch
#     cat meta/classes-recipe/populate_sdk_base.bbclass | grep SDKTAROPTS
#fi
#cat meta/classes-recipe/populate_sdk_base.bbclass | grep SDKTAROPTS

git checkout scripts/lib/wic/plugins/source/bootimg-pcbios.py
if ! patch -R -p1 -s -f --dry-run <${SCRIPTPATH}/against-5d88faa0f35f0205c1475893d8589d1e6533dcc0/0010-optionally-pass-initrd-from-.wks-.in-via-sourceparam.patch; then
     patch -p1 <${SCRIPTPATH}/against-5d88faa0f35f0205c1475893d8589d1e6533dcc0/0010-optionally-pass-initrd-from-.wks-.in-via-sourceparam.patch
fi

git checkout meta/classes/buildhistory.bbclass
if ! patch -R -p1 -s -f --dry-run <${SCRIPTPATH}/against-5d88faa0f35f0205c1475893d8589d1e6533dcc0/0011-avoid-do_rootfs-Function-buildhistory_get_image_inst.patch; then
     patch -p1 <${SCRIPTPATH}/against-5d88faa0f35f0205c1475893d8589d1e6533dcc0/0011-avoid-do_rootfs-Function-buildhistory_get_image_inst.patch
fi

# --> check if it works also without that and only console defined
#git checkout meta/recipes-core/busybox/busybox-inittab_1.36.1.bb
#if ! patch -R -p1 -s -f --dry-run <${SCRIPTPATH}/against-5d88faa0f35f0205c1475893d8589d1e6533dcc0/0031-busybox-add-SERIAL_CONSOLES_CHECK.patch; then
#     patch -p1 <${SCRIPTPATH}/against-5d88faa0f35f0205c1475893d8589d1e6533dcc0/0031-busybox-add-SERIAL_CONSOLES_CHECK.patch
#fi
#
#git checkout meta/recipes-core/sysvinit/sysvinit-inittab_2.88dsf.bb
#if ! patch -R -p1 -s -f --dry-run <${SCRIPTPATH}/against-5d88faa0f35f0205c1475893d8589d1e6533dcc0/0032-sysvinit-inittab-add-SERIAL_CONSOLES_CHECK.patch; then
#     patch -p1 <${SCRIPTPATH}/against-5d88faa0f35f0205c1475893d8589d1e6533dcc0/0032-sysvinit-inittab-add-SERIAL_CONSOLES_CHECK.patch
#fi
# <--  check if it works also without that and only console defined

git checkout meta/classes/go-vendor.bbclass
if ! patch -R -p1 -s -f --dry-run <${SCRIPTPATH}/against-5d88faa0f35f0205c1475893d8589d1e6533dcc0/0040-avoid-errors-with-absolute-paths-from-go-vendor.bbcl.patch; then
     patch -p1 <${SCRIPTPATH}/against-5d88faa0f35f0205c1475893d8589d1e6533dcc0/0040-avoid-errors-with-absolute-paths-from-go-vendor.bbcl.patch
fi

git checkout  meta/classes-recipe/cargo.bbclass
git checkout  meta/classes-recipe/cargo_common.bbclass
if ! patch -R -p1 -s -f --dry-run <${SCRIPTPATH}/against-5d88faa0f35f0205c1475893d8589d1e6533dcc0/0050-cargo-add-CARGO_NO_FROZEN.patch; then
     patch -p1 <${SCRIPTPATH}/against-5d88faa0f35f0205c1475893d8589d1e6533dcc0/0050-cargo-add-CARGO_NO_FROZEN.patch
fi

git diff --stat

git add .
git commit -m "patch typically only against upstream master"

set +x
