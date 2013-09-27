---
title: "Update your cozy"
layout: "default"
category: "host"
menuOrder: 1
---
# Update your Cozy

## Easy way

```bash
fab -H user@ip update_stack 
fab -H user@ip update_all_apps
```
   

## Manual update
```bash
sudo cozy-monitor light-update data-system
sudo cozy-monitor light-update home
sudo cozy-monitor light-update proxy
sudo supervisorctl stop cozy-controller
sudo pkill -9 node
sudo npm -g update cozy-controller 
sudo supervisorctl start cozy-controller
```


## Application update
```bash
sudo cozy-monitor light-update <app>
```
