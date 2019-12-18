#!/bin/sh

# Change the keyboard to US
sed -i 's/gb/us/g' /etc/default/keyboard

# Enable the services
systemctl enable wifi_config
systemctl enable wfb_bridge
systemctl enable openhd
