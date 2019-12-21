#!/bin/bash

# Install thw wifibroadcast_bridge package
rm -rf wifibroadcast_bridge
git clone https://github.com/webbbn/wifibroadcast_bridge.git
(
    cd wifibroadcast_bridge
    ls -l scripts
    ./scripts/mkdeb
    dpkg -i build/*.deb
)
rm -rf wifibroadcast_bridge

# Install the openhd package
rm -rf Open.HD-NG
git clone https://github.com/webbbn/Open.HD-NG.git
(
    cd Open.HD-NG
    ./scripts/mkdeb
    dpkg -i build/*.deb
)
rm -rf Open.HD-NG
