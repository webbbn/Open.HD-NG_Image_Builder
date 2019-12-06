#!/bin/sh

# Turn on SSH
touch ${IMAGE_ROOT}/boot/ssh

# Change the hostname
sed -i 's/raspberrypi/openhd-ng/g' ${IMAGE_ROOT}/etc/hosts
sed -i 's/raspberrypi/openhd-ng/g' ${IMAGE_ROOT}/etc/hostname

# Turn on the UART
echo "enable_uart=1" >> ${IMAGE_ROOT}/boot/config.txt
sed -i 's/console[^ ]*//g' ${IMAGE_ROOT}/boot/cmdline.txt

# Change the OpenHD UART to /dev/ttyS0
sed -i 's/ttyS1/ttyS0/' ${IMAGE_ROOT}/etc/default/openhd
