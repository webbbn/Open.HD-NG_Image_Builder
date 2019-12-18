#!/bin/bash

set -e

# Source the config file
. config

# Download the image of necessary
${BUILD_ROOT}/scripts/download_image

# Prepare a copy of the downloaded image
${BUILD_ROOT}/scripts/prepare_image

# Loop through all the build steps
for SCRIPT in steps/*.sh; do
    ${BUILD_ROOT}/scripts/run_step ${SCRIPT}
done

# Shrink the image to reduce the size
${BUILD_ROOT}/scripts/shrink

# Deploy the image
${BUILD_ROOT}/scripts/deploy

echo "Image creation complete:"
ls -lh "deploy/${IMAGE_NAME}.zip"
