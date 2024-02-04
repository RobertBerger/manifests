#!/bin/bash
SCRIPTPATH="$( cd -- "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"
echo ${SCRIPTPATH}
set -x
git checkout conf/layer.conf
if ! patch -R -p1 -s -f --dry-run <${SCRIPTPATH}/against-965bcd8da5ad2174bd2ac05811580e44bbb0e036/0001-nanbield-support.patch; then
     patch -p1 <${SCRIPTPATH}/against-965bcd8da5ad2174bd2ac05811580e44bbb0e036/0001-nanbield-support.patch
fi
git checkout recipes-extended/images/update-image.bb
if ! patch -R -p1 -s -f --dry-run <${SCRIPTPATH}/against-965bcd8da5ad2174bd2ac05811580e44bbb0e036/0002-soft-assignment-so-we-can-override.patch; then
     patch -p1 <${SCRIPTPATH}/against-965bcd8da5ad2174bd2ac05811580e44bbb0e036/0002-soft-assignment-so-we-can-override.patch
fi
git diff --stat

git add .
git commit -m "patch typically only against upstream master"

set +x
