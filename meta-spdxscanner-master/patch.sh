#!/bin/bash
SCRIPTPATH="$( cd -- "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"
echo ${SCRIPTPATH}
set -x

git checkout classes/scancode-tk.bbclass
if ! patch -R -p1 -s -f --dry-run <${SCRIPTPATH}/against-b6af6cb1bf106ced71b966f012b6708973729283/0001-custom-SCANCODE_NUMBER_THREADS-instead-of-BB_NUMBER_.patch; then
     patch -p1 <${SCRIPTPATH}/against-b6af6cb1bf106ced71b966f012b6708973729283/0001-custom-SCANCODE_NUMBER_THREADS-instead-of-BB_NUMBER_.patch
fi

git checkout classes/classes/bom.bbclass
if ! patch -R -p1 -s -f --dry-run <${SCRIPTPATH}/against-b6af6cb1bf106ced71b966f012b6708973729283/0002-explicitly-add-do_spdx_creat_tarball-task.patch; then
     patch -p1 <${SCRIPTPATH}/against-b6af6cb1bf106ced71b966f012b6708973729283/0002-explicitly-add-do_spdx_creat_tarball-task.patch
fi

git diff --stat

git add .
git commit -m "patch typically only against upstream master"

set +x
