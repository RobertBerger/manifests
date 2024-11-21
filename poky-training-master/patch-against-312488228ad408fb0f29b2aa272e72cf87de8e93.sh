#!/bin/bash
SCRIPTPATH="$( cd -- "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"
echo ${SCRIPTPATH}
set -x

git checkout meta/recipes-connectivity/connman/connman/connman
if ! patch -R -p1 -s -f --dry-run <${SCRIPTPATH}/against-312488228ad408fb0f29b2aa272e72cf87de8e93/0001-connman-allow-rootfs-over-nfs.patch; then
     patch -p1 <${SCRIPTPATH}/against-312488228ad408fb0f29b2aa272e72cf87de8e93/0001-connman-allow-rootfs-over-nfs.patch
fi

git checkout meta-poky/conf/distro/poky.conf
if ! patch -R -p1 -s -f --dry-run <${SCRIPTPATH}/against-312488228ad408fb0f29b2aa272e72cf87de8e93/0002-poky-snapshot-.66.patch; then
     patch -p1 <${SCRIPTPATH}/against-312488228ad408fb0f29b2aa272e72cf87de8e93/0002-poky-snapshot-.66.patch
fi

git checkout meta/recipes-connectivity/resolvconf/resolvconf_1.92.bb
if ! patch -R -p1 -s -f --dry-run <${SCRIPTPATH}/against-312488228ad408fb0f29b2aa272e72cf87de8e93/0003-RDEPENDS-skip-e.g.-normalize-resolvconf-with-busybox.patch; then
     patch -p1 <${SCRIPTPATH}/against-312488228ad408fb0f29b2aa272e72cf87de8e93/0003-RDEPENDS-skip-e.g.-normalize-resolvconf-with-busybox.patch
fi

# made it upstream?
#git checkout meta/classes-recipe/devicetree.bbclass
#if ! patch -R -p1 -s -f --dry-run <${SCRIPTPATH}/against-312488228ad408fb0f29b2aa272e72cf87de8e93/0004-devicetreeclass-S-WORKDIR-replaced-with-UNPACKDIR-S-WORKDIR-sources.patch; then
#     patch -p1 <${SCRIPTPATH}/against-312488228ad408fb0f29b2aa272e72cf87de8e93/0004-devicetreeclass-S-WORKDIR-replaced-with-UNPACKDIR-S-WORKDIR-sources.patch
#fi

# made it upstream
#git checkout meta/classes-recipe/populate_sdk_base.bbclass
#if ! patch -R -p1 -s -f --dry-run <${SCRIPTPATH}/against-5d88faa0f35f0205c1475893d8589d1e6533dcc0/0009-uninative-tarball.xz-reproducibility-fix.patch; then
#     patch -p1 <${SCRIPTPATH}/against-5d88faa0f35f0205c1475893d8589d1e6533dcc0/0009-uninative-tarball.xz-reproducibility-fix.patch
#     cat meta/classes-recipe/populate_sdk_base.bbclass | grep SDKTAROPTS
#fi
#cat meta/classes-recipe/populate_sdk_base.bbclass | grep SDKTAROPTS

git checkout scripts/lib/wic/plugins/source/bootimg-pcbios.py
if ! patch -R -p1 -s -f --dry-run <${SCRIPTPATH}/against-312488228ad408fb0f29b2aa272e72cf87de8e93/0010-optionally-pass-initrd-from-.wks-.in-via-sourceparam.patch; then
     patch -p1 <${SCRIPTPATH}/against-312488228ad408fb0f29b2aa272e72cf87de8e93/0010-optionally-pass-initrd-from-.wks-.in-via-sourceparam.patch
fi

git checkout meta/classes/buildhistory.bbclass
if ! patch -R -p1 -s -f --dry-run <${SCRIPTPATH}/against-312488228ad408fb0f29b2aa272e72cf87de8e93/0011-avoid-do_rootfs-Function-buildhistory_get_image_inst.patch; then
     patch -p1 <${SCRIPTPATH}/against-312488228ad408fb0f29b2aa272e72cf87de8e93/0011-avoid-do_rootfs-Function-buildhistory_get_image_inst.patch
fi

