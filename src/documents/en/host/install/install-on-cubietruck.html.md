---
title: "on CubieTruck"
layout: "default"
category: "host"
menuOrder: 3
toc: false
---


<div style="height: 0; overflow: shown; text-align: right">
<img alt="CubieBoard logo" src="/assets/images/cubieboard-logo.png">
</div>

# Install Cozy on a CubieTruck

**The CubieTruck is [the 3rd model](http://www.cubietruck.com/collections/frontpage/products/cubietruck-cubieboard3-cortex-a7-dual-core-2gb-ram-8gb-flash-with-wifi-bt-1) manufactured by Cubieboard.**   
**A class10 high-speed SD card is highly recommended for Cozy to run properly.**

<br>

---

In order to run Cozy on your Cubietruck, the simplest way is to download our
image and set it up on a SD card. It is based on the
[Cubian](http://cubian.org/) distribution.

First, get the image archive:

```bash
# Download the image (~ 860MB)
wget http://files.cozycloud.cc/2015-03-09-cozy-cubietruck.img.7z

# Uncompress it
7zr e 2015-03-09-cozy-cubietruck.img.7z
```

Then, find your SD card reference - we are assuming it is */dev/sdc* here -
and make a low-level dump of the image onto your card using `dd`.

**WARNING:** This operation will erase all data previously stored on the card.

```bash
sudo dd bs=4M if=cozy-cubietruck.img of=/dev/sdc
```

On **Windows**, you can use a tool like [Win32 Disk Imager](http://sourceforge.net/projects/win32diskimager/)
to do the same thing.

---

Now, insert the SD card in your CubieTruck, boot it, and you 
should be able to access your Cozy through port 443
(https protocol):

`https://ip.of.your.cubietruck`

<br>

If you are not able to know your Pi's IP address, you can use `nmap`
to get it on UNIX systems.

```
nmap -T4 -sP 192.168.x.0/24
```

---

If you want to login to the board via SSH, you can use the default
Cubian credentials ```cubie``` and ```cubie```:
```
 ssh -p 36000 cubie@<ip-of-your-cubietruck>
```

By the way, do not forget to change the `cubie` password and [reset the security
tokens](/host/manage.html#about-security-in-pre-installed-images)!
