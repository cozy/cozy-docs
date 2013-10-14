---
title: "Raspberry Pi"
layout: "default"
category: "host"
menuOrder: 1
---

# Setup Cozy on your Raspberry Pi

*Minimum hardware: Raspberry Pi model B (RAM: 512MB) + 4GB SD card* 

To run Cozy on your Raspberry Pi, the simplest way is to download our image and
set it up on a SD card.

For that, get the image archive:

```bash
# Download the image (~ 1.5GB)
wget http://files.cozycloud.cc/cozy-raspberrypi.im.tar.gz

# Uncompress it
tar -xvzf cozy-raspberrypi.im.tar.gz
```

Then find your where is mounted your SDCard, let's assume it is on */dev/sdc*,
then make a low level copy of the image to your card.

Warning: this operation will erase all previously data stored into the card.

```bash
sudo dd bs=4M if=/home/frankrousseau/mycloud/images/cozy-raspberry.im of=/dev/sdc
```

Now insert the SD Card in your Raspberry Pi SD Card reader. Reboot your
raspberry then you will be able to access to your Cozy through the port 443
(https protocol).