# --> check if it works also without that and only console defined
#git checkout meta/recipes-core/busybox/busybox-inittab_1.36.1.bb
#if ! patch -R -p1 -s -f --dry-run <${SCRIPTPATH}/against-312488228ad408fb0f29b2aa272e72cf87de8e93/0031-busybox-add-SERIAL_CONSOLES_CHECK.patch; then
#     patch -p1 <${SCRIPTPATH}/against-312488228ad408fb0f29b2aa272e72cf87de8e93/0031-busybox-add-SERIAL_CONSOLES_CHECK.patch
#fi
#
#git checkout meta/recipes-core/sysvinit/sysvinit-inittab_2.88dsf.bb
#if ! patch -R -p1 -s -f --dry-run <${SCRIPTPATH}/against-312488228ad408fb0f29b2aa272e72cf87de8e93/0032-sysvinit-inittab-add-SERIAL_CONSOLES_CHECK.patch; then
#     patch -p1 <${SCRIPTPATH}/against-312488228ad408fb0f29b2aa272e72cf87de8e93/0032-sysvinit-inittab-add-SERIAL_CONSOLES_CHECK.patch
#fi
# <--  check if it works also without that and only console defined

git checkout meta/classes/go-vendor.bbclass
if ! patch -R -p1 -s -f --dry-run <${SCRIPTPATH}/against-312488228ad408fb0f29b2aa272e72cf87de8e93/0040-avoid-errors-with-absolute-paths-from-go-vendor.bbcl.patch; then
     patch -p1 <${SCRIPTPATH}/against-312488228ad408fb0f29b2aa272e72cf87de8e93/0040-avoid-errors-with-absolute-paths-from-go-vendor.bbcl.patch
fi

# this is also against the go-vendor.bbclass
if ! patch -R -p1 -s -f --dry-run <${SCRIPTPATH}/against-312488228ad408fb0f29b2aa272e72cf87de8e93/0041-go-vendor-WORKDIR-UNPACKDIR.patch; then
     patch -p1 <${SCRIPTPATH}/against-312488228ad408fb0f29b2aa272e72cf87de8e93/0041-go-vendor-WORKDIR-UNPACKDIR.patch
fi

git checkout  meta/classes-recipe/cargo.bbclass
git checkout  meta/classes-recipe/cargo_common.bbclass
if ! patch -R -p1 -s -f --dry-run <${SCRIPTPATH}/against-312488228ad408fb0f29b2aa272e72cf87de8e93/0050-cargo-add-CARGO_NO_FROZEN.patch; then
     patch -p1 <${SCRIPTPATH}/against-312488228ad408fb0f29b2aa272e72cf87de8e93/0050-cargo-add-CARGO_NO_FROZEN.patch
fi

# yocto kernel tooling follows

rm -rf scripts/lib/bsp
rm -rf scripts/yocto-bsp
rm -rf scripts/yocto-kernel
if ! patch -R -p1 -s -f --dry-run <${SCRIPTPATH}/against-312488228ad408fb0f29b2aa272e72cf87de8e93/0021-added-kernel-tooling-back-in-bsp-tooling-updated.patch; then
     patch -p1 <${SCRIPTPATH}/against-312488228ad408fb0f29b2aa272e72cf87de8e93/0021-added-kernel-tooling-back-in-bsp-tooling-updated.patch
fi

if ! patch -R -p1 -s -f --dry-run <${SCRIPTPATH}/against-312488228ad408fb0f29b2aa272e72cf87de8e93/0022-bsp-initial-styhead-support.patch; then
     patch -p1 <${SCRIPTPATH}/against-312488228ad408fb0f29b2aa272e72cf87de8e93/0022-bsp-initial-styhead-support.patch
fi

if ! patch -R -p1 -s -f --dry-run <${SCRIPTPATH}/against-312488228ad408fb0f29b2aa272e72cf87de8e93/0023-SERIAL_CONSOLES-switched-from-many-to-console.patch; then
     patch -p1 <${SCRIPTPATH}/against-312488228ad408fb0f29b2aa272e72cf87de8e93/0023-SERIAL_CONSOLES-switched-from-many-to-console.patch
fi

git diff --stat

git add .
git commit -m "patch typically only against upstream master"
set +x
