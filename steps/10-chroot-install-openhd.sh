#!/bin/bash

# Install thw wifibroadcast_bridge package
wget -O deb-files.zip https://github.com/webbbn/wifibroadcast_bridge/suites/359215697/artifacts/700392
unzip deb-files.zip
dpkg -i deb-files/buster-armhf/wifibroadcast_bridge_*.deb
rm -rf deb-files*

# Install the openhd package
wget -O deb-files.zip https://github.com/webbbn/Open.HD-NG/suites/359793993/artifacts/705593
unzip deb-files.zip
dpkg -i deb-files/buster-armhf/open.hd-ng_*.deb
rm -rf deb-files*
