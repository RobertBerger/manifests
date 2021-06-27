#!/bin/bash
SCRIPTPATH="$( cd -- "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"
echo ${SCRIPTPATH}
set -x
#git checkout recipes-kernel/linux/linux-yocto_virtualization.inc
git checkout meta/classes/package_pkgdata.bbclass
#if ! patch -R -p1 -s -f --dry-run <${SCRIPTPATH}/0001-include-virtio.scc.patch; then
  patch -p1 <${SCRIPTPATH}/0001-exclude-SSTATETASKS-from-package_prepare_pkgdata.patch
#fi
git diff --stat
set +x
