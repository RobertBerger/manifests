#!/bin/bash
SCRIPTPATH="$( cd -- "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"
echo ${SCRIPTPATH}
set -x
git checkout meta/recipes-connectivity/resolvconf/resolvconf_1.91.bb
if ! patch -R -p1 -s -f --dry-run <${SCRIPTPATH}/against-3670f3685e63345df0501f26acad2044e3544d7b/0001-added-normalize-resolvconf.patch; then
     patch -p1 <${SCRIPTPATH}/against-3670f3685e63345df0501f26acad2044e3544d7b/0001-added-normalize-resolvconf.patch
fi
git diff --stat
set +x
