#!/bin/bash

KERNELS_URL=https://github.com/webbbn/Open.HD-Kernel-Builder/suites/374213945/artifacts/839463

# Download the kernels
cd /tmp
echo "Downloading: ${KERNES_URL}"
wget -O kernels.zip "${KERNELS_URL}"

# Unzip the kernels on the image
unzip kernels.zip

# Install the kernels
tar -C / -xf kernels/kernels.tar.gz

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
