---
title: "Manage"
layout: "default"
category: "host"
menuOrder: 5
toc: true
---
# Manage your Cozy

## Administrate your Cozy

To administrate your Cozy, the easiest way is use cozy-monitor tool. This tool allows 
you to install, manage and uninstall applications via commands lines.

### Application installation
Install application <app>

```bash
cozy-monitor install <app>
```


Install cozy stack (data-system/home/proxy)
```bash
cozy-monitor install-cozy-stack
```

### Application management
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

Restart cozy stack <app>

```bash
cozy-monitor restart-cozy-stack
```

Update application <app>

```bash
cozy-monitor update <app>
```

Update cozy stack

```bash
cozy-monitor update-cozy-stack
```

Update all applications

```bash
cozy-monitor update-all
```

Brunch application <app>

```bash
cozy-monitor brunch <app>
```

### Application information
Display installed application

```bash
cozy-monitor status
```

Display applications versions

```bash
cozy-monitor cozy-version
```


### Application uninstallation

Uninstall application <app>

```bash
cozy-monitor uninstall <app>
```

Uninstall all applications

```bash
cozy-monitor uninstall-all
```

### Database management
By default, database is cozy.

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

Clean database
```bash
cozy-monitor cleanup [database]
```


### Others

Reset proxy routes

```bash
cozy-monitor reset-proxy
```

Launch script that comes with given application

```bash
cozy-monitor script <app> <script> [argument]
```



## Update your Cozy

### Easy way

The easiest way to update Cozy is to use the Fabric installation file used for
the installation. But in this case, you should not call the installation task but the
udpate tasks:

```bash
fab -H user@ip update_stack
fab -H user@ip update_all_apps
```


### Manual update

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


### Application update

To update a single application, you can run the following command on your targe
server.

```bash
sudo cozy-monitor update <app>
```
