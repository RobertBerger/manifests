IMAGE_NAME=$1
NETWORK_INTERFACE=$2

if [ $# -lt 2 ];
then
    echo "+ $0: Too few arguments!"
    echo "+ use something like:"
    echo "+ $0 <docker image> <network interface>" 
    echo "+ $0 reliableembeddedsystems/eclipse docker0"
    echo "+ $0 reliableembeddedsystems/eclipse $(ip -o -4 route show to default | grep en | awk '{print $5}')"
    echo "+ $0 reliableembeddedsystems/eclipse $(ip -o -4 route show to default | grep wl | awk '{print $5}')"
    echo "+ $0 reliableembeddedsystems/eclipse $(ip -o -4 route show to default | grep br | awk '{print $5}')"
    echo "+ available network interfaces:"
    echo "$(ls /sys/class/net)"


    echo "+ $0 reliableembeddedsystems/eclipse br0"
    exit
fi

# remove currently running containers
echo "+ ID_TO_KILL=\$(docker ps -a -q  --filter ancestor=$1)"
ID_TO_KILL=$(docker ps -a -q  --filter ancestor=$1)

echo "+ docker ps -a"
docker ps -a
echo "+ docker stop ${ID_TO_KILL}"
docker stop ${ID_TO_KILL}
echo "+ docker rm -f ${ID_TO_KILL}"
docker rm -f ${ID_TO_KILL}
echo "+ docker ps -a"
docker ps -a

# enable TUN device (for qemu)
echo "+ sudo modprobe tun"
sudo modprobe tun

if [ ! -d ${HOME}/eclipse-docker/plugins ]; then
   mkdir -p ${HOME}/eclipse-docker/plugins
fi

if [ ! -d ${HOME}/eclipse-docker/workspace ]; then
   mkdir -p ${HOME}/eclipse-docker/workspace
fi

# run the image
set -x
ID=$(docker run -v ${HOME}/projects:/home/student/projects -v /datastore/opt:/datastore/opt -v /opt/buildtools-extended/resy:/opt/buildtools-extended/resy -v /opt/ext-sdk/resy:/opt/ext-sdk/resy -v /opt/ext-sdk-target-sysroot/resy:/opt/ext-sdk-target-sysroot/resy -v /opt/sdk/resy:/opt/sdk/resy -v ${HOME}/eclipse-docker/plugins:/home/genius/.eclipse -v ${HOME}/eclipse-docker/workspace:/home/genius/eclipse-workspace -v ${HOME}/docker-nonvol-scripts:/home/genius/nonvol-scripts -t -i -d -p 22 --privileged ${IMAGE_NAME} /sbin/my_init -- bash -l)
set +x
echo "+ ID ${ID}"

# ssh stuff:
PORT=$(docker port ${ID} 22 | awk -F':' '{ print $2 }')
IPADDR=$(ifconfig ${NETWORK_INTERFACE} | grep 'inet addr:'| grep -v '127.0.0.1' | cut -d: -f2 | awk '{ print $1}')
echo "+ ssh to the container like this:"
echo "ssh -X genius@${IPADDR} -p ${PORT}"

# let's attach to it:
echo "+ docker attach ${ID}"
docker attach ${ID}

