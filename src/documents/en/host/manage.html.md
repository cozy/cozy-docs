---
title: "Manage"
layout: "default"
category: "host"
menuOrder: 1
toc: true
---
# Manage your Cozy

## Cozy management

### Update

To update the whole stack and all application, run the following commands
directly on your server.

```bash
sudo cozy-monitor update-all-cozy-stack
sudo cozy-monitor update-all
sudo supervisorctl restart cozy-controller
```

#### Application update

To update a single application, you can run the following command on your target
server.

```bash
sudo cozy-monitor update <app>
```

### Restart
Restart cozy stack.
Cozy stack means home, proxy and data-system. In others words, cozy stack corresponds to applications allow to run Cozy.

```bash
sudo cozy-monitor restart-cozy-stack
```

### Information
Display installed application with their status (up or down).

```bash
cozy-monitor status
```

Display cozy stack modules version

```bash
cozy-monitor versions-stack
```

Also display installed applications versions

```bash
cozy-monitor versions
```

## Applications management

### Installation
Install given application. If it is not an official Cozy application you should
give repo location too. You should also give a specific display name or a specific branch.

```bash
sudo cozy-monitor install <app> [-r <repo>] [-d <displayName>] [-b <branch>]
```


### Manage
Stop application with given name.

```bash
sudo cozy-monitor stop <app>
```

Stop all user applications.

```bash
sudo cozy-monitor stop-all <app>
```

Start application with given name.

```bash
sudo cozy-monitor start <app>
```

Restart application with given name.

```bash
sudo cozy-monitor restart <app>
```

Update application with given name (git clone + npm install + restart).
The repo option is only useful if application comes from a specific repository.

```bash
sudo cozy-monitor update <app> [repo]
```

Update all applications installed by cozy user.

```bash
sudo cozy-monitor update-all
```


### Uninstallation

Uninstall application with given name.

```bash
sudo cozy-monitor uninstall <app>
```

## Database management
By default, database option is "cozy".

Run compact CouchDB command on database (remove unused revisions).

```bash
sudo cozy-monitor compact [database]
```

Compact a given CouchDB view.

```bash
sudo cozy-monitor compact-views <view> [database]
```

Compact all views.

```bash
sudo cozy-monitor compact-all-views [database]
```

Backup database by replicating it to another CouchDB instance.

```bash
sudo cozy-monitor backup [target]
```

Clean database.

```bash
sudo cozy-monitor cleanup [database]
```

## Provide more disk space


All data and files are stored in CouchDB. So, the simplest way to add more disk
space is to change your CouchDB configuraion. Currently your data are saved in
that folder:

```bash
/usr/local/var/lib/couchdb/
```

This path can also be `/var/lib/couchdb`, in particular if your cozy is
installed on Debian or Ubuntu.

You could change that directory where you want, on a mounting point with more
free disk space. For that, open the following file:

```bash
/usr/local/etc/couchdb/local.ini
```

It's `/etc/couchdb/local.init` on Debian and Ubuntu.

Add the couchdb section if it is not already present. Then you can change the
database directory parameters:

```bash
[couchdb]
database_dir = /home/storage/cozy-data
view_index_dir = /home/storage/cozy-data
```

Once done, you will have to stop couchdb, move your database file then restart
it (as root):

```bash
service stop couchdb
mkdir /home/storage/cozy-data/
# cp here, to have a copy of the data in case of problem.
cp /usr/local/var/lib/couchdb/* /home/storage/cozy-data/
chown -R couchdb:couchdb /home/storage/cozy-data/ # Rights required.
service start couchdb
```

For Debian and Ubuntu, Couchdb is not managed by supervisord:

```bash
service stop couchdb
mkdir /home/storage/cozy-data/
# cp here, to have a copy of the data in case of problem.
cp /var/lib/couchdb/* /home/storage/cozy-data/
chown -R couchdb:couchdb /home/storage/cozy-data/ # Rights required.
service start couchdb
```

**A backup is strongly recommended before performing that operation.** You
could either backup the database files or replicate the database to another
Couchdb instance.


## Use a Let’s Encrypt certificate

See [this post on our blog](https://blog.cozycloud.cc/post/2016/01/06/Lets-Encrypt-certificate-for-your-Cozy) that explains how to generate, install and renew a free certificate on your server with Let’s encrypt.


## Others

### Increase max upload size

If you’re using Nginx as a reverse proxy in front of Cozy, you may notice that you’re not allowed to upload big files. By default, Nginx limit the maximum size of a client request to 1Mo. To increase this limit, just add a [client_max_body_size](http://nginx.org/en/docs/http/ngx_http_core_module.html#client_max_body_size) to your Nginx config.

### Reset internal routes

Ask for proxy to reset its routes via the information stored in the Data
System.

```bash
sudo cozy-monitor reset-proxy
```

