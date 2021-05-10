#!/bin/bash
SCRIPTPATH="$( cd -- "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"
echo ${SCRIPTPATH}
set -x
git checkout conf/layer.conf
#if ! patch -R -p1 -s -f --dry-run <${SCRIPTPATH}/0001-add-hardknott.patch; then
  patch -p1 <${SCRIPTPATH}/0001-add-hardknott.patch
#fi
git diff --stat
set +x
