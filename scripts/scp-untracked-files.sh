#!/bin/bash
rm -rf /tmp/untracked
mkdir /tmp/untracked
cd ../
git ls-files --others | xargs -I {} cp --parents {} /tmp/untracked
tree /tmp/untracked
cd /tmp/untracked
tar czvf ../untracked.tar.gz .
scp ../untracked.tar.gz rber@192.168.42.52:/tmp
