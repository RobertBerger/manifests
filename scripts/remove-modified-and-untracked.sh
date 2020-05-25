#!/bin/bash
HERE=$(pwd)
echo "we'll remove modifed and non tracked files!"
echo "If you really want to remove your not commited work press <ENTER>"
read r
set -x
git status
set +x
echo "Really"
echo "Press <ENTER> to go on"
read r
set -x
cd ..
git reset --hard
git status
git clean -d -f
git status
cd ${HERE}
set +x
