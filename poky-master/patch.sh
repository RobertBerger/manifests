#!/bin/bash
SCRIPTPATH="$( cd -- "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"
echo ${SCRIPTPATH}
set -x
git checkout meta/recipes-connectivity/resolvconf/resolvconf_1.91.bb
if ! patch -R -p1 -s -f --dry-run <${SCRIPTPATH}/against-e816f396964287fcd16c61c76f78ee0025ca2e92/0004-normalize-resolvconf-needs-to-be-installed.patch; then
     patch -p1 <${SCRIPTPATH}/against-e816f396964287fcd16c61c76f78ee0025ca2e92/0004-normalize-resolvconf-needs-to-be-installed.patch
fi
git diff --stat
set +x
