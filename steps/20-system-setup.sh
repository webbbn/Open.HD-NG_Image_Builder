#!/bin/sh

# Copy the overlay files
cp -r files/overlay/* ${IMAGE_ROOT}

# Change the hostname
sed -i 's/raspberrypi/openhd-ng/g' ${IMAGE_ROOT}/etc/hosts
sed -i 's/raspberrypi/openhd-ng/g' ${IMAGE_ROOT}/etc/hostname

# Disable bluetooth. Bluetooth makes the systemd-udev daemon use CPU on the zero
echo "dtoverlay=disable-bt" >> ${IMAGE_ROOT}/boot/config.txt

# Turn on the UART
sed -i '/enable_uart/d' ${IMAGE_ROOT}/boot/config.txt
echo "enable_uart=1" >> ${IMAGE_ROOT}/boot/config.txt
sed -i 's/console[^ ]*//g' ${IMAGE_ROOT}/boot/cmdline.txt

# Enable the camera
sed -i '/start_x/d' ${IMAGE_ROOT}/boot/config.txt
echo "start_x=1" >> ${IMAGE_ROOT}/boot/config.txt
sed -i '/gpu_mem/d' ${IMAGE_ROOT}/boot/config.txt
echo "gpu_mem=128" >> ${IMAGE_ROOT}/boot/config.txt
sed -i '/disable_camera_led/d' ${IMAGE_ROOT}/boot/config.txt
echo "disable_camera_led=1" >> ${IMAGE_ROOT}/boot/config.txt

# Disable most automatic network configuration functions, which can interfere with the wifi devices.
echo -e "auto lo\niface lo inet loopback\nauto eth0\nallow-hotplug eth0\niface eth0 inet manual\niface wlan0 inet manual\niface wlan1 inet manual\niface wlan2 inet manual" ${IMAGE_ROOT}/etc/network/interfaces
