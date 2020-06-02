# That's what we could call from Jenkins:
#
# rm -f jenkins_resy.sh*
# wget --no-cache https://raw.githubusercontent.com/RobertBerger/manifests/master/jenkins_resy.sh
# chmod +x jenkins_resy.sh
# ./jenkins_resy.sh
#

# Jenkins: 
#   WORKSPACE
#   The absolute path of the directory assigned to the build as a workspace.
#
# We need a symlink from /workspace to our jenkins ${WORKSPACE}

HERE=$(pwd)

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


cd /workdir

# run the resy stuff (get layers)
echo "+ rm -f resy.sh*"
rm -f resy.sh* 
echo "+ wget --no-cache https://raw.githubusercontent.com/RobertBerger/manifests/master/resy.sh"
wget --no-cache https://raw.githubusercontent.com/RobertBerger/manifests/master/resy.sh
echo "+ chmod +x resy.sh"
chmod +x resy.sh
echo "+ ./resy.sh"
./resy.sh

cd ${HERE}
