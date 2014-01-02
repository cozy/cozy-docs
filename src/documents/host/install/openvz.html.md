---
title: " OpenVZ"
layout: "default"
category: "host"
menuOrder: 4
toc: true
---

# Setup an OpenVZ image on your server.

*Warning: For a production usage you have to change the superuser credentials,
renew the SSL certificate, the database credentials and the controller token.*

Here we assume that you already install OpenVZ utilities.

## Download and start your OpenVZ container

```bash
# Download the OpenVz template (~ 1.3GB)
wget http://files.cozycloud.cc/vzdump-openvz-cozycloud-debian.tar

# Mount and start the container
vzrestore vzdump-openvz-cozycloud-debian.tar ctid
vzctl start ctid
```

*Credentials are root/password*

NB: Replace ctid by an available ctid (101, 102, etc.)


## With a configured network

You will probably need to give access to your container from outside of your
host. Here is a way to do it:

```bash
# Download the OpenVz template (~ 1.3GB)
wget http://files.cozycloud.cc/vzdump-openvz-cozycloud-debian.tar

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

Of course you can change 8888 by the value you want.
