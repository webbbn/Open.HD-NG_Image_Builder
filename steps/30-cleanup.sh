#/bin/bash

# Remove any packages that we don't need
# This should also include any development packages that might have gotten installed previously
apt-get remove -y \
  cifs-utils \
  firebird-dev \
  gcc-4.9-base \
  gcc-5-base \
  gcc-6-base \
  gcc-7-base \
  libgtk-3-dev \
  libgtk2.0-dev \
  libmng-dev \
  libmnl-dev \
  libmtp-runtime \
  libproxy-dev \
  libpulse-dev \
  libsigc++-1.2-5c2 \
  libsqlite0-dev \
  libsqlite3-dev \
  libssl-dev \
  libts-dev \
  libvulkan-dev \
  libxcb-icccm4-dev \
  libxcb-image0-dev \
  libxcb-keysyms1-dev \
  libxcb-render-util0-dev \
  libxcb-xinerama0-dev \
  libxkbcommon-x11-dev \
  libxmu-dev \
  libxslt1-dev \
  libxv-dev \
  avahi-daemon \
  exim4

# Remove the bluetooth service, which can take CPU resources
apt-get purge bluez -y

# Remove the apt-get cache
apt-get clean
apt-get autoclean

apt-get autoremove -y
