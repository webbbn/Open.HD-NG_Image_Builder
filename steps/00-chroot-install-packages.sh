#!/bin/bash

# This just causes error messages
rm /etc/ld.so.preload

# Install dependencies
apt-get update
apt-get install -y \
	python3-pyudev \
	libpcap0.8-dev \
	libpcap0.8 \
	python3-serial \
	python3-pip \
	python3-picamera \
	cython3 \
	libv4l-dev \
	libboost-all-dev \
	python3-numpy \
	python3-iniparse \
	indent \
	git \
	libsodium-dev \
	wiringpi \
	omxplayer
apt-get remove -y \
	firmware-atheros
pip3 install pyric
pip3 install pymavlink
