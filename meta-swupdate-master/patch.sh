#!/bin/bash
SCRIPTPATH="$( cd -- "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"
echo ${SCRIPTPATH}
set -x

git checkout classes-recipe/swupdate-common.bbclass
if ! patch -R -p1 -s -f --dry-run <${SCRIPTPATH}/against-5a82bce0d58d9b019e1ab23fcf1224a982168d80/0001-swupdate-common-bbclass-5.1-UNPACKDIR.patch; then
     patch -p1 <${SCRIPTPATH}/against-5a82bce0d58d9b019e1ab23fcf1224a982168d80/0001-swupdate-common-bbclass-5.1-UNPACKDIR.patch
fi

git checkout classes-recipe/swupdate-image.bbclass
if ! patch -R -p1 -s -f --dry-run <${SCRIPTPATH}/against-5a82bce0d58d9b019e1ab23fcf1224a982168d80/0002-swupdate-image-bbclass-5.1-UNPACKDIR.patch; then
     patch -p1 <${SCRIPTPATH}/against-5a82bce0d58d9b019e1ab23fcf1224a982168d80/0002-swupdate-image-bbclass-5.1-UNPACKDIR.patch
fi

git checkout classes-recipe/swupdate.bbclass
if ! patch -R -p1 -s -f --dry-run <${SCRIPTPATH}/against-5a82bce0d58d9b019e1ab23fcf1224a982168d80/0003-swupdate-bbclass-5.1-UNPACKDIR.patch; then
     patch -p1 <${SCRIPTPATH}/against-5a82bce0d58d9b019e1ab23fcf1224a982168d80/0003-swupdate-bbclass-5.1-UNPACKDIR.patch
fi

git checkout recipes-lua/swupdate-lualoader/swupdate-lualoader_1.0.bb
if ! patch -R -p1 -s -f --dry-run <${SCRIPTPATH}/against-5a82bce0d58d9b019e1ab23fcf1224a982168d80/0004-swupdate-lualoader-5.1-UNPACKDIR.patch; then
     patch -p1 <${SCRIPTPATH}/against-5a82bce0d58d9b019e1ab23fcf1224a982168d80/0004-swupdate-lualoader-5.1-UNPACKDIR.patch
fi

git checkout recipes-support/swupdate/swupdate.inc
if ! patch -R -p1 -s -f --dry-run <${SCRIPTPATH}/against-5a82bce0d58d9b019e1ab23fcf1224a982168d80/0005-swupdate-inc-5.1-UNPACKDIR.patch; then
     patch -p1 <${SCRIPTPATH}/against-5a82bce0d58d9b019e1ab23fcf1224a982168d80/0005-swupdate-inc-5.1-UNPACKDIR.patch
fi

# --> RES specific stuff

git checkout recipes-support/swupdate/swupdate/swupdate.service
if ! patch -R -p1 -s -f --dry-run <${SCRIPTPATH}/against-5a82bce0d58d9b019e1ab23fcf1224a982168d80/0101-swupdate.service-remove-notify-RES.patch; then
     patch -p1 <${SCRIPTPATH}/against-5a82bce0d58d9b019e1ab23fcf1224a982168d80/0101-swupdate.service-remove-notify-RES.patch
fi

git checkout recipes-support/swupdate/swupdate/swupdate.socket.tmpl
if ! patch -R -p1 -s -f --dry-run <${SCRIPTPATH}/against-5a82bce0d58d9b019e1ab23fcf1224a982168d80/0102-swupdate.socket.tmpl-hardcode-ListenStream-RES.patch; then
     patch -p1 <${SCRIPTPATH}/against-5a82bce0d58d9b019e1ab23fcf1224a982168d80/0102-swupdate.socket.tmpl-hardcode-ListenStream-RES.patch
fi

rm -rf patches-from-mailing-list
if ! patch -R -p1 -s -f --dry-run <${SCRIPTPATH}/against-5a82bce0d58d9b019e1ab23fcf1224a982168d80/0103-links-to-patches-from-u-boot-mailing-list-RES.patch; then
     patch -p1 <${SCRIPTPATH}/against-5a82bce0d58d9b019e1ab23fcf1224a982168d80/0103-links-to-patches-from-u-boot-mailing-list-RES.patch
fi

# <-- RES specific stuff


git diff --stat

git add .
git commit -m "patch typically only against upstream master"

set +x
