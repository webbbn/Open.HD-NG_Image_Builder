#!/bin/bash

# Install thw wifibroadcast_bridge package
wget -O deb-files.zip https://github.com/OpenHD/wifibroadcast_bridge/suites/375054768/artifacts/845998
unzip deb-files.zip
dpkg -i deb-files/buster-armhf/wifibroadcast_bridge_*.deb
rm -rf deb-files*

# Replace the stock ath9k configuration file with our modified version
sudo mv /etc/modprobe.d/ath9k_htc.conf /etc/modprobe.d/ath9k_htc.conf.dist
sudo ln -s /etc/modprobe.d/ath9k_htc.conf.openhd /etc/modprobe.d/ath9k_htc.conf

# Install the openhd package
wget -O deb-files.zip https://github.com/OpenHD/Open.HD-NG/suites/375055740/artifacts/846173
unzip deb-files.zip
dpkg -i deb-files/buster-armhf/open.hd-ng_*.deb
rm -rf deb-files*
