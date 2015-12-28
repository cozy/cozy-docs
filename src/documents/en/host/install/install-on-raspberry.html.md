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

---

*Note for previous Raspberry Pi:* Cozy is a little bit heavy to run on the previous Raspberry Pi model B/B+, you can check for a
lightweight alternative called
[Cozy Light](https://github.com/cozy-labs/cozy-light)

---

In order to run Cozy on your Raspberry Pi 2, the simplest way is to download
our image and set it up on a SD card. The image is based on the [Raspbian Jessie lite](https://www.raspberrypi.org/downloads/raspbian/).

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

Now, insert the SD card in your Raspberry Pi and boot it.

If you are not able to know your Pi's IP address on the console, you can use
`nmap` on your local workstation:

```
nmap -T4 -sP 192.168.x.0/24  # Or your sub network
```

Login to the board via SSH, you can use the default Raspbian credentials
```pi``` and ```raspberry```:

```bash
$ ssh pi@<ip-of-your-raspberrypi>

# Switch as root to type all there commands:
sudo -s

## Reset CouchDB tokens:

# Shutdown the cozy:
supervisorctl stop cozy-controller

# Check CouchDB credientials:
admin_user="$(sed -n '1,1p' /etc/cozy/couchdb.login)";admin_pass="$(sed -n '2,1p' /etc/cozy/couchdb.login)";curl http://${admin_user}:${admin_pass}@127.0.0.1:5984/cozy

# Delete the CouchDB user:
admin_user="$(sed -n '1,1p' /etc/cozy/couchdb.login)";admin_pass="$(sed -n '2,1p' /etc/cozy/couchdb.login)";curl -X DELETE http://${admin_user}:${admin_pass}@127.0.0.1:5984/_config/admins/${admin_user}

# Check if user realy destroy:
curl http://127.0.0.1:5984/_config/admins/

# Need to return: {}

# If it look like good, remove file containing credentials informations:
rm /etc/cozy/couchdb.login

# If you want to change the FQDN of certificate:
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
