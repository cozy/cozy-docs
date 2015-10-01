---
title: "Debug in production environment"
layout: "default"
category: "hack"
menuOrder: 7
toc: true
---

# Debug application in a production environment

In production environment, to access to data, applications should be authenticated by Data-System and have correct permissions. That's why, you cannot start application in the same way as in your development environment.

## Applications logs

* Applications logs are stored in directory `\usr\local\var\log\cozy`.
For each application, you have a file `<app>.log` where you can find current logs and a file `<app>.log-backup` with old logs.


* Only controller logs are stored in a different place: `\var\log\supervisorctl\cozy-controller-stdout...`

## Start an application in a cozy.

If you want start application without controller, you can start it with:

```bash
cozy-monitor start-standalone <port>
```

This command should be executed in application source root.
Option is the port used by your application.
This function installs your application in your cozy and gives it its permission.


Once, you have finish your debug, you can uninstall your application with:

```bash
cozy-monitor stop-standalone
```

## Access to database

### Databrowser
To see your documents in your database, you can use databrowser application.
You can find this application in cozy market place.

**Warning**: this application comes from our community, it's not maintained by Cozy Team.

### Ssh tunneling
Otherwise, you can execute a ssh tunneling on port 5984 from your cozy to your host.
After that, you can access to couchdb interface on `http://localhost:5984/_utils/index.html`