#!/bin/bash

# Install thw wifibroadcast_bridge package
wget -O deb-files.zip https://github.com/webbbn/wifibroadcast_bridge/suites/363867671/artifacts/741234
unzip deb-files.zip
dpkg -i deb-files/buster-armhf/wifibroadcast_bridge_*.deb
rm -rf deb-files*

# Install the openhd package
wget -O deb-files.zip https://github.com/webbbn/Open.HD-NG/suites/363868282/artifacts/741238
unzip deb-files.zip
dpkg -i deb-files/buster-armhf/open.hd-ng_*.deb
rm -rf deb-files*
