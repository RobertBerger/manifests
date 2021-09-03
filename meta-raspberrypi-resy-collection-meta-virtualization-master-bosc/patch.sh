#!/bin/bash
SCRIPTPATH="$( cd -- "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"
echo ${SCRIPTPATH}
set -x
#git checkout recipes-containers/oci-image-spec/oci-image-spec_git.bb
git checkout recipes-kernel/linux/linux-yocto_virtualization.inc
rm -f recipes-kernel/linux/yocto-cfg-fragments.bb
#patch -p1 <${SCRIPTPATH}/0001-include-virtio.scc.patch
patch -p1 <${SCRIPTPATH}/0002-oci-image-spec-master-main.patch
patch -p1 <${SCRIPTPATH}/0003-magic-KERNEL_CACHE_FEATURES.patch
patch -p1 <${SCRIPTPATH}/0004-magic-yocto-cfg-fragments.patch
git diff --stat
set +x
