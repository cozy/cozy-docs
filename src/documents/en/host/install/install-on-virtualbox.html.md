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
* You should be able to access your Cozy through your browser by connecting to `https://<virtual-machine-ip-address>:2223/`

<h3>3. Additional information</h3>

To access the box shell, use `vagrant`/`vagrant` as login and password. (warning, the keyboard probably uses the qwerty layout)

You can find the box' IP with the `ifconfig` command.

You can connect through ssh with:

```bash
ssh -p 2222 vagrant@localhost
```
