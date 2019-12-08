#!/bin/bash

# Install thw wifibroadcast_bridge package
wget -O deb-files.zip https://github.com/webbbn/wifibroadcast_bridge/suites/347161937/artifacts/591135
unzip deb-files.zip
dpkg -i deb-files/buster-armhf/wifibroadcast_bridge_0.1.0_armhf.deb

# Install the openhd package
wget -O deb-files.zip https://github.com/webbbn/Open.HD-NG/suites/346775428/artifacts/587601
unzip deb-files.zip
dpkg -i deb-files/buster-armhf/open.hd-ng_0.1.0_armhf.deb

# Enable the services
systemctl enable wifi_config
systemctl enable wfb_bridge
systemctl enable openhd
