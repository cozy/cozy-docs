---
title: "Troubleshooting"
layout: "default"
category: "host"
menuOrder: 2
toc: true
---

# Troubleshooting

In this section, you will find common errors that occur during the
installation process.
Mention us the problems you encountered, and which are not listed here, and we will add them to the list as soon as possible.

## I can only install one application

When you try to install an application it is marked as broken and it has the same behaviour for each additional application.

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
Check that everything is set to true. If Home is marked as false, that means it is not running. To solve this problem, type the following commands in a terminal of your remote server:

```bash
cozy-monitor uninstall home
cozy-monitor install home
```

### Problem with data-system

Check the log of your data-system in `/usr/local/cozy/apps/data-system/data-system/cozy-data-system/log/production.log`.
If logs contain "Database cozy on localhost:5984 doesn't exist." and "The database could not be created, the file already exists.", that means data-system cannot connect to cozy database. To solve this problem, type the following commands in a terminal of your remote server :

```bash
cozy-monitor uninstall data-system
cozy-monitor install data-system
cozy-monitor restart home
cozy-monitor restart proxy
```

### Npm errors

Cozy is based on Node.js applications. Node.js apps download their dependencies from the NPM registry. Sometimes this registry is not stable. So, if you encounter NPM related errors, try to run the installation again.

## ARM processors

### Node.js

Node.js requires a specific configuration to be run on Raspberry Pi. Install
Node with the prebuilt package available in the Node.js source directory. About
building Node.js on other ARM processors, we successfully built it on A20
Allwinner.

### Nginx

Here is a good tutorial to install Nginx on your Raspberry Pi:
http://virtualitblog.blogspot.fr/2013/05/install-nginx-141-raspberry-pi.html .
It works only for Debian based distributions.

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

If you run several times the installation, the db password and the password used
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

## I've lost my Cozy password

If you've lost your password, first thing to try is clicking on the `I forgot my password` link to get it sent by email.

If, by any chance, you're hosting cozy on a system with no Email server installed (e.g Postfix), you'll need to access the `Futon Web Admin` page to remove the current user. You now have 2 solutions:

#### You can access 127.0.0.1 with a browser

This should be the case if you're hosting Cozy on your own server.

Simply browse to `http://localhost:5984/_utils/`

#### You need to use a domain name to access your Cozy

This should be the case if you're hosting Cozy on a VPS for instance.
To avoid opening the CouchDB access to every external IP, we'll use SSH. On your own terminal, input

```
ssh -L 5984:127.0.0.1:5984 cozy.mydomain.com
```

If you already have a CouchDB instance running on your own server, you'll probably have to change the first `5984` to any available port.
You can then browse to `http://127.0.0.1:5984/_utils/`

Once this is done, you'll need to login. The `login` link is in the bottom right of the page. You'll find your Cozy CouchDB credentials in `/etc/cozy/couchdb.login`. The first line is your login, the second one your password.

Once logged in, use the `View` dropdown menu, and select `User -> all`. You should see one line, which you can delete.
When you refresh your Cozy page, it should ask you to register.

## Websockets do not work in Apache

If you are using Apache and meet some errors in your browser console like the one below, you might want to enable the websocket proxying.

> WebSocket connection to 'wss://domain/public/files/socket.io/?EIO=3&transport=websocket&sid=DGvqewDGc_GvZX-3AAAB' failed: Error during WebSocket handshake: Unexpected response code: 400

First,enable the *proxy_wstunnel* and *mod_rewrite* modules:

```bash
sudo a2enmod proxy_wstunnel
sudo a2enmod mod_rewrite
```

 Then edit your apache configuration file (`/etc/apache2/sites-available/cozy.conf` on the default Debian installation for example) to insert the following lines:

```apache-config
RewriteEngine           On
RewriteCond             %{REQUEST_URI} ^/.*socket\.io [NC]
RewriteCond             %{THE_REQUEST} websocket [NC]
RewriteRule             /(.*)           ws://127.0.0.1:9104/$1 [P,L]
```

 Finally, reload apache, and that's it!

```bash
sudo service apache2 reload
```

## I’m unable to upload large files / synchronize large photos

If you’re using Nginx as a reverse proxy in front of Cozy, you may notice that you’re not allowed to upload big files. By default, Nginx limit the maximum size of a client request to 1Mo. To increase this limit, just add a [client_max_body_size](http://nginx.org/en/docs/http/ngx_http_core_module.html#client_max_body_size) to your Nginx config.

