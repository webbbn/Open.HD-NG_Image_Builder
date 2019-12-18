#!/bin/sh

cd "${IMAGE_ROOT}/home/pi/"

echo "Download all Open.HD Sources"
git clone -b ${OPENHD_BRANCH} ${OPENHD_REPO} Open.HD
(
    cd Open.HD
    git submodule update --init
    OPENHD_VERSION=$(git describe --always --tags)
    export OPENHD_VERSION
)

# store the commit used for the Open.HD repo as we as the builder inside the image
# to allow tracing problems and changes back to the source, even if the image is renamed
echo ${OPENHD_VERSION} > ${IMAGE_ROOT}/openhd_version.txt
echo ${BUILDER_VERSION} > ${IMAGE_ROOT}/builder_version.txt

mv Open.HD/openvg/ openvg/
mv Open.HD/wifibroadcast-base/ wifibroadcast-base/
mv Open.HD/mavlink/ wifibroadcast-base/mavlink/
mv Open.HD/wifibroadcast-osd/ wifibroadcast-osd/
mv Open.HD/wifibroadcast-rc/ wifibroadcast-rc/
mv Open.HD/wifibroadcast-rc-Ath9k/ wifibroadcast-rc-Ath9k/
mv Open.HD/wifibroadcast-status/ wifibroadcast-status/
mv Open.HD/wifibroadcast-scripts/ wifibroadcast-scripts/
mv Open.HD/wifibroadcast-misc/ wifibroadcast-misc/
mv Open.HD/wifibroadcast-hello_video/ wifibroadcast-hello_video/
mv Open.HD/wifibroadcast-splash/ wifibroadcast-splash/
mv Open.HD/RemoteSettings/ RemoteSettings/
mv Open.HD/cameracontrol/ cameracontrol/
mv Open.HD/wifibroadcast-rc-encrypted/ wifibroadcast-rc-encrypted/
mv Open.HD/JoystickIn/ JoystickIn/
mv Open.HD/raspberrypi/ raspberrypi/
mv Open.HD/UDPSplitter/ UDPSplitter/
rm -rf Open.HD

git clone -b master https://github.com/HD-Fpv/Open.HD_FlirOneDrv.git
