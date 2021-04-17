#!/bin/ash
HERE=$(pwd)

if [ -z "$DOCKER_USER" ]; then
    echo "You need to export the docker.io registry username e.g."
    echo "export DOCKER_USER=\"something\""
    exit
fi

if [ -z "$DOCKER_PW" ]; then
    echo "You need to export the docker.io registry password e.g."
    echo "export DOCKER_PW=\"something\""
    exit
fi

if [ $# -lt 3 ];
then
    echo "+ $0: Too few arguments!"
    echo "+ use something like:"
    echo "+ $0 <image name> <container name> <tag> <image container name> <machine name> <tmpdir>"
    echo "+ $0 app-container-image-python3-mastermind-oci app-container-python3-mastermind-oci latest"
    echo "+ $0 app-container-image-python3-mqttbrokerclient-oci app-container-python3-mqttbrokerclient-oci latest"
    echo "+ $0 app-container-image-python3-data-collector-oci app-container-python3-data-collector-oci latest"
    echo "+ $0 app-container-image-python3-nmap-srv-oci app-container-python3-nmap-srv-oci latest"
    echo "+ $0 app-container-image-mosquitto-oci app-container-mosquitto-oci latest"
    echo "+ $0 app-container-image-redis-oci app-container-redis-oci latest"
    echo "+ $0 app-container-image-tensorflow-oci app-container-tensorflow-oci latest container-x86-64-tensorflow"
    echo "+ $0 app-container-image-java-oci app-container-java-oci latest container-x86-64-java"
    echo "+ $0 app-container-image-java-examples-oci app-container-java-examples-oci latest container-x86-64-java"
    echo "+ $0 app-container-image-tensorflow-examples-oci app-container-tensorflow-examples-oci latest container-x86-64-tensorflow"
    echo "+ $0 app-container-image-influxdb-prebuilt-oci app-container-influxdb-prebuilt-oci latest container-x86-64-golang"
    echo "+ $0 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
    echo "+ $0 app-container-image-lighttpd-oci-container-arm-v7 oci-lighttpd latest-arm-v7 container-arm-v7 container-arm-v7 tmp"
    echo "+ $0 app-container-image-lighttpd-oci-container-x86-64 oci-lighttpd latest-x86-64 container-x86-64 container-x86-64 tmp"
    echo "+ $0 app-container-image-telegraf-prebuilt-oci-container-arm-v7 oci-telegraf-prebuilt latest-arm-v7 container-arm-v7-tig container-arm-v7 tmp"
    echo "+ $0 app-container-image-telegraf-prebuilt-oci-container-arm-v7 oci-telegraf-prebuilt 1.17.3 container-arm-v7-master container-arm-v7 tmp"
    echo "+ $0 app-container-image-telegraf-prebuilt-oci-container-x86-64 oci-telegraf-prebuilt latest-x86-64 container-x86-64-tig container-x86-64 tmp"
    echo "+ $0 app-container-image-telegraf-prebuilt-oci-container-arm-v7 oci-telegraf-prebuilt latest-arm-v7 imx6q-phytec-mira-rdk-nand-virt-wic-mc container-arm-v7 tmp-container-arm-v7-resy-container"
    echo "+ $0 app-container-image-phoronix-oci-container-arm-v7 oci-phoronix latest-arm-v7 container-arm-v7-phoronix container-arm-v7 tmp"
    echo "+ $0 app-container-image-phoronix-oci-container-arm-v7 oci-phoronix latest-arm-v7hf container-arm-v7-phoronix container-arm-v7 tmp"
    echo "+ $0 app-container-image-tensorflow-examples-oci-container-imx8mm-lpddr4-evk-ml oci-tensorflow-examples latest-aarch64-armv8a-crc-cortexa53 container-imx8mm-lpddr4-evk-ml-tensorflow-master container-imx8mm-lpddr4-evk-ml tmp"
    exit
fi

#####################################################################################################################################################################
# ./oci-copy-to-docker.sh app-container-image-telegraf-prebuilt-oci-container-arm-v7 oci-telegraf-prebuilt latest-arm-v7 container-arm-v7-tig container-arm-v7 tmp
#                         image name
#                                                                                    container name
#                                                                                                          tag
#                                                                                                                        image container name
#                                                                                                                                              machine name 
#                                                                                                                                                              tmpdir
#####################################################################################################################################################################
# image name: app-container-image-telegraf-prebuilt-oci-container-arm-v7
# container name: oci-telegraf-prebuilt
# tag: latest-arm-v7
# image container name: container-arm-v7-tig
# machine: container-arm-v7

# if there is a repository on docker hub called:
# docker://docker.io/reliableembeddedsystems/oci-telegraf-prebuilt

# deploy dir: /workdir/build/container-arm-v7-tig/tmp/deploy/images/container-arm-v7/
#####################################################################################################################################################################


#####################################################################################################################################################################
# ./oci-copy-to-docker.sh app-container-image-telegraf-prebuilt-oci-container-arm-v7 oci-telegraf-prebuilt latest-arm-v7 imx6q-phytec-mira-rdk-nand-virt-wic-mc container-arm-v7 tmp-container-arm-v7-resy-container
#####################################################################################################################################################################
# image name: app-container-image-telegraf-prebuilt-oci-container-arm-v7
# container name: oci-telegraf-prebuilt
# tag: latest-arm-v7
# image container name: imx6q-phytec-mira-rdk-nand-virt-wic-mc
# machine: container-arm-v7

# if there is a repository on docker hub called:
# docker://docker.io/reliableembeddedsystems/oci-telegraf-prebuilt

# deploy dir: /workdir/build/imx6q-phytec-mira-rdk-nand-virt-wic-mc/tmp-container-arm-v7-resy-container/deploy/images/container-arm-v7/
#####################################################################################################################################################################

IMAGE="$1"
CONTAINER="$2"
TAG="$3"
IMAGE_CONTAINER_NAME="$4"
MACHINE="$5"
TMPDIR="$6"

echo "image name: ${IMAGE}"
echo "container name: ${CONTAINER}"
echo "tag: ${TAG}" 
#echo "docker user: ${DOCKER_USER}"
#echo "docker password: ${DOCKER_PW}"
echo "image container name (only used for deploy dir): ${IMAGE_CONTAINER_NAME}"
echo "machine (only used for deploy dir): ${MACHINE}"

echo "if there is a repository on docker hub called:"
echo "docker://docker.io/${DOCKER_USER}/${CONTAINER}"
echo "deploy dir: /workdir/build/${IMAGE_CONTAINER_NAME}/${TMPDIR}/deploy/images/${MACHINE}/"
echo "press <ENTER>"
read r

set -x 
cd /workdir/build/${IMAGE_CONTAINER_NAME}/${TMPDIR}/deploy/images/${MACHINE}/
set +x

retVal=$?
if [ $retVal -ne 0 ]; then
    echo "can not cd into"
    /workdir/build/${IMAGE_CONTAINER_NAME}/${TMPDIR}/deploy/images/${MACHINE}/
    echo "press <ENTER>"
    read r
    exit $retVal
fi

set -x

# check first, we clean up below if needed
HERE_AGAIN=$(pwd)
rm -rf unzip && mkdir unzip
cd unzip

# untar the OCI stuff
ls -la ../${IMAGE}*.tar

tar xvf ../${IMAGE}*.tar

OCI="$(ls | grep rootfs-oci)"

#echo "+ vi ${OCI}/index.json"
#echo "press <ENTER>"
#read r
#vi ${OCI}/index.json

set +x
# hack to fix wrong entry in index.json for armv7
#sed -i 's/\\"variant\\"/"variant"/g' ${OCI}/index.json
#skopeo --debug copy --dest-creds ${DOCKER_USER}:${DOCKER_PW} oci:${OCI}:latest docker://${DOCKER_USER}/${CONTAINER}
#skopeo --debug copy -f v2s2 --dest-creds ${DOCKER_USER}:${DOCKER_PW} oci:${OCI}:latest docker://${DOCKER_USER}/${CONTAINER}
#skopeo --debug copy -f v2s2 --dest-creds ${DOCKER_USER}:${DOCKER_PW} oci:${OCI}:latest docker://${DOCKER_USER}/${CONTAINER}:${TAG}
#skopeo copy -f v2s2 --dest-creds ${DOCKER_USER}:${DOCKER_PW} oci:${OCI}:latest docker://${DOCKER_USER}/${CONTAINER}

# check local oci image which yocto created - good
original_json=$(skopeo inspect oci:${OCI} | jq '.Layers')
#skopeo inspect --raw oci:${OCI} | jq

# check already uploaded (previous) docker container on docker hub - good
changed_json=$(skopeo inspect docker://${DOCKER_USER}/${CONTAINER}:${TAG} | jq '.Layers')
#skopeo inspect --raw docker://${DOCKER_USER}/${CONTAINER}:${TAG} | jq

#skopeo inspect docker-archive:${CONTAINER}-${TAG}.skopeo.tar:${DOCKER_USER}/${CONTAINER} | jq '.Layers'

echo ${original_json} > aa.json
echo ${changed_json}  > bb.json
diff aa.json bb.json

# if the above are identical, there is no need to go any further, I guess
if [ $? -eq 0 ]
then
set +x
   echo "the oci container created by Yocto:"
   echo "    oci:${OCI}"
   echo "and what's on docker hub:" 
   echo "    docker://${DOCKER_USER}/${CONTAINER}:${TAG}" 
   echo "seem to be idential - no need to upload again"
   echo "press <ENTER> to go on"
   read r
   exit 0
fi
# if they are not identical, we need to upload a new one

echo "looks like something is different now - might be only meta-data"
echo "press <ENTER> to go on"
read r
set -x

# clean up
cd ${HERE_AGAIN}
rm -rf unzip && mkdir unzip && cd unzip

# untar the OCI stuff
ls -la ../${IMAGE}*.tar

tar xvf ../${IMAGE}*.tar

OCI="$(ls)"

TIMESTAMP=$(date +%Y-%m-%d_%H-%M-%S)

# --> create a local docker-archive - note docker-archive digest is different from above
if [ -f ${CONTAINER}-${TAG}.skopeo.tar ]; then
   rm -f ${CONTAINER}-${TAG}.skopeo.tar
fi
skopeo copy oci:${OCI} docker-archive:${CONTAINER}-${TAG}.skopeo.tar.docker-archive:${DOCKER_USER}/${CONTAINER}
# also create one with timestamp
skopeo copy oci:${OCI}:latest docker-archive:${CONTAINER}-${TAG}-${TIMESTAMP}.skopeo.tar:${DOCKER_USER}/${CONTAINER}

# <-- create a local docker-archive - note docker-archive digest is different from above

# --> check locally converted oci -> docker-archive image - MEEEHH docker-archive adds something so we get a new checksum
# skopeo inspect docker-archive:${CONTAINER}-${TAG}.skopeo.tar | jq '.Layers'
# skopeo inspect --raw docker-archive:${CONTAINER}-${TAG}.skopeo.tar.docker-archive | jq
# <-- check locally converted oci -> docker-archive image - MEEEHH docker-archive adds something so we get a new checksum

# --> let's pull docker-archive from docker hub - MEEEHH docker-archive adds something so we get a new checksum
# skopeo copy docker://${DOCKER_USER}/${CONTAINER}:${TAG} docker-archive:${CONTAINER}-${TAG}.skopeo.tar.docker-archive-from-docker:${DOCKER_USER}/${CONTAINER}
# skopeo inspect --raw docker-archive:${CONTAINER}-${TAG}.skopeo.tar.docker-archive-from-docker | jq
# <-- let's pull docker-archive from docker hub - MEEEHH docker-archive adds something so we get a new checksum

# --> let's pull oci image from docker hub - now we are good with checksum ;)
# skopeo copy docker://${DOCKER_USER}/${CONTAINER}:${TAG} oci:${CONTAINER}-${TAG}.skopeo.tar.oci-from-docker:${DOCKER_USER}/${CONTAINER}
# skopeo inspect --raw oci:${CONTAINER}-${TAG}.skopeo.tar.oci-from-docker | jq
# <-- let's pull oci image from docker hub - now we are good with checksum ;)

#skopeo inspect docker://${DOCKER_USER}/${CONTAINER}:${TAG} | jq '.Layers'
#read r

# --> upload new image to docker hub
skopeo --debug copy -f v2s2 --dest-creds ${DOCKER_USER}:${DOCKER_PW} oci:${OCI}:latest docker://${DOCKER_USER}/${CONTAINER}:${TAG}
# also with timestamp tag
skopeo --debug copy -f v2s2 --dest-creds ${DOCKER_USER}:${DOCKER_PW} oci:${OCI}:latest docker://${DOCKER_USER}/${CONTAINER}:${TAG}-${TIMESTAMP}
# <-- upload new image to docker hub


# --> check our newly created stuff
# check local oci image which yocto created - good
skopeo inspect oci:${OCI} | jq '.Layers'
#skopeo inspect --raw oci:${OCI} | jq

# check already uploaded (previous) docker container on docker hub - good
skopeo inspect docker://${DOCKER_USER}/${CONTAINER}:${TAG} | jq '.Layers'
#skopeo inspect --raw docker://${DOCKER_USER}/${CONTAINER}:${TAG} | jq
# <-- check out newly created stuff

set +x
cd ${HERE}

echo "try:"
echo "docker pull docker.io/${DOCKER_USER}/${CONTAINER}"
echo "docker pull docker.io/${DOCKER_USER}/${CONTAINER}:${TAG}"
echo "docker pull docker.io/${DOCKER_USER}/${CONTAINER}:${TAG}-${TIMESTAMP}"
