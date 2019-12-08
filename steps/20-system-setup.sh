#!/bin/sh

# Copy the overlay files
cp -r files/overlay/* ${IMAGE_ROOT}

# Change the hostname
sed -i 's/raspberrypi/openhd-ng/g' ${IMAGE_ROOT}/etc/hosts
sed -i 's/raspberrypi/openhd-ng/g' ${IMAGE_ROOT}/etc/hostname

# Turn on the UART
echo "enable_uart=1" >> ${IMAGE_ROOT}/boot/config.txt
sed -i 's/console[^ ]*//g' ${IMAGE_ROOT}/boot/cmdline.txt

# Enable the camera
sed -i 's/start_x=0/start_x=1/g' ${IMAGE_ROOT}/boot/config.txt
echo "gpu_mem=128" >> ${IMAGE_ROOT}/boot/config.txt
echo " disable_camera_led=1" >> ${IMAGE_ROOT}/boot/config.txt

# Change the OpenHD UART to /dev/ttyS0
sed -i 's/ttyS1/ttyS0/g' ${IMAGE_ROOT}/etc/default/openhd
