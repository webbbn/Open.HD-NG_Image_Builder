#!/bin/bash

set -e

# Source the config file
. config

# Download the raspberry pi image if necessary
if [ ! -f ${DL_IMAGE} ]; then
    echo "Downloading Raspbian image"
    wget ${BASE_IMAGE_URL}
    unzip ${BASE_IMAGE}.zip
fi

# Create a larger image
echo "Creating the initial image from the downloaded copy and expanding it"
fallocate -l 3500M ${IMAGE_NAME}
dd conv=notrunc if=${DL_IMAGE} of=${IMAGE_NAME}

# Resize the root partition
echo "Resizing the root partion of: ${IMAGE_NAME}"
parted --script ${IMAGE_NAME} resizepart 2 100%

# Connect the image to a loopback device
LOOP=`losetup -P -f --show ${IMAGE_NAME}`

# Resize the root filesystem
echo "Checking the root partition and resizing it"
e2fsck -y -f ${LOOP}p2
resize2fs ${LOOP}p2 3200M
if [ ! -d ${IMAGE_ROOT} ]; then
    mkdir -p ${IMAGE_ROOT}
fi
if [ -d "${STAGE_WORK_DIR}" ]; then
    rm -rf "${STAGE_WORK_DIR}"
fi
mkdir "${STAGE_WORK_DIR}"

# Mount the root and boot partition
echo "Mounting the partitions"
mount ${LOOP}p2 ${IMAGE_ROOT}
mount ${LOOP}p1 ${IMAGE_ROOT}/boot

# Copy the qemu binary into the root directory so we can run it when we chroot
cp /usr/bin/qemu-arm-static ${IMAGE_ROOT}/usr/bin

# Loop through all the build steps
for SCRIPT in steps/*.sh; do
    ./run_step ${SCRIPT}
done
rm -rf ${IMAGE_ROOT}/tmp/*

# Unmount the partitions
umount ${LOOP}p1
umount ${LOOP}p2
losetup -d ${LOOP}

echo "Image written to: ${IMAGE_NAME}"
