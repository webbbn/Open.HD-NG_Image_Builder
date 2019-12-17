#!/bin/bash

# Install thw wifibroadcast_bridge package
wget -O deb-files.zip https://github.com/webbbn/wifibroadcast_bridge/suites/361444424/artifacts/719885
unzip deb-files.zip
dpkg -i deb-files/buster-armhf/wifibroadcast_bridge_*.deb
rm -rf deb-files*

# Install the openhd package
wget -O deb-files.zip https://github.com/webbbn/Open.HD-NG/suites/361530243/artifacts/720493
unzip deb-files.zip
dpkg -i deb-files/buster-armhf/open.hd-ng_*.deb
rm -rf deb-files*
