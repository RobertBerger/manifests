#!/bin/bash
SCRIPTPATH="$( cd -- "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"
echo ${SCRIPTPATH}
set -x

git checkout meta-oe/recipes-devtools/uftrace/uftrace_0.13.1.bb
if ! patch -R -p1 -s -f --dry-run <${SCRIPTPATH}/against-aabd1dc4c944c8984397ef8b45add2182f57ee99/0001-uftrace-replace-usr-bin-env-python-with-python3.patch; then
     patch -p1 <${SCRIPTPATH}/against-aabd1dc4c944c8984397ef8b45add2182f57ee99/0001-uftrace-replace-usr-bin-env-python-with-python3.patch
fi

git diff --stat
set +x
