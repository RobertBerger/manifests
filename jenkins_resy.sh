# That's what we could all form Jenkins:
#
# rm -f jenkins_resy.sh*
# wget https://raw.githubusercontent.com/RobertBerger/manifests/master/jenkins_resy.sh
# chmod +x jenkins_resy.sh
# ./jenkins_resy.sh
#

# Jenkins: 
#   WORKSPACE
#   The absolute path of the directory assigned to the build as a workspace.
#
# We need a symlink from /workspace to our jenkins ${WORKSPACE}
ls -lah /workspace
echo ${WORKSPACE}
if [ "$(readlink -- "/workspace")" = ${WORKSPACE} ]; then
   echo "all good!"
   echo "we have a symlink /workspace pointing to ${WORKSPACE}"
else
   echo "not good!"
   echo "+ ls -lah /workspace"
   ls -lah /workspace
   echo "WORKSPACE: ${WORKSPACE}"
fi

# run the resy stuff (get layers)
#rm -f resy.sh* 
#wget https://raw.githubusercontent.com/RobertBerger/manifests/master/resy.sh
#chmod +x resy.sh
#./resy.sh
