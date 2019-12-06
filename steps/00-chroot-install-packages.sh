#!/bin/bash

# This just causes error messages
rm /etc/ld.so.preload

# Install dependencies
apt-get update
apt-get install -y python3-pyudev libpcap0.8 python3-serial python3-pip cython3 libv4l-dev libboost-all-dev python3-numpy
pip3 install pyric
pip3 install pymavlink
