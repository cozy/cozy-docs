---
title: "Manage"
layout: "default"
category: "host"
menuOrder: 5
toc: true
---
# Manage your Cozy

## Cozy management
### Update

#### Easy way

The easiest way to update Cozy is to use the Fabric installation file used for
the installation. But in this case, you should not call the installation task but the
udpate tasks:

```bash
fab -H user@ip update_stack
fab -H user@ip update_all_apps
```


#### Manual update

If you want update your Cozy without Fabric, you can run the following commands
directly on your server.

```bash
sudo cozy-monitor update data-system
sudo cozy-monitor update home
sudo cozy-monitor update proxy
sudo supervisorctl stop cozy-controller
sudo pkill -9 node # make sure no process is remaining.
sudo npm -g update cozy-controller
sudo supervisorctl start cozy-controller
```


#### Application update

To update a single application, you can run the following command on your targe
server.

```bash
sudo cozy-monitor update <app>
```

### Restart
Restart cozy stack.
Cozy stack means home, proxy and data-system. In others words, cozy stack corresponds to applications allow to run Cozy.

```bash
cozy-monitor restart-cozy-stack
```
### Information
Display installed application

```bash
cozy-monitor status
```

Display cozy stack applications

```bash
cozy-monitor versions
```
Display applications versions

```bash
cozy-monitor versions-apps
```

## Applications management

### Installation
Install application <app>

```bash
cozy-monitor install <app>
```


### Manage
Stop application <app>

```bash
cozy-monitor stop <app>
```

Start application <app>

```bash
cozy-monitor start <app>
```

Restart application <app>

```bash
cozy-monitor restart <app>
```

Update application <app>

```bash
cozy-monitor update <app>
```

Update all applications. This commands update cozy stack applications and others applications installed by cozy user

```bash
cozy-monitor update-all
```

Brunch application <app>

```bash
cozy-monitor brunch <app>
```


### Uninstallation

Uninstall application <app>

```bash
cozy-monitor uninstall <app>
```

Uninstall all applications

```bash
cozy-monitor uninstall-all
```
Warning: this commands uninstall also cozy stack applications.

## Database management
By default, database option is "cozy".

Compact database
```bash
cozy-monitor compact [database]
```

Compact a view

```bash
cozy-monitor compact-view <view> [database]
```

Compact all views

```bash
cozy-monitor compact-all-view [database]
```

Backup database
```bash
cozy-monitor backup [target]
```


Clean database
```bash
cozy-monitor cleanup [database]
```

## Others

Reset proxy routes

```bash
cozy-monitor reset-proxy
```

Launch script that comes with given application

```bash
cozy-monitor script <app> <script> [argument]
```