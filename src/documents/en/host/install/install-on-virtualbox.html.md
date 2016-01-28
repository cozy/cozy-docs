---
title: "on VirtualBox"
layout: "default"
category: "host"
menuOrder: 4
toc: false
---


<div style="height: 0; overflow: shown; text-align: right">
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

Import the image to Virtualbox and start it.
You should be able to access your Cozy through your browser by connecting to this URL:

```bash
https://localhost:2223/
```

If you are on OS X, you have to forward ports.
Port 22 form your virtual machine should forward to 127.0.0.1:2222 and port 443 should forward to 127.0.0.1:2223.

<h3>3. Additional information</h3>

To access the box shell, use `root`/`password` as login and password.

You can find the box' IP with the `ifconfig` command.

You can connect through ssh with:

```bash
ssh -p 2222 root@localhost
```
