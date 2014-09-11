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
Display installed application with their status (up or down).

```bash
cozy-monitor status
```

Display cozy stack modules version

```bash
cozy-monitor versions
```
Display installed applications versions

```bash
cozy-monitor versions-apps
```

## Applications management

### Installation
Install given application. If it is not an official Cozy application you should
give repo location too.

```bash
cozy-monitor install <app> [--repo <repo>]
```


### Manage
Stop application with given name.

```bash
cozy-monitor stop <app>
```

Start application with given name.

```bash
cozy-monitor start <app>
```

Restart application with given name.

```bash
cozy-monitor restart <app>
```

Update application with given name (git clone + npm install + restart).

```bash
cozy-monitor update <app>
```

Update all applications. This commands update cozy stack applications and others applications installed by cozy user

```bash
cozy-monitor update-all
```

Run Brunch build for the client of given application.

```bash
cozy-monitor brunch <app>
```


### Uninstallation

Uninstall application with given name.

```bash
cozy-monitor uninstall <app>
```

Uninstall all applications.

```bash
cozy-monitor uninstall-all
```
Warning: this commands uninstall also cozy stack applications.

## Database management
By default, database option is "cozy".

Run compact CouchDB command on database (remove unused revisions).

```bash
cozy-monitor compact [database]
```

Compact a given CouchDB view.

```bash
cozy-monitor compact-view <view> [database]
```

Compact all views.

```bash
cozy-monitor compact-all-view [database]
```

Backup database by replicating it to another CouchDB instance.

```bash
cozy-monitor backup [target]
```

Clean database.

```bash
cozy-monitor cleanup [database]
```

## Others

Ask for proxy to reset its routes via the information stored in the Data
System.

```bash
cozy-monitor reset-proxy
```

Launch script that comes with given application (deprecated).

```bash
cozy-monitor script <app> <script> [argument]
```


## Provide more disk space


All data and files are stored in CouchDB. So, the simplest way to add more disk 
space is to change your CouchDB configuraion. Currently your data are saved in
that folder:
 
```bash
/usr/local/var/lib/couchdb/
```

You could change that directory where you want, on a mounting point with more
free disk space. For that, open the following file:

```bash
/usr/local/etc/couchdb/local.ini
```

Add the couchdb section if it is not already present. Then you can change the
database directory parameters:

```bash
[couchdb]
database_dir = /home/storage/cozy-data
view_index_dir = /home/storage/cozy-data
```

Once done, you will have to stop couchdb, move your database file then restart
it:

```bash
supervisorctl stop couchdb
mkdir /home/storage/cozy-data/
# cp here, to have a copy of the data in case of problem.
cp /usr/local/var/lib/couchdb/* /home/storage/cozy-data/ 
chown -R couchdb:couchdb /home/storage/cozy-data/ # Rights required.
supervisorctl start couchdb
```

**A backup is strongly recommended before performing that operation.** You
could either backup the database files or replicate the database to another
Couchdb instance.

