#!/bin/bash
SCRIPTPATH="$( cd -- "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"
echo ${SCRIPTPATH}
set -x
git checkout conf/layer.conf
if ! patch -R -p1 -s -f --dry-run <${SCRIPTPATH}/against-df7a843eba850882fe0b843d827314d939267395/0001-update-to-scarthgap-styhead.patch; then
     patch -p1 <${SCRIPTPATH}/against-df7a843eba850882fe0b843d827314d939267395/0001-update-to-scarthgap-styhead.patch
fi
git checkout recipes-extended/images/update-image.bb
if ! patch -R -p1 -s -f --dry-run <${SCRIPTPATH}/against-df7a843eba850882fe0b843d827314d939267395/0002-soft-assignment-so-we-can-override.patch; then
     patch -p1 <${SCRIPTPATH}/against-df7a843eba850882fe0b843d827314d939267395/0002-soft-assignment-so-we-can-override.patch
fi
git diff --stat

git add .
git commit -m "patch typically only against upstream master"

set +x
