#!/bin/bash

# Install the OpenHD debian repository
echo "deb https://dl.bintray.com/webbbn/openhd_test buster testing" >> /etc/apt/sources.list
wget -qO - https://bintray.com/user/downloadSubjectPublicKey?username=bintray | apt-key add -

# Replace the stock ath9k configuration file with our modified version
sudo mv /etc/modprobe.d/ath9k_htc.conf /etc/modprobe.d/ath9k_htc.conf.dist
sudo ln -s /etc/modprobe.d/ath9k_htc.conf.openhd /etc/modprobe.d/ath9k_htc.conf

# Install the OpenHD packages
apt-get update -y
apt-get install -y wifibroadcast_bridge open.hd-ng mavlink-router
