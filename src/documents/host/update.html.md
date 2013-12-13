---
title: "Update your cozy"
layout: "default"
category: "host"
menuOrder: 5
---
# Update your Cozy

## Easy way

The easiest way to update Cozy is to use the Fabric installation file used for
the installation. But this you should not call the installation task but the
udpate tasks:

```bash
fab -H user@ip update_stack 
fab -H user@ip update_all_apps
```
   

## Manual update

If you want update your Cozy without Fabric you can run the following commands
directly on your server.

```bash
sudo cozy-monitor light-update data-system
sudo cozy-monitor light-update home
sudo cozy-monitor light-update proxy
sudo supervisorctl stop cozy-controller
sudo pkill -9 node # make sure no process is remaining.
sudo npm -g update cozy-controller 
sudo supervisorctl start cozy-controller
```


## Application update

To update a single application, you can run the following command on your targe
server.

```bash
sudo cozy-monitor light-update <app>
```
