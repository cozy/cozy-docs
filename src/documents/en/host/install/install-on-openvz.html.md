---
title: "Install Cozy on OpenVZ"
layout: "default"
category: "host"
menuOrder: 10
toc: false
---


<div class="install-inner-logo">
<img alt="OpenVZ logo" src="/assets/images/host/openvz-logo.svg">
</div>

# Install Cozy on OpenVZ

---

** <img src="/assets/images/warning.png" alt="warning" class="warn">This document with instructions explains how to install the old Cozy prototype, but is now out of date. Instructions on how to install the new Cozy will be available soon. Stay tuned!**

---


We assume that you have already installed OpenVZ utilities.

---

### Download
```bash
# Download the OpenVz template (~ 340MB)
wget https://files.cozycloud.cc/openvz/openvz-cozycloud-latest.tar.gz
```

### Mount and start the container
```
vzrestore openvz-cozycloud-latest.tar.gz ctid
vzctl start ctid
```
*There are no password. You need to do a `vzctl enter ctid` to put one.
Or put your SSH key.*

**NB**: Replace ctid with an available ctid (101, 102, etc.)

### With a configured network

You will probably need to give access to your container from outside your
host. Here is a way to do it:

```bash
# Mount your new container, give it an IP address and start it:
vzrestore openvz-cozycloud-latest.tar.gz ctid
vzctl set ctid --ipadd 10.0.0.10  --save
vzctl start ctid

# Setup a reverse proxy that routes your 8888 port to https://10.0.0.10:443
# (Use Nginx for instance).
# ...
# Then authorize the routing:
/sbin/iptables -t nat -A PREROUTING -i vmbr0 -p tcp --dport 8888 -j DNAT --to 10.0.0.10:443
```

Of course you can replace `8888` by the port you want.
