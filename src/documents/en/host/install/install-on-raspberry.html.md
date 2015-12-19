---
title: "on Raspberry Pi"
layout: "default"
category: "host"
menuOrder: 2
toc: false
---


<div style="height: 0; overflow: shown; text-align: right">
<img alt="Raspberry logo" src="/assets/images/raspberry-logo.png">
</div>

# Install Cozy on a Raspberry Pi

**You will need the latest [Raspberry Pi 2](http://en.wikipedia.org/wiki/Raspberry_Pi) to be able to run Cozy properly.**   
**A class10 high-speed SD card is also highly recommended.**

<br>

---

*Note for previous Raspberry Pi:* Cozy is a little bit heavy to run on the previous Raspberry Pi model B/B+, you can check for a
lightweight alternative called
[Cozy Light](https://github.com/cozy-labs/cozy-light)

---

In order to run Cozy on your Raspberry Pi 2, the simplest way is to download our
image and set it up on a SD card. The image is based on the
[Raspbian](http://www.raspbian.org/) distribution.

First, get the image archive:

```bash
# Download the image (~ 650MB)
wget https://files.cozycloud.cc/2015-06-16-cozy-raspberry-pi2.img.7z

# Uncompress it
7zr e 2015-06-16-cozy-raspberry-pi2.img.7z
```

Then, find your SD card reference - we are assuming it is */dev/sdc* here -
and make a low-level dump of the image onto your card using `dd`.

**WARNING:** This operation will erase all data previously stored on the card.

```bash
sudo dd bs=4M if=2015-06-16-cozy-raspberry-pi2.img of=/dev/sdc
```

On **Windows**, you can use a tool like [Win32 Disk Imager](http://sourceforge.net/projects/win32diskimager/)
to do the same thing.

---

Now, insert the SD card in your Raspberry Pi, boot it, and you 
should be able to access your Cozy through port 443
(https protocol):

`https://ip.of.your.pi`

**WARNING:** Installing and configuring Cozy may take quite a long time, one
hour or so, before the server starts listening on port 443, so be patient.

<br>

If you are not able to know your Pi's IP address, you can use `nmap`
to get it on UNIX systems.

```
nmap -T4 -sP 192.168.x.0/24
```

---

If you want to login to the board via SSH, you can use the default
Raspbian credentials ```pi``` and ```raspberry```:
```
ssh pi@<ip-of-your-raspberrypi>
```

By the way, do not forget to change the `pi` password.
