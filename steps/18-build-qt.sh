#!/bin/sh

set -e

STEPS_DIR=${PWD}/steps
QT_DIR=${IMAGE_ROOT}/opt/Qt
QOPENHD_DIR=${IMAGE_ROOT}/usr/local/bin

# Remove any existing Qt packages
apt-get remove -y `dpkg --get-selections | grep -e "qt5" | awk '{print $1}'`

# Create a temporary build directory
mkdir -p ${STAGE_WORK_DIR}/QtBuild
(
    cd ${STAGE_WORK_DIR}/QtBuild
    cp ${STEPS_DIR}/build_qt ${STAGE_WORK_DIR}/QtBuild

    # Run the build Qt script using a docker image built for cross-compiling Qt
    docker run -v "${PWD}":/workdir webbbn/raspbian-buster-cross-compile .//build_qt

    # The Qt Installations should be in the 5.13.2 directory, and QOpenHD will be in the QOpenHD directory
    mkdir -p ${QT_DIR}
    cp -r 5.13.2 ${QT_DIR}

    # Copy QOpenHD to the requested directory
    cp -r QOpenHD/release/QOpenHD ${QOPENHD_DIR}
)
rm -rf ${STAGE_WORK_DIR}/QtBuild
