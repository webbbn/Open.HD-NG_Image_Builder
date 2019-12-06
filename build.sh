#!/bin/bash

DL_IMAGE=2019-09-26-raspbian-buster-lite.img
IMAGE_NAME=Open.HD-NG_`date +"%G-%m-%d"`.img

# IMAGE_ROOT points to the root directory of the image when not chrooted
IMAGE_ROOT=root

# Download the raspberry pi image if necessary
if [ ! -f ${DL_IMAGE} ]; then
    echo "Downloading Raspbian image"
    wget http://downloads.raspberrypi.org/raspbian_lite/images/raspbian_lite-2019-09-30/2019-09-26-raspbian-buster-lite.zip
    unzip 2019-09-26-raspbian-buster-lite.zip
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

# Mount the root and boot partition
echo "Mounting the partitions"
rmdir root
mkdir root
mount ${LOOP}p2 root
mount ${LOOP}p1 root/boot

# Copy the qemu binary into the root directory so we can run it when we chroot
cp /usr/bin/qemu-arm-static ${IMAGE_ROOT}/usr/bin

# Loop through all the build steps
for SCRIPT in steps/*.sh; do

    # Does this script require chroot?
    if [[ "${SCRIPT}" == *"chroot"* ]]; then
	SCR=`basename "${SCRIPT}"`
	cp ${SCRIPT} ${IMAGE_ROOT}/tmp
	echo "Sourcing ${SCRIPT} in chroot"
        chroot "${IMAGE_ROOT}"/ /usr/bin/qemu-arm-static /usr/bin/env /tmp/${SCR}
	rm ${IMAGE_ROOT}/tmp/${SCR}
	echo "Completed ${SCRIPT}"
    else
	echo "Sourcing ${SCRIPT}"
	source ${SCRIPT}
	echo "Completed ${SCRIPT}"
    fi
done
rm -rf ${IMAGE_ROOT}/tmp/*

# Unmount the partitions
umount ${LOOP}p1
umount ${LOOP}p2
losetup -d ${LOOP}

echo "Image written to: ${IMAGE_NAME}"
