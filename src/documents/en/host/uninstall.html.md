---
title: "Uninstall"
layout: "default"
category: "host"
menuOrder: 3
toc: true
---

# Uninstall your Cozy
Warning: this will delete all your data.

## Virtual machines and containers

If you installed Cozy in a virtual machine or in a container, you just have
to remove that virtual machine or container.


## Manual uninstall

To remove every Cozy files, you can run the following commands:

```bash
supervisorctl stop cozy-controller
supervisorctl stop cozy-indexer
service stop couchdb
rm -rf /usr/local/var/cozy-indexer
rm -f /etc/supervisor/conf.d/cozy-controller.conf
rm -f /etc/supervisor/conf.d/cozy-indexer.conf
rm -rf /usr/local/cozy
rm -rf /etc/cozy
rm -rf /usr/local/var/cozy/
apt-get purge supervisord
```
