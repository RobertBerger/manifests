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
    echo "+ $0 <image name> <container name> <tag> <image container name> <machine name>"
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
    echo "+ $0 app-container-image-lighttpd-oci-container-arm-v7 oci-lighttpd latest-arm-v7 container-arm-v7 container-arm-v7"
    echo "+ $0 app-container-image-lighttpd-oci-container-x86-64 oci-lighttpd latest-x86-64 container-x86-64 container-x86-64"
    exit
fi

IMAGE="$1"
CONTAINER="$2"
TAG="$3"
IMAGE_CONTAINER_NAME="$4"
MACHINE="$5"

echo "image name: ${IMAGE}"
echo "container name: ${CONTAINER}"
echo "tag: ${TAG}" 
echo "docker user: ${DOCKER_USER}"
echo "docker password: ${DOCKER_PW}"
echo "image container name: ${IMAGE_CONTAINER_NAME}"
echo "machine: ${MACHINE}"

echo "if there is a repository on docker hub called:"
echo "docker://docker.io/${DOCKER_USER}/${CONTAINER}"
echo "press <ENTER>"
read r

set -x
#skopeo inspect docker://${DOCKER_USER}/${CONTAINER}:${TAG} | jq '.Layers'
skopeo inspect --raw docker://${DOCKER_USER}/${CONTAINER}:${TAG} | jq

skopeo list-tags docker://${DOCKER_USER}/${CONTAINER}

set +x

echo "Which tag to delete?"
read TAG_TO_DELETE
echo "we'll delete this: ${TAG_TO_DELETE}"

login_data() {
cat <<EOF
{
  "username": "${DOCKER_USER}",
  "password": "${DOCKER_PW}"
}
EOF
}

set -x

# get token to be able to talk to Docker Hub
TOKEN=$(curl -s -H "Content-Type: application/json" -X POST -d '{"username": "'${DOCKER_USER}'", "password": "'${DOCKER_PW}'"}' https://hub.docker.com/v2/users/login/ | jq -r .token)

curl "https://hub.docker.com/v2/repositories/${DOCKER_USER}/${CONTAINER}/tags/${TAG_TO_DELETE}/" \
-X DELETE \
-H "Authorization: JWT ${TOKEN}"

skopeo list-tags docker://${DOCKER_USER}/${CONTAINER}

#set -x 
#cd /workdir/build/${IMAGE_CONTAINER_NAME}/tmp/deploy/images/${MACHINE}/
#set +x

#retVal=$?
#if [ $retVal -ne 0 ]; then
#    echo "can not cd into"
#    /workdir/build/${IMAGE_CONTAINER_NAME}/tmp/deploy/images/${MACHINE}/
#    echo "press <ENTER>"
#    read r
#    exit $retVal
#fi

#set -x
# clean up
#rm -rf unzip && mkdir unzip && cd unzip

# untar the OCI stuff

#ls -la ../${IMAGE}*.tar
#
#tar xvf ../${IMAGE}*.tar
#set +x

#OCI="$(ls)"

#echo "+ vi ${OCI}/index.json"
#echo "press <ENTER>"
#read r
#vi ${OCI}/index.json

#set -x
# hack to fix wrong entry in index.json for armv7
#sed -i 's/\\"variant\\"/"variant"/g' ${OCI}/index.json
#skopeo --debug copy --dest-creds ${DOCKER_USER}:${DOCKER_PW} oci:${OCI}:latest docker://${DOCKER_USER}/${CONTAINER}
#skopeo --debug copy -f v2s2 --dest-creds ${DOCKER_USER}:${DOCKER_PW} oci:${OCI}:latest docker://${DOCKER_USER}/${CONTAINER}
#skopeo --debug copy -f v2s2 --dest-creds ${DOCKER_USER}:${DOCKER_PW} oci:${OCI}:latest docker://${DOCKER_USER}/${CONTAINER}:${TAG}
#skopeo copy -f v2s2 --dest-creds ${DOCKER_USER}:${DOCKER_PW} oci:${OCI}:latest docker://${DOCKER_USER}/${CONTAINER}

#TIMESTAMP=$(date +%Y-%m-%d_%H-%M-%S)

#echo "TIMESTAMP: ${TIMESTAMP}"

#function docker_tag_exists() {
#    TOKEN=$(curl -s -H "Content-Type: application/json" -X POST -d '{"username": "'${DOCKER_USER}'", "password": "'${DOCKER_PW}'"}' https://hub.docker.com/v2/users/login/ | jq -r .token)
#    curl --silent -f --head -lL https://hub.docker.com/v2/repositories/$1/tags/$2/ > /dev/null
#}

#if docker_tag_exists library/${CONTAINER} ${TAG}; then
#    echo exist
#else 
#    echo not exists
#fi

# check local oci image which yocto created - good
#skopeo inspect oci:${OCI} | jq '.Layers'
#skopeo inspect --raw oci:${OCI} | jq

# check already uploaded (previous) docker container on docker hub - good
#skopeo inspect docker://${DOCKER_USER}/${CONTAINER}:${TAG} | jq '.Layers'
#skopeo inspect --raw docker://${DOCKER_USER}/${CONTAINER}:${TAG} | jq

#skopeo inspect docker-archive:${CONTAINER}-${TAG}.skopeo.tar:${DOCKER_USER}/${CONTAINER} | jq '.Layers'


# if the above are identical, there is no need to go any further, I guess

# if they are not identical, we need to upload a new one

#read r

# --> create a local docker-archive - note docker-archive digest is different from above
#if [ -f ${CONTAINER}-${TAG}.skopeo.tar ]; then
#   rm -f ${CONTAINER}-${TAG}.skopeo.tar
#fi
#skopeo copy oci:${OCI} docker-archive:${CONTAINER}-${TAG}.skopeo.tar.docker-archive:${DOCKER_USER}/${CONTAINER}
# also create one with timestamp
#skopeo copy oci:${OCI}:latest docker-archive:${CONTAINER}-${TAG}-${TIMESTAMP}.skopeo.tar:${DOCKER_USER}/${CONTAINER}

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
#skopeo --debug copy -f v2s2 --dest-creds ${DOCKER_USER}:${DOCKER_PW} oci:${OCI}:latest docker://${DOCKER_USER}/${CONTAINER}:${TAG}
# also with timestamp tag
#skopeo --debug copy -f v2s2 --dest-creds ${DOCKER_USER}:${DOCKER_PW} oci:${OCI}:latest docker://${DOCKER_USER}/${CONTAINER}:${TAG}-${TIMESTAMP}
# <-- upload new image to docker hub


# --> check our newly created stuff
# check local oci image which yocto created - good
#skopeo inspect oci:${OCI} | jq '.Layers'
#skopeo inspect --raw oci:${OCI} | jq

# check already uploaded (previous) docker container on docker hub - good
#skopeo inspect docker://${DOCKER_USER}/${CONTAINER}:${TAG} | jq '.Layers'
#skopeo inspect --raw docker://${DOCKER_USER}/${CONTAINER}:${TAG} | jq
# <-- check out newly created stuff

set +x
cd ${HERE}

#echo "try:"
#echo "docker pull docker.io/${DOCKER_USER}/${CONTAINER}"
#echo "docker pull docker.io/${DOCKER_USER}/${CONTAINER}:${TAG}"
#echo "docker pull docker.io/${DOCKER_USER}/${CONTAINER}:${TAG}-${TIMESTAMP}"
