#!/bin/bash

# This runs in context if the image (CHROOT)
# Any native compilation can be done here
cd /home/pi

# Patch hello_video
(
    cp wifibroadcast-hello_video/* /opt/vc/src/hello_pi/hello_video/
    # REBUILDING DOES NOT WORK, BINARIES INCLUDED IN GIT
    cd /opt/vc/src/hello_pi/hello_video
    rm hello_video.bin.48-mm 2> /dev/null || echo > /dev/null
    rm hello_video.bin.30-mm 2> /dev/null || echo > /dev/null
    rm hello_video.bin.240-befi 2> /dev/null || echo > /dev/null

    cp video.c.48-mm video.c
    cd ..
    make
    cd /opt/vc/src/hello_pi/hello_video
    mv hello_video.bin hello_video.bin.48-mm

    cp video.c.30-mm video.c
    cd ..
    make
    cd /opt/vc/src/hello_pi/hello_video
    mv hello_video.bin hello_video.bin.30-mm

    cp video.c.240-befi video.c
    cd ..
    make
    cd /opt/vc/src/hello_pi/hello_video
    mv hello_video.bin hello_video.bin.240-befi
)

#################################################################
# NOTE: In order to save space in the image we're only going
#  to build what we're actually using. If/when another component
#  is ready to integrate, move the build block above this comment
#################################################################

exit

# Install OpenVG
(
    cd openvg
    make clean
    make library
    make install
)

# Install FLIROne Driver
(
    cd Open.HD_FlirOneDrv/flir8p1-gpl
    make
    chmod +x flir8p1
}

# Install wifibroadcast base
(
    cd wifibroadcast-base
    make clean
    make
)

# Install wifibroadcast-rc
(
    cd wifibroadcast-rc
    chmod +x build.sh
)

# Install wifibroadcast-status
(
    cd wifibroadcast-status
    make clean
    make
)

# Install wifibroadcast-misc
(
    cd wifibroadcast-misc
    chmod +x ftee
)

# Install wifibroadcast-splash
(
    cd wifibroadcast-splash
    make
)

#install JoystickIn
#apt-get --yes --force-yes install libsodium-dev
#cd /home/pi
#cd JoystickIn/JoystickIn
#wget --no-check-certificate https://mirror.wheel.sk/raspbian/raspbian/pool/main/libs/libsodium/libsodium-dev_1.0.11-2_armhf.deb
#dpkg -i libsodium-dev_1.0.11-2_armhf.deb
#make clean
#make
#mv processUDP ../processUDP

# Configure scripts
chmod 755 -R /home/pi/RemoteSettings
chmod 755 -R /home/pi/raspberrypi

# Install cameracontrol
chmod 755 /home/pi/cameracontrol/cameracontrolUDP.py
chmod 755 /home/pi/cameracontrol/LoadFlirDriver.sh
pip install psutil

(
    cd /home/pi/cameracontrol/RCParseChSrc
    make clean
    make RCParseCh
    cp RCParseCh /home/pi/cameracontrol/RCParseCh
    chmod 755 /home/pi/cameracontrol/RCParseCh
)

(
    cd /home/pi/cameracontrol/IPCamera/svpcom_wifibroadcast
    chmod 755 version.py
    make
    ./wfb_keygen
)


chmod 775 /home/pi/wifibroadcast-rc-Ath9k/rctxUDP.sh
chmod 775 /home/pi/wifibroadcast-rc-Ath9k/rctxUDP_IN

chmod 775 /home/pi/wifibroadcast-rc/rctxUDP.sh
chmod 775 /home/pi/wifibroadcast-rc/rctxUDP_IN

(
    cd /home/pi/wifibroadcast-rc-Ath9k
    chmod 775 /home/pi/wifibroadcast-rc-Ath9k/buildlora.sh
    /home/pi/wifibroadcast-rc-Ath9k/buildlora.sh
    chmod 775 /home/pi/wifibroadcast-rc-Ath9k/lora
)

(
    cd /home/pi/wifibroadcast-misc/LCD
    make
    chmod 755 /home/pi/wifibroadcast-misc/LCD/MouseListener
)
