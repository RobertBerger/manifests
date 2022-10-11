#!/bin/bash
source config.sh
set -x
rm -rf /tmp/untracked
mkdir /tmp/untracked
cd ../
#git ls-files --others | xargs -I {} cp --parents {} /tmp/untracked
git ls-files --others | xargs -I {} rsync ./{} /tmp/untracked -avp --relative
tree -C /tmp/untracked
cd /tmp/untracked
tar czf ../untracked.tar.gz .
scp ../untracked.tar.gz ${SFTPSERVER}
set +x
