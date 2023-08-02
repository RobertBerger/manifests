#!/bin/bash
SCRIPTPATH="$( cd -- "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"
echo ${SCRIPTPATH}
set -x

git checkout meta-oe/recipes-devtools/uftrace/uftrace_0.13.1.bb
if ! patch -R -p1 -s -f --dry-run <${SCRIPTPATH}/against-b85af2c8d0b3182ea5d678211da5a20aa254aa48/0001-replace-usr-bin-env-python-python3.patch; then
     patch -p1 <${SCRIPTPATH}/against-b85af2c8d0b3182ea5d678211da5a20aa254aa48/0001-replace-usr-bin-env-python-python3.patch
fi

git diff --stat
set +x
