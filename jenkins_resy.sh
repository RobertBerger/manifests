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

if [ ! -L /workdir ] ; then
   echo "+ symlink /workdir does not exist"
   echo "+ sudo ln -sf ${WORKSPACE} /workdir"
   sudo ln -sf ${WORKSPACE} /workdir
fi

if [ "$(readlink -- "/workdir")" = ${WORKSPACE} ]; then
   echo "all good!"
   echo "we have a symlink /workdir pointing to ${WORKSPACE}"
else
   echo "not good!"
   echo "+ ls -lah /workdir"
   ls -lah /workdir
   echo "WORKSPACE: ${WORKSPACE}"
fi


# run the resy stuff (get layers)
#rm -f resy.sh* 
#wget https://raw.githubusercontent.com/RobertBerger/manifests/master/resy.sh
#chmod +x resy.sh
#./resy.sh
