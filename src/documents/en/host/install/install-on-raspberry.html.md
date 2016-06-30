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

**You will need the latest [Raspberry Pi 2 or Raspberry Pi 3](http://en.wikipedia.org/wiki/Raspberry_Pi) to be able to run Cozy properly.**

**A class10 high-speed SD card is also highly recommended.**


In order to run Cozy on your Raspberry Pi, you need to:

* Download our [image](https://files.cozycloud.cc/raspberrypi/cozy-raspberrypi_latest.img.xz) and decompress it (`xz -d cozy-raspberrypi_4.1.0.img.xz` on Linux, use your favorite software on Windows and MacOs).
* Download the image's signatures [here](https://files.cozycloud.cc/raspberrypi/cozy-raspberrypi_latest.img.xz.sha512.asc) and [here](https://files.cozycloud.cc/raspberrypi/cozy-raspberrypi_latest.img.xz.sha512).
* Check the integrity of the image:

```
gpgv2 -v cozy-raspberrypi_4.1.0.img.xz.sha512.asc
sha512sum -c cozy-raspberrypi_4.1.0.img.xz.sha512
```

The image is based on [Raspbian Jessie lite](https://www.raspberrypi.org/downloads/raspbian/).

**WARNING:** The following operations will erase all data previously stored on the card.

Then follow the official Raspberry Pi guide on [Installing operating system images](https://www.raspberrypi.org/documentation/installation/installing-images/README.md).

---

Now, insert the SD card into your Raspberry Pi, and boot it.

You can reach your Pi on `https://cozy.local/`.

In order to log into the board via SSH, you can use the default Raspbian credentials
```pi``` and ```raspberry```:

```bash
$ ssh pi@cozy.local # or ssh pi@<ip-of-your-raspberrypi>

```

# Troubleshooting

## Host cozy.local doesn't work

Alternatively, you can determine your Pi's IP address and access it directly:

If you are not able to retrieve it from the console, you can use
`nmap` on your local workstation:

```
nmap -T4 -sP 192.168.x.0/24  # Or your sub network
```

## Corrupted filesystem

If after a brutal system halt, the server refuse to boot again, and you get a “vfs unable to mount root fs on unknown-block” message when plugging a screen, the filesystem is probably corrupted. You can try to fix this by mounting the SD card on another server and perform a file system check. Run `lsblk` to identify the device, then `e2fsck` to try to fix the filesystem.

