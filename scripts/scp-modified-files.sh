#!/bin/bash
rm -rf /tmp/modified
mkdir /tmp/modified
cd ../
git diff > /tmp/modified/modified.patch
cat /tmp/modified/modified.patch
cd /tmp
tar czvf modified.tar.gz modified/
scp /tmp/modified.tar.gz rber@192.168.42.52:/tmp
