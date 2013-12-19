---
title: "Trouble Shootings"
layout: "default"
category: "host"
menuOrder: 7
toc: true
---

# Trouble shootings

In this section, you will find common errors that occurs during the
installation process.
Mention us the problems you encoutered that are not listed here, we will add
them to the list as soon as possible.

## I can only install one application

When you try to install an application it is marked as broken and it has the same behaviour for every additional applications.

Check the amount of RAM available on your system by clicking on the manage button on your home page. If you RAM machine is full, that means your Cozy can't install new applications.

## Install never ends until I refresh the page (F5)

That's because the data-system module is not properly synchronized with the database. Just restart the data system and everything should be back to normal.

```bash
# On the cozy host
sudo cozy-monitor restart data-system
```

## Server error occured on login

### Problem with home

Check that your home is installed. In your browser go to _https://yourcozyurl/status_
Check that everything is set to true. If Home is marked as false, that means it is not running. To solve this problem type the following commands in a terminal of your remote server:

```bash
cozy-monitor uninstall home
cozy-monitor install home
```

### Problem with data-system

Check the log of your data-system in `/usr/local/cozy/apps/data-system/data-system/cozy-data-system/log/production.log`.
If logs contain "Database cozy on localhost:5984 doesn't exist." and "The database could not be created, the file already exists.", that means data-system cannot connect to cozy database. To solve this problem type the following commands in a terminal of your remote server :

```bash
cozy-monitor uninstall data-system
cozy-monitor install data-system
cozy-monitor restart home
cozy-monitor restart proxy
```

### Npm errors

Cozy is based on Node.js applications. Node.js apps download their dependencies from the NPM registry. Sometimes this registry is not stable. So if you encounter NPM related errors, try to run the installation again.

## ARM processors

### Node.js

Node.js require a specific configuration to be built on an ARM processor. Actually the version that is setup only supports Raspberry Pi like processors (ARMv6).

### Nginx

We didn't find yet a good solution to setup Nginx on a Raspberry. We are still
working on it. If you want to help us about this issue, feel free to
contribute!

Here is a good tutorial to install Nginx on your Raspberry Pi: http://virtualitblog.blogspot.fr/2013/05/install-nginx-141-raspberry-pi.html

Package can be downloaded there: http://nginx.org/packages/debian/pool/nginx/n/nginx/

## Cozy Controller not started

If you get ECONNRESET when installing apps using the cozy-monitor, check if the cozy-controller is correctly started

```bash
sudo supervisorctl
```

and check if the cozy-monitor is using port 9002

```bash
sudo netstat -plunt | grep 9002
tcp     0     0 0.0.0.0:9002      0.0.0.0:*        LISTEN      997/node
```


## CouchDB password

If you run several time the installation, the db password and the password used
by the data-system could become different. To reset the password, comment the
last line of `/usr/local/etc/couch/local.ini` in the admin section. Delete the
file `/etc/cozy/couchdb.login` Then run installation again or run this command:

```bash
fab config_couchdb
```

## Process duplication

Sometimes a Node.js process duplication occurs. In that case, the simplest way
to go back to normal is to run the following commands:

```bash
sudo supervisorctl stop cozy-controller
sudo pkill -9 node
sudo supervisorctl start cozy-controller
```
