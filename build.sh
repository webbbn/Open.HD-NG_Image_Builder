#!/bin/bash

set -e

# The user can specify a step to stop at
if [ $# == 1 ]; then
    STEP=$1
elif [ $# != 3 ]; then
    echo "Usage: [step to stop after]" 1>&2
fi

# Source the config file
. config

# Create a build log file
BUILD_LOG=Open.HD-NG_`date +"%G-%m-%d_%T"`.log

# Download the image of necessary
${BUILD_ROOT}/scripts/download_image | tee ${BUILD_LOG}

# Prepare a copy of the downloaded image
${BUILD_ROOT}/scripts/prepare_image | tee -a ${BUILD_LOG}

# Loop through all the build steps
for SCRIPT in steps/*.sh; do
    ${BUILD_ROOT}/scripts/run_step ${SCRIPT} | tee -a ${BUILD_LOG}
done

# Shrink the image to reduce the size
${BUILD_ROOT}/scripts/shrink | tee -a ${BUILD_LOG}

# Deploy the image
${BUILD_ROOT}/scripts/deploy | tee -a ${BUILD_LOG}

echo "Image creation complete:" | tee -a ${BUILD_LOG}
ls -lh "deploy/${IMAGE_NAME}.zip" | tee -a ${BUILD_LOG}
