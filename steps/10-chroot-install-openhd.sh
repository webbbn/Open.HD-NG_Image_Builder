#!/bin/bash

# Install thw wifibroadcast_bridge package
wget -O deb-files.zip https://github.com/webbbn/wifibroadcast_bridge/suites/347975217/artifacts/598834
unzip deb-files.zip
dpkg -i deb-files/buster-armhf/wifibroadcast_bridge_0.1.0_armhf.deb

# Install the openhd package
wget -O deb-files.zip https://github.com/webbbn/Open.HD-NG/suites/350315836/artifacts/625469
unzip deb-files.zip
dpkg -i deb-files/buster-armhf/open.hd-ng_0.1.0_armhf.deb
