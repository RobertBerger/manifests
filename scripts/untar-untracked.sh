#!/bin/bash
HERE=$(pwd)
set -x
git status
set +x
echo "Press <ENTER> to go on"
read r
set -x
rm -rf /tmp/untracked
mkdir /tmp/untracked
cd /tmp/untracked
tar xzvf ../untracked.tar.gz
tree /tmp/untracked/
cd ${HERE}
cd ..
set +x
echo "Press <ENTER> to untar the stuff here"
read r
set -x
tar xvzf /tmp/untracked.tar.gz
git status
set +x
