#!/bin/bash
SCRIPTPATH="$( cd -- "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"
echo ${SCRIPTPATH}
set -x

git checkout meta-oe/recipes-support/monit/monit_5.35.2.bb
if ! patch -R -p1 -s -f --dry-run <${SCRIPTPATH}/against-a8dfd10600035a799abae03178fc7054582ea43d/0002-on-target-add-etc-monit.d-to-avoid-dir-file-not-foun.patch; then
     patch -p1 <${SCRIPTPATH}/against-a8dfd10600035a799abae03178fc7054582ea43d/0002-on-target-add-etc-monit.d-to-avoid-dir-file-not-foun.patch
fi

git checkout meta-oe/recipes-kernel/crash/crash.inc
if ! patch -R -p1 -s -f --dry-run <${SCRIPTPATH}/against-a8dfd10600035a799abae03178fc7054582ea43d/0003-reference-to-TMPDIR-ERROR-WARNING.patch; then
     patch -p1 <${SCRIPTPATH}/against-a8dfd10600035a799abae03178fc7054582ea43d/0003-reference-to-TMPDIR-ERROR-WARNING.patch
fi

# crash memory driver support
rm -rf meta-oe/recipes-kernel/crash-memory-driver
if ! patch -R -p1 -s -f --dry-run <${SCRIPTPATH}/against-a8dfd10600035a799abae03178fc7054582ea43d/0004-crash-crash-memory-driver-support-added.patch; then
     patch -p1 <${SCRIPTPATH}/against-a8dfd10600035a799abae03178fc7054582ea43d/0004-crash-crash-memory-driver-support-added.patch
fi     

git diff --stat

git add .
git commit -m "patch typically only against upstream master"

set +x
