---
title: "on OpenVZ"
layout: "default"
category: "host"
menuOrder: 6
toc: false
---


<div style="height: 0; overflow: shown; text-align: right">
<img src="/assets/images/openvz-logo.png">
</div>

# Install Cozy on OpenVZ

**The OpenVZ container is not up-to-date. Do not forget to upgrade it manually.**   

<br>

---

We assume that you have already installed OpenVZ utilities.

---

### Download and start

```bash
# Download the OpenVz template (~ 470MB)
wget http://files.cozycloud.cc/vzdump-openvz-cozycloud-debian.tar.xz

# Extract the template as a .tar file
xz -d vzdump-openvz-cozycloud-debian.tar.xz

# Mount and start the container
vzrestore vzdump-openvz-cozycloud-debian.tar ctid
vzctl start ctid
```

*Credentials are `root`/`password`*

**NB**: Replace ctid with an available ctid (101, 102, etc.)


### With a configured network

You will probably need to give access to your container from outside your
host. Here is a way to do it:

```bash
# Download the OpenVz template (~ 470MB)
wget http://files.cozycloud.cc/vzdump-openvz-cozycloud-debian.tar.xz

# Extract the template as a .tar file
xz -d vzdump-openvz-cozycloud-debian.tar.xz

# Mount your new container, give it an IP address and start it:
vzrestore vzdump-openvz-cozycloud-debian.tar ctid
vzctl set ctid --ipadd 10.0.0.10  --save
vzctl start ctid

# Setup a reverse proxy that routes your 8888 port to https://10.0.0.10:443
# (Use Nginx for instance).
# ...
# Then authorize the routing:
/sbin/iptables -t nat -A PREROUTING -i vmbr0 -p tcp --dport 8888 -j DNAT --to 10.0.0.10:443
```

Of course you can replace `8888` by the port you want.
