#!/bin/bash

# This just causes error messages
rm /etc/ld.so.preload

# Remove the closed-source ath9k firmware
apt-get remove -y \
	firmware-atheros

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
	omxplayer \
	libdouble-conversion1 \
	libgstreamer-gl1.0-0 \
	libpcre2-dev \
	libmtdev1 \
	libinput10 \
	libts0 \
	libxkbcommon0 \
	firmware-ath9k-htc \
	build-essential \
	gstreamer1.0-plugins-ugly \
	libqt5gstreamerquick-1.0-0

pip3 install pyric
pip3 install pymavlink

# Update the GL libraries to fix GLES support
# rm /usr/lib/arm-linux-gnueabihf/libEGL.so.1*
# sudo ln -s /opt/vc/lib/libbrcmEGL.so /opt/vc/lib/libEGL.so
# sudo ln -s /usr/lib/arm-linux-gnueabihf/libEGL.so.1.1.0 /usr/lib/arm-linux-gnueabihf/libEGL.so.1.1
# sudo ln -s /usr/lib/arm-linux-gnueabihf/libEGL.so.1.1 /usr/lib/arm-linux-gnueabihf/libEGL.so.1
# sudo ln -s /usr/lib/arm-linux-gnueabihf/libEGL.so.1 /usr/lib/arm-linux-gnueabihf/libEGL.so
# sudo ln -s /opt/vc/lib/libEGL.so /usr/lib/arm-linux-gnueabihf/libEGL.so.1.1.0
# sudo ln -s /opt/vc/lib/libGLESv2.so /usr/lib/arm-linux-gnueabihf/libGLESv2.so.2.0.0
# sudo ln -s /opt/vc/lib/libbrcmGLESv2.so /opt/vc/lib/libGLESv2.so
