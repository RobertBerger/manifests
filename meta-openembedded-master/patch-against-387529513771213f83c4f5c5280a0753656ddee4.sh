#!/bin/bash
SCRIPTPATH="$( cd -- "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"
echo ${SCRIPTPATH}
set -x

git checkout meta-oe/recipes-kernel/agent-proxy/agent-proxy_1.97.bb
if ! patch -R -p1 -s -f --dry-run <${SCRIPTPATH}/against-387529513771213f83c4f5c5280a0753656ddee4/0001-agent-proxy-ignore-buildpaths-QA-warning.patch; then
     patch -p1 <${SCRIPTPATH}/against-387529513771213f83c4f5c5280a0753656ddee4/0001-agent-proxy-ignore-buildpaths-QA-warning.patch
fi

git checkout meta-oe/recipes-support/monit/monit_5.34.0.bb
if ! patch -R -p1 -s -f --dry-run <${SCRIPTPATH}/against-387529513771213f83c4f5c5280a0753656ddee4/0002-on-target-add-etc-monit.d-to-avoid-dir-file-not-foun.patch; then
     patch -p1 <${SCRIPTPATH}/against-387529513771213f83c4f5c5280a0753656ddee4/0002-on-target-add-etc-monit.d-to-avoid-dir-file-not-foun.patch
fi

# upstream?
#git checkout meta-oe/recipes-core/uutils-coreutils/uutils-coreutils_0.0.27.bb
#if ! patch -R -p1 -s -f --dry-run <${SCRIPTPATH}/against-387529513771213f83c4f5c5280a0753656ddee4/0003-uutils-coreutils-ERROR_QA-remove-buildpaths.patch; then
#     patch -p1 <${SCRIPTPATH}/against-387529513771213f83c4f5c5280a0753656ddee4/0003-uutils-coreutils-ERROR_QA-remove-buildpaths.patch
#fi

git diff --stat

git add .
git commit -m "patch typically only against upstream master"

set +x
