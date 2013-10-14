---
title: "Virtualbox VM"
layout: "default"
category: "host"
menuOrder: 1
---

# Run Cozy with Virtualbox

### Step 1

[Download](https://www.virtualbox.org/wiki/Downloads) and install VirtualBox.

### Step 2

[Download](http://files.cozycloud.cc/cozycloud-virtualimage.zip) the Cozy 
Virtual Machine for VirtualBox and import it into Virtual box.

### Step 3

Access to your Cozy through your browser by connecting to this URL:

```bash
https://localhost:2223/
```

### Additional informations

To access to the box shell use root/password as login and password.

You can find the box ip with the `ifconfig` command.

You can connect through ssh with:

```bash
ssh -p 2222 root@localhost
```
