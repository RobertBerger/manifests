#!/bin/bash
SCRIPTPATH="$( cd -- "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"
echo ${SCRIPTPATH}
set -x
git checkout conf/layer.conf
if ! patch -R -p1 -s -f --dry-run <${SCRIPTPATH}/against-4189ecc0cfc26ffba5975159f33ea48807a0408c/0001-added-langdale-kirkstone.patch; then
     patch -p1 <${SCRIPTPATH}/against-4189ecc0cfc26ffba5975159f33ea48807a0408c/0001-added-langdale-kirkstone.patch
fi
git checkout recipes-extended/images/update-image.bb
if ! patch -R -p1 -s -f --dry-run <${SCRIPTPATH}/against-4189ecc0cfc26ffba5975159f33ea48807a0408c/0002-soft-assignment-so-we-can-override.patch; then
     patch -p1 <${SCRIPTPATH}/against-4189ecc0cfc26ffba5975159f33ea48807a0408c/0002-soft-assignment-so-we-can-override.patch
fi
git diff --stat
set +x
