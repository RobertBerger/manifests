#!/bin/bash
#CONTAINER="reliableembeddedsystems/sdk-container:2021-01-17-master-local-gcc-9-ub18"
#CONTAINER="reslocal/sdk-container:latest"
CONTAINER="reliableembeddedsystems/sdk-container:2021-05-31-master-local-gcc-9-ub18"
DATA_CONTAINER="reliableembeddedsystems/m100pfsevp-data-container"
#GITPOD_CMD="--add-host gitpod:192.168.42.40"
set -x
docker pull ${CONTAINER}
# working with host volume:
#docker run ${GITPOD_CMD} -e TARGET_UID=$(id -u ${USER}) -e TARGET_GID=$(stat -c "%g" /home/${USER}) -v /home/${USER}/yocto-download:/home/sdk/yocto-download -v /home/${USER}:/home/sdk -v /opt:/opt -v /workdir:/workdir -v /home/${USER}/projects:/projects  -v /tftpboot:/tftpboot --interactive --tty --entrypoint=/usr/bin/entrypoint.sh ${CONTAINER} --login

# with data container:
#docker run ${GITPOD_CMD} --name sdk-container -e TARGET_UID=$(id -u ${USER}) -e TARGET_GID=$(stat -c "%g" /home/${USER}) -v /home/${USER}/yocto-download:/home/sdk/yocto-download -v /home/${USER}:/home/sdk -v /opt:/opt --mount source=m100pfsevpdata,destination=/opt/resy/riscv -v /workdir:/workdir -v /home/${USER}/projects:/projects  -v /tftpboot:/tftpboot --interactive --tty --entrypoint=/usr/bin/entrypoint.sh ${CONTAINER} --login

# we can NOT directly pull the data container from a registry!

# with data container:
docker run ${GITPOD_CMD} --name sdk-container -e TARGET_UID=$(id -u ${USER}) -e TARGET_GID=$(stat -c "%g" /home/${USER}) -v /home/${USER}/yocto-download:/home/sdk/yocto-download -v /home/${USER}:/home/sdk -v /opt:/opt --mount source=${DATA_CONTAINER},destination=/opt/resy/riscv -v /workdir:/workdir -v /home/${USER}/projects:/projects  -v /tftpboot:/tftpboot --interactive --tty --entrypoint=/usr/bin/entrypoint.sh ${CONTAINER} --login

set +x
