#!/bin/bash
HERE=$(pwd)
set -x
git status
set +x
echo "Press <ENTER> to go on"
read r
set -x
rm -rf /tmp/modified
cd /tmp
tar xzvf modified.tar.gz
cd ${HERE}
vim /tmp/modified/modified.patch
cd ..
set +x
echo "Press <ENTER> to --dry-run this patch"
read r
set -x
patch -p1 < /tmp/modified/modified.patch --dry-run
set +x
echo "Press <ENTER> to apply this patch"
read r
set -x
patch -p1 < /tmp/modified/modified.patch
git status
set +x
