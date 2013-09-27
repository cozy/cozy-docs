---
title: "Uninstall"
layout: "default"
category: "host"
menuOrder: 2
---

# Uninstall your Cozy
Warning: this will delete all your data.

## Easy way 

```bash
fab -H user@ip uninstall_all
```
   
## Manual uninstall

```bash
supervisorctl stop cozy-controller
supervisorctl stop cozy-indexer
supervisorctl stop couchdb
rm -rf /usr/local/var/cozy-indexer
rm -f /etc/supervisor/conf.d/cozy-controller.conf
rm -f /etc/supervisor/conf.d/cozy-indexer.conf
rm -rf /usr/local/cozy
rm -rf /etc/cozy
apt-get uninstall supervisord
```
