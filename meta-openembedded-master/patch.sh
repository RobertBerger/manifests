#!/bin/bash
SCRIPTPATH="$( cd -- "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"
echo ${SCRIPTPATH}
set -x

# upstream ?
#git checkout meta-oe/recipes-kernel/agent-proxy/agent-proxy_1.97.bb
#if ! patch -R -p1 -s -f --dry-run <${SCRIPTPATH}/against-5afc38b504bc891d228ae246d72d29d3a7d3be52/0001-agent-proxy-ignore-buildpaths-QA-warning.patch; then
#     patch -p1 <${SCRIPTPATH}/against-5afc38b504bc891d228ae246d72d29d3a7d3be52/0001-agent-proxy-ignore-buildpaths-QA-warning.patch
#fi

git checkout meta-oe/recipes-support/monit/monit_5.34.4.bb
if ! patch -R -p1 -s -f --dry-run <${SCRIPTPATH}/against-2920d4909236106e1a36d56b3b20762a308ba3d4/0002-on-target-add-etc-monit.d-to-avoid-dir-file-not-foun.patch; then
     patch -p1 <${SCRIPTPATH}/against-2920d4909236106e1a36d56b3b20762a308ba3d4/0002-on-target-add-etc-monit.d-to-avoid-dir-file-not-foun.patch
fi

# upstream?
#git checkout meta-oe/recipes-core/uutils-coreutils/uutils-coreutils_0.0.27.bb
#if ! patch -R -p1 -s -f --dry-run <${SCRIPTPATH}/against-5afc38b504bc891d228ae246d72d29d3a7d3be52/0003-uutils-coreutils-ERROR_QA-remove-buildpaths.patch; then
#     patch -p1 <${SCRIPTPATH}/against-5afc38b504bc891d228ae246d72d29d3a7d3be52/0003-uutils-coreutils-ERROR_QA-remove-buildpaths.patch
#fi

# crash 8.0.5 -> crash 8.0.6
# git checkout meta-oe/recipces-kernel/crash/*
if ! patch -R -p1 -s -f --dry-run <${SCRIPTPATH}/against-2920d4909236106e1a36d56b3b20762a308ba3d4/0003-crash-8.0.5-8.0.6.patch; then
     patch -p1 <${SCRIPTPATH}/against-2920d4909236106e1a36d56b3b20762a308ba3d4/0003-crash-8.0.5-8.0.6.patch
fi

# crash memory driver support
if ! patch -R -p1 -s -f --dry-run <${SCRIPTPATH}/against-2920d4909236106e1a36d56b3b20762a308ba3d4/0004-crash-crash-memory-driver-support-added.patch; then
     patch -p1 <${SCRIPTPATH}/against-2920d4909236106e1a36d56b3b20762a308ba3d4/0004-crash-crash-memory-driver-support-added.patch
fi     

git diff --stat

git add .
git commit -m "patch typically only against upstream master"

set +x
