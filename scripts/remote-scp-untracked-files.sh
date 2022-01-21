#!/bin/bash
source config.sh
set -x
rm -rf /tmp/untracked
mkdir /tmp/untracked
cd ../
git ls-files --others | xargs -I {} cp --parents {} /tmp/untracked
tree /tmp/untracked
cd /tmp/untracked
tar czvf ../untracked.tar.gz .
scp ../untracked.tar.gz ${SFTPSERVER}
set +x
