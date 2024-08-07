#!/bin/bash
SCRIPTPATH="$( cd -- "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"
echo ${SCRIPTPATH}
set -x

git checkout classes/freertos-image.bbclass
if ! patch -R -p1 -s -f --dry-run <${SCRIPTPATH}/against-b9f4c463293099540d9cc5ba11668c9aa88a1166/0001-added-lfs-0-to-FREERTOS_SRC_URI.patch; then
     patch -p1 <${SCRIPTPATH}/against-b9f4c463293099540d9cc5ba11668c9aa88a1166/0001-added-lfs-0-to-FREERTOS_SRC_URI.patch
fi

git checkout recipes-freertos/freertos-demo/freertos-demo_git.bb
if ! patch -R -p1 -s -f --dry-run <${SCRIPTPATH}/against-b9f4c463293099540d9cc5ba11668c9aa88a1166/0002-git-gitsm.patch; then
     patch -p1 <${SCRIPTPATH}/against-b9f4c463293099540d9cc5ba11668c9aa88a1166/0002-git-gitsm.patch
fi

git diff --stat

git add .
git commit -m "patch typically only against upstream master"

set +x
