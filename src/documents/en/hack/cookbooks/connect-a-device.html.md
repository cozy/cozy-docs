---
title: "Connect a device to a Cozy"
layout: "default"
category: "hack"
menuOrder: 9
toc: true
---

# Device connection


## Device register
To register a device in your cozy you have to post a request as user 'owner' and your Cozy password. 
Your body should content your device description with login and permissions.  You'll receive a content with device information whose device password.



**REQUEST**
```bash
curl -X POST -H '{Content-Type:application/json}' https://owner:<yourCozyPassword>@<cozyUrl>/device -d '{"login":"<deviceLogin>", "permissions": {"File": {"description": "Synchronize files"}} }'
```
**RESPONSE**
```bash
{"password":"<devicePassword>","login":"<deviceLogin>","permissions":{"File":{"description":"Synchronize files"}}}
```


## Usage

Once device registered, you can use :
* [Data System API](/hack/cookbooks/data-system.html).
* Replication.

### Data system API
To access to Data System API, you have to replace your cozy url by `<CozyUrl>/ds-api`. Your device can access to data only if it has correct permissions.
As an example, if I want to access to data with id `<id>` in couchDB.

**APPLICATION**
```bash
curl http://<appName>:<appPassword>@localhost:9101/data/<id>/
```

**DEVICE**
```bash
curl https://<deviceName>:<devicePassword>@<cozyUrl>/ds-api/data/<id>/
```

### Replication
You can replicate a part of your database with your device. You must have permissions on replicated data.
For that, you can do a classic replication on `https://<cozyUrl>/replication` with your device authentication.


## Device unregister
To unregister a device from your Cozy, you can remove it with your home interface (in Status page) or request your cozy.

```bash
curl -X DELETE https://owner:<yourCozyPassword>@<cozyUrl>/device/<monDevice>
```
