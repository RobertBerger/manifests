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
    echo "+ $0 <image name> <container name> <tag> <image container name>"
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
    exit
fi

IMAGE="$1"
CONTAINER="$2"
TAG="$3"
IMAGE_CONTAINER_NAME="$4"

echo "image name: ${IMAGE}"
echo "container name: ${CONTAINER}"
echo "tag: ${TAG}" 
echo "docker user: ${DOCKER_USER}"
echo "docker password: ${DOCKER_PW}"

echo "if there is a repository on docker hub called:"
echo "docker://docker.io/${DOCKER_USER}/${CONTAINER}"
echo "press <ENTER>"
read r

cd /workdir/build/${IMAGE_CONTAINER_NAME}/tmp/deploy/images/container-x86-64/
# clean up
rm -rf unzip && mkdir unzip && cd unzip

# untar the OCI stuff

set -x
ls -la ../${IMAGE}*.tar

tar xvf ../${IMAGE}*.tar
set +x

OCI="$(ls)"
set -x
#skopeo --debug copy --dest-creds ${DOCKER_USER}:${DOCKER_PW} oci:${OCI}:latest docker://${DOCKER_USER}/${CONTAINER}
skopeo --debug copy -f v2s2 --dest-creds ${DOCKER_USER}:${DOCKER_PW} oci:${OCI}:latest docker://${DOCKER_USER}/${CONTAINER}
#skopeo copy -f v2s2 --dest-creds ${DOCKER_USER}:${DOCKER_PW} oci:${OCI}:latest docker://${DOCKER_USER}/${CONTAINER}
set +x
cd ${HERE}

echo "try:"
echo "docker pull docker.io/${DOCKER_USER}/${CONTAINER}"
