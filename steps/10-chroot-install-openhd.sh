#!/bin/bash

# Install thw wifibroadcast_bridge package
wget -O deb-files.zip https://github.com/OpenHD/wifibroadcast_bridge/suites/369543463/artifacts/792012
unzip deb-files.zip
dpkg -i deb-files/buster-armhf/wifibroadcast_bridge_*.deb
rm -rf deb-files*

# Install the openhd package
wget -O deb-files.zip https://github.com/webbbn/Open.HD-NG/suites/367880493/artifacts/776005
unzip deb-files.zip
dpkg -i deb-files/buster-armhf/open.hd-ng_*.deb
rm -rf deb-files*
