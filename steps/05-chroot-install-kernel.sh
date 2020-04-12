#!/bin/bash

KERNELS_URL=https://github.com/webbbn/Open.HD-Kernel-Builder/releases/download/v0.9/kernels-2020-04-11.zip

# Download the kernels
cd /tmp
echo "Downloading: ${KERNES_URL}"
wget -O kernels.zip "${KERNELS_URL}"

# Unzip the kernels on the image
unzip kernels.zip

# Install the kernels
tar -C / -xf kernels.tar.gz

# Cleanup
echo "Removing: kernels.zip and kernels"
rm -rf kernels.zip kernels

# Install the dual camera blob.
(
    cd /boot
    wget http://wiki.stereopi.com/files/dt-blob.bin.zip
    unzip dt-blob.bin.zip
    rm dt-blob.bin.zip
)
