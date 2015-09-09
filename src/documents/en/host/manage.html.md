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

#### Easy way

The easiest way to update Cozy is to use the Fabric installation file used for
the installation. But in this case, you should not call the installation task but the
update tasks:

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

#### Indexer update

Manual update:

```bash
cd /usr/local/cozy-indexer/cozy-data-indexer
. virtualenv/bin/activate
git pull origin master
pip install --use-mirrors --upgrade -r ./requirements/common.txt
supervisorctl restart cozy-indexer
```

Fabric update:

```bash
fab -H sudoer@host:ip update_indexer
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
sudo cozy-monitor compact-view <view> [database]
```

Compact all views.

```bash
sudo cozy-monitor compact-all-view [database]
```

Backup database by replicating it to another CouchDB instance.

```bash
sudo cozy-monitor backup [target]
```

Clean database.

```bash
sudo cozy-monitor cleanup [database]
```

## Security

For a production usage, you MUST renew the SSL certificate, reset the database credentials and reset the controller token.

For this purpose, use the following command:
```bash
wget https://raw.githubusercontent.com/cozy/cozy-setup/master/fabfile.py
fab -H user@ip reset_security_tokens
```
To use this command, you should install Fabric on your local machine.

You should also change the superuser credentials (and by the way, you should not use a password but a SSH key to connect to your Cozy). Please refer to [this tutorial](http://www.debian-administration.org/article/SSH_with_authentication_key_instead_of_password).


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
supervisorctl stop couchdb
mkdir /home/storage/cozy-data/
# cp here, to have a copy of the data in case of problem.
cp /usr/local/var/lib/couchdb/* /home/storage/cozy-data/
chown -R couchdb:couchdb /home/storage/cozy-data/ # Rights required.
supervisorctl start couchdb
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


## Others

Ask for proxy to reset its routes via the information stored in the Data
System.

```bash
sudo cozy-monitor reset-proxy
```

