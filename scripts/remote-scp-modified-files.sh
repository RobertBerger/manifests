#!/bin/bash
source config.sh
set -x
rm -rf /tmp/modified
mkdir /tmp/modified
cd ../
git diff > /tmp/modified/modified.patch
cat /tmp/modified/modified.patch
cd /tmp
tar czvf modified.tar.gz modified/
scp /tmp/modified.tar.gz ${SFTPSERVER}
set +x
