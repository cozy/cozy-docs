---
title: "Install Cozy on Raspberry Pi"
layout: "default"
category: "host"
menuOrder: 4
toc: false
---


<div class="install-inner-logo"> 
<img alt="Raspberry logo" src="/assets/images/raspberry-logo.png">
</div>

# Install Cozy on a Raspberry Pi

**You will need the latest [Raspberry Pi 2](http://en.wikipedia.org/wiki/Raspberry_Pi) to be able to run Cozy properly.**   

**A class10 high-speed SD card is also highly recommended.**

---

*Note for previous Raspberry Pi:* Cozy is a little bit heavy to run on the previous Raspberry Pi model B/B+, you can check for a
lightweight alternative called
[Cozy Light](https://github.com/cozy-labs/cozy-light)

---

In order to run Cozy on your Raspberry Pi 2, download our image and set it up
on a SD card.
The image is based on [Raspbian Jessie lite](https://www.raspberrypi.org/downloads/raspbian/).

First, get the image archive:

```bash
# Download the image (~ 680MB)
wget https://files.cozycloud.cc/cozy-raspberrypi-latest.zip

# Uncompress it
unzip cozy-raspberrypi-latest.zip
```

**WARNING:** This operation will erase all data previously stored on the card.

Follow the guide [Installing operating system images](https://www.raspberrypi.org/documentation/installation/installing-images/README.md).

---

Now, insert the SD card into your Raspberry Pi, and boot it.

If you are not able to know your Pi's IP address on the console, you can use
`nmap` on your local workstation:

```
nmap -T4 -sP 192.168.x.0/24  # Or your sub network
```

In order to log into the board via SSH, you can use the default Raspbian credentials
```pi``` and ```raspberry```:

```bash
$ ssh pi@<ip-of-your-raspberrypi>

# Switch as root to type all there commands:
sudo -s

## Reset CouchDB tokens:

# Shutdown the cozy:
supervisorctl stop cozy-controller

# Reset security tokens
cozy_management reset_token

# If you want to change the certificate's FQDN:
rm /etc/cozy/server.crt /etc/cozy/server.key

# Launch CouchDB token and certificate regeneration:
dpkg-reconfigure cozy

# Expand /
/usr/bin/raspi-config --expand-rootfs

# You can change de pi default user password:
passwd pi

# Restart Raspberry π2
systemctl reboot
```

Once restart, you should be able to connect on your instance on port 443 via
https protocol:

`https://<ip-of-your-raspberrypi>`

**WARNING:** Installing and configuring Cozy may take quite a long time, one
hour or so, before the server starts listening on port 443, so be patient.

# Troubleshooting

## Corrupted filesystem

If after a brutal system halt, the server refuse to boot again, and you get a “vfs unable to mount root fs on unknown-block” message when plugging a screen, the filesystem is probably corrupted. You can try to fix this by mounting the SD card on another server and perform a file system check. Run `lsblk` to identify the device, then `e2fsck` to try to fix the filesystem. 

