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
* [Download](https://files.cozycloud.cc/cozy/cozy-virtualbox_latest.tar.xz) and decompress it (`xz -d cozy-virtualbox_4.0.1.tar.xz` on Linux, use your favorite software on Windows and MacOs).
* Download the image's signatures [here](https://files.cozycloud.cc/cozy/cozy-virtualbox_latest.tar.xz.sha512.asc) and [here](https://files.cozycloud.cc/cozy/cozy-virtualbox_latest.tar.xz.sha512).
* Check the integrity of the image:

```
gpgv2 -v cozy-virtualbox-4.0.1.tar.xz.sha512.asc
sha512sum -c cozy-virtualbox-4.0.1.tar.xz.sha512
```

<h3>2. Import and try</h3>

* Import the Cozy image into Virtualbox
* Edit machine settings
  * In "Network" tab, change network mode ("Attached to") from "NAT" to "Bridged Adaptateur"
  * Select your physical network card on the "Name" field
* Start the virtual machine
* Open your browser and go to `https://cozy.local`

Alternatively, you can reach your Cozy with the VM's IP address:

  * Login to console (login `root`/`root`)
  * Enter `hostname -I`
  * You should be able to access your Cozy through your browser by connecting to `https://<virtual-machine-ip-address>/`

<h3>3. Additional information</h3>

* To login into the shell of your virtual machine, use `root`/`root` as login and password. (Warning: the keyboard probably uses the qwerty layout.)
* You can connect through SSH with `ssh root@cozy.local` or `ssh root@<virtual-machine-ip-address>`
