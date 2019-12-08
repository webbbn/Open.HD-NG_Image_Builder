#!/bin/bash

set -e

. ./config

# Do this to the WORK folder of this stage
cd ${STAGE_WORK_DIR}

log "Removing old GIT dir"
rm -r GIT || true

mkdir -p GIT

cd GIT

MNT_DIR="${STAGE_WORK_DIR}/mnt"

log "Download all Open.HD Sources"
git clone -b master ${OPENHD_REPO}
(
    cd Open.HD
    git checkout ${OPENHD_BRANCH}
    git submodule update --init
    OPENHD_VERSION=$(git describe --always --tags)
    export OPENHD_VERSION
)

# store the commit used for the Open.HD repo as we as the builder inside the image
# to allow tracing problems and changes back to the source, even if the image is renamed
echo ${OPENHD_VERSION} > ${MNT_DIR}/openhd_version.txt
echo ${BUILDER_VERSION} > ${MNT_DIR}/builder_version.txt
# copy the Open.HD repo version back down to the work folder so build.sh can retrieve it and use it
# in the name of the image being built
cp ${MNT_DIR}/openhd_version.txt ${STAGE_WORK_DIR}/../

log "Download OpenVG"
mv Open.HD/openvg/ openvg/

log "Download EZWFB - Base"
# git clone https://github.com/user1321/wifibroadcast-base.git
mv Open.HD/wifibroadcast-base/ wifibroadcast-base/
cp -r Open.HD/mavlink/ wifibroadcast-base/mavlink/

log "Download EZWFB - OSD"
# git clone https://github.com/user1321/wifibroadcast-osd-orig wifibroadcast-osd
mv Open.HD/wifibroadcast-osd/ wifibroadcast-osd/
cp -r Open.HD/mavlink/ wifibroadcast-osd/mavlink/

log "Download EZWFB - RC"
# git clone https://github.com/user1321/wifibroadcast-rc-orig.git wifibroadcast-rc
mv Open.HD/wifibroadcast-rc/ wifibroadcast-rc/
# git clone -b user1321-5MHzAth9k https://github.com/user1321/wifibroadcast-rc-orig.git wifibroadcast-rc-Ath9k
mv Open.HD/wifibroadcast-rc-Ath9k/ wifibroadcast-rc-Ath9k/

log "Download EZWFB - Status"
# git clone https://github.com/RespawnDespair/wifibroadcast-status.git
mv Open.HD/wifibroadcast-status/ wifibroadcast-status/

log "Download EZWFB - Scripts"
# git clone -b user1321-5MhzAth9k https://github.com/user1321/wifibroadcast-scripts.git
mv Open.HD/wifibroadcast-scripts/ wifibroadcast-scripts/

log "Download EZWFB - Misc"
# git clone https://github.com/RespawnDespair/wifibroadcast-misc.git
mv Open.HD/wifibroadcast-misc/ wifibroadcast-misc/

log "Download EZWFB - hello_video"
# git clone https://github.com/RespawnDespair/wifibroadcast-hello_video.git
mv Open.HD/wifibroadcast-hello_video/ wifibroadcast-hello_video/

log "Download EZWFB - Splash"
# git clone https://github.com/RespawnDespair/wifibroadcast-splash.git
mv Open.HD/wifibroadcast-splash/ wifibroadcast-splash/

log "Download FLIR one"
git clone https://github.com/HD-Fpv/Open.HD_FlirOneDrv.git

log "Download RemoteSettings"
# git clone -b user1321-5MhzAth9k https://github.com/user1321/RemoteSettings
mv Open.HD/RemoteSettings/ RemoteSettings/

log "Download cameracontrol"
# git clone https://github.com/user1321/cameracontrol
mv Open.HD/cameracontrol/ cameracontrol/

log "Download rc-encrypted"
# git clone https://github.com/user1321/wifibroadcast-rc-encrypted
mv Open.HD/wifibroadcast-rc-encrypted/ wifibroadcast-rc-encrypted/

log "Download JoystickIn"
# git clone https://github.com/user1321/JoystickIn
mv Open.HD/JoystickIn/ JoystickIn/

log "Download IMX290"
mv Open.HD/raspberrypi/ raspberrypi/

log "Download UDPSplitter"
mv Open.HD/UDPSplitter/ UDPSplitter/


rm -rf Open.HD


git clone ${QOPENHD_REPO} || exit 1
cd QOpenHD
git checkout ${QOPENHD_VERSION} || exit 1
git submodule update --init --recursive
echo ${OPENHD_VERSION} > .openhd_version
echo ${BUILDER_VERSION} > .builder_version

# Do this to the WORK folder of this stage
cd ${STAGE_WORK_DIR}

log "Copy all WFB Sources to RPi image"

cp -r GIT/. "$MNT_DIR/home/pi/"
