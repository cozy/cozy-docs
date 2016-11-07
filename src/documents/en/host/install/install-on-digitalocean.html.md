---
title: "Install Cozy on DigitalOcean"
layout: "default"
category: "host"
menuOrder: 3
toc: false
---


<div class="install-inner-logo">
<img alt="DigitalOcean logo" src="/assets/images/host/digitalocean-logo.svg">
</div>

# Install Cozy on a DigitalOcean VPS

**DigitalOcean is a Virtual Private Server (VPS) provider which enables you to deploy**
**instances in a minute.**
**You need a credited account to follow the steps below.**

<br>

## 1. Create the droplet

Cozy requires 1024MB RAM to run properly.

<div>
![step1](/assets/images/digitalocean-capture-1.jpg)
</div>

<br>

Select `Debian 8 x64` in the distribution list.

<div>
![step2](/assets/images/digitalocean-capture-2.jpg)
</div>


## 2. Connect to the server via SSH

Find your server's IP address.

<div>
![step3](/assets/images/digitalocean-capture-3.jpg)
</div>

<br>

Then login via SSH as `root` user:
```
ssh root@server.ip
```


## 3. Install the Debian package

```
# Import the repository public key
wget -O - http://debian.cozycloud.cc/cozy.gpg.key 2>/dev/null | apt-key add -

# Add the Cozy repository to the software sources
echo 'deb http://debian.cozycloud.cc/debian jessie main cozy' \
 > /etc/apt/sources.list.d/cozy.list

# Install Cozy
apt-get update ;
apt-get install python-cozy-management ;
cozy_management install_cozy
```
