#!/bin/bash

KERNELV6_URL=https://github.com/webbbn/Open.HD-Kernel-Builder/releases/download/v0.1/kernel-4.19.86+.tar.gz
KERNELV7_URL=https://github.com/webbbn/Open.HD-Kernel-Builder/releases/download/v0.1/kernel-4.19.86-v7+.tar.gz

# Download the kernels
cd /tmp
echo "Downloading: ${KERNELV6_URL}"
wget "${KERNELV6_URL}"
echo "Downloading: ${KERNELV7_URL}"
wget "${KERNELV7_URL}"
KERNELV6=${KERNELV7_URL##*/}
KERNELV7=${KERNELV7_URL##*/}

# Untar the kernels on the image
echo "Untaring: ${KERNELV6}"
tar -C / -xf "${KERNELV6}"
echo "Untaring: ${KERNELV7}"
tar -C / -xf "${KERNELV7}"

# Cleanup
echo "Removing: ${KERNELV6} ${KERNELV6}"
rm ${KERNELV} ${KERNELV7}
