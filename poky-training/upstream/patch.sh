#!/bin/bash
SCRIPTPATH="$( cd -- "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"
echo ${SCRIPTPATH}
set -x

git checkout meta/classes-recipe/populate_sdk_base.bbclass
if ! patch -R -p1 -s -f --dry-run <${SCRIPTPATH}/against-f21c1dd4f46ffcc951e08e9b94256ba6ee97b670/0001-uninative-tarball.xz-reproducibility-fix.patch; then
     patch -p1 <${SCRIPTPATH}/against-f21c1dd4f46ffcc951e08e9b94256ba6ee97b670/0001-uninative-tarball.xz-reproducibility-fix.patch
fi

git diff --stat
set +x
