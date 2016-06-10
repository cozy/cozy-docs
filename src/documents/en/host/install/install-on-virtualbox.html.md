---
title: "Install Cozy on VirtualBox"
layout: "default"
category: "host"
menuOrder: 8
toc: false
---


<div class="install-inner-logo">
<img alt="Virtualbox logo" src="/assets/images/virtualbox-logo.png">
</div>

# Install Cozy on VirtualBox

**Usage of the VirtualBox image below is not recommended in a production environment.**    
**See the [Debian installation guide](install-on-debian.html) for production.**

<br>

---

<h3>1. Download requirements</h3>

* [Download](https://www.virtualbox.org/wiki/Downloads) and install VirtualBox.
* [Download](https://files.cozycloud.cc/cozy/virtualbox-cozycloud-latest.zip) and unzip the Cozy
virtual image for VirtualBox

<h3>2. Import and try</h3>

* Import the Cozy image into Virtualbox
* Edit machine settings
  * In "Network" tab, change network mode ("Attached to") from "NAT" to "Bridged Adaptateur"
  * Select your physical network card on the "Name" field
* Start the virtual machine
* Get the IP address of your virtual machine
  * Login to console (login `vagrant`/`vagrant`)
  * Enter `ifconfig eth0`
  * IP address is available on the `inet` line
* You should be able to access your Cozy through your browser by connecting to `https://<virtual-machine-ip-address>/`

<h3>3. Additional information</h3>

* To login into the shell of your virtual machine, use `vagrant`/`vagrant` as login and password. (Warning: the keyboard probably uses the qwerty layout.)
* You can connect through SSH with `ssh vagrant@<virtual-machine-ip-address>`
* Setup of your Cozy may fail at the first boot. You can restart the setup through SSH with `rm /tmp/cozy-init.lock; /etc/init.d/cozy-init`
