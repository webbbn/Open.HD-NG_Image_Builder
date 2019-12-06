# Open.HD-NG_Image_Builder

Script for building an Open.HD-NG sdcard image for the Raspberry Pi

## Building
This build script has been tested on Ubuntu 18.04. It should work on other distribution, but may require some modifications to dependencies.

## Install dependencies
~~~
sudo apt install unzip qemu-user-static
~~~

## Build the firmware

Building the firmware requires running a single script:

~~~
sudo ./build.sh
~~~

This script will download the selected base Raspbian Lite image, expand it a bit to support installation of the OpenHD software,
perform some re-configuration, and create a script named *Open.HD-NG_<date>.img*.

## Explaination of the processing steps

The build process is not intended to build an entire image from scratch, rather it is intended to customize a standard image to meet the needs of OpenHD.
The current base image is Raspbian Buster Lite version 2019-09-26. The base image used can be changed in the configuration file.

After downloadding the base image, the the base image is resized to support adding addditional software.
The image is then loopback mounted, with all the installation steps working directly on the image file, either running as a standard process on the host, or running in a chroot inside the image, using qemu to support running tha arm binaries.

The scripts for performing the installation and configuration are located in the *steps* directory.
They are run in *glob* order, which means if you prefix the files with a two digit number (for example), they will run in numerical order.
The scripts must be executable, and must end in *.sh*.
If the word 'chroot' is in the filename the script will be run in a chroot environment, very similar to running on the actual device.
Otherwise the script is run normally on the host.

Configuration variables are stored in the *config* file. This file also contains various other environment variables that can be used in scripts.

### Debugging the build process

There is currently no mechanism to specify a starting point for the build or build steps that sould be skipped.
The intent is that the build process should mostly consist of installing/removing software and configuration.
Large pieces of softare (e.g. the kernel) should have external build script, and should only be re-built when required and installed as packages in the image build process.

That said, there is a script called 'run_step' that will run a single build step.
It will execute the given script on the current state of the image, so it is up to the user to perform any cleanup, etc that is required prior to running the script.

**Example:**
~~~
sudo ./run_step steps/20-system-setup.sh
~~~

Running the run_step script without specifying a script will execute a bash shell within the chroon environment, which can be very useful for identifyin issues and running installation lines one at a time.

~~~
sudo ./run_step
~~~
