---
title: " OpenVZ"
layout: "default"
category: "host"
menuOrder: 2
---

# Setup an OpenVZ image on your server.

Here we assume that the OpenVZ utilities are availalbe to spawn a new instance.

### Download

```bash
# Download the OpenVz archive (~ 1.3GB)
wget http://files.cozycloud.cc/vzdump-openvz-cozycloud-debian.tar

# Mount and start the container
vzrestore vzdump-openvz-cozycloud-debian.tar ctid
vzctl start ctid
```

Here replace ctid by an available ctid (101, 102, etc.)

### With a configured network

```bash
# Download the OpenVz archive (~ 1.3GB)
wget http://files.cozycloud.cc/vzdump-openvz-cozycloud-debian.tar

# Mount, give an IP address to the container and start the container
vzrestore vzdump-openvz-cozycloud-debian.tar ctid
vzctl set ctid --ipadd 10.0.0.10  --save 
vzctl start ctid

# Setup a reverse proxy that routes your 8888 port to https://10.0.0.10:443 
# Then authorize the routing:
/sbin/iptables -t nat -A PREROUTING -i vmbr0 -p tcp --dport 8888 -j DNAT --to 10.0.0.10:443
```

Change the dport value to allow access to any other port than 8888.
