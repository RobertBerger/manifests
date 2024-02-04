#!/bin/bash
SCRIPTPATH="$( cd -- "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"
echo ${SCRIPTPATH}
set -x
git checkout recipes-support/swupdate/swupdate/swupdate.service
git checkout recipes-support/swupdate/swupdate/swupdate.socket.tmpl
if ! patch -R -p1 -s -f --dry-run <${SCRIPTPATH}/against-ea21eccbd117da250d04430155ed61b39042835a/0001-updated-swupdate.service-swupdate.socket.tmpl.patch; then
     patch -p1 <${SCRIPTPATH}/against-ea21eccbd117da250d04430155ed61b39042835a/0001-updated-swupdate.service-swupdate.socket.tmpl.patch
fi

git diff --stat

git add .
git commit -m "patch typically only against upstream master"

set +x
