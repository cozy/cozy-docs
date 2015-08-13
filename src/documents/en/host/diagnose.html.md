---
title: "How to diagnose problems"
layout: "default"
category: "host"
menuOrder: 4
toc: true
---

# How to diagnose a Cozy problem

Here are some advises to help diagnose a problem with your server.

We use a reverse proxy as a gateway between your requests and the cozy applications themselves. If you’re unable to connect to the URL of your server, the first step is to check if this proxy is up and running. The commands depend on your Web server and host system. For example, with Nginx, you can try one of this:

```bash
sudo /etc/init.d/nginx start
sudo service nginx start
```

If the proxy displays a 502 error page, it means that it’s unable to connect to the cozy server. So you need to check the state of the components of the cozy stack :

```bash
sudo supervisorctl status
sudo cozy-monitor status
```

If one of the applications monitored by `supervisorctl` is not running, restart it. For example:

```bash
sudo supervisorctl restart cozy-controller
```

Cozy-monitor shows the status of all applications, the Cozy stack and the ones you installed. Every application of the Cozy stack must be started: postfix, couch, controller, data-system, home, proxy, index. If one of them is stopped, restart it:

- use supervisorctl if controller or indexer are down:
```bash
sudo supervisorctl restart cozy-controller
sudo supervisorctl restart cozy-indexer
```

- use cozy-monitor if data-system, home or proxy are down
```bash
sudo cozy-monitor start data-system
```
- use your system’s command for the MTA and CouchDB:

```bash
sudo service couchdb restart
sudo /etc/init.d/couchdb restart
```

If one of the components of the stack is not started, `cozy-monitor` won’t probably be able to check the state of your applications, and will display an error. Once every application of the stack will be started, the full status report should be available.


## CouchDB

Sometime, CouchDB is started but the cozy stack is unable to communicate with it. To check that everything works fine, try:

```bash
sudo cozy-monitor curlcouch /
```

You should get something like
```
{"db_name":"cozy","doc_count":24,"doc_del_count":0,"update_seq":105,"purge_seq":0,"compact_running":false,"disk_size":233575,"data_size":15079,"instance_start_time":"1434965494928586","disk_format_version":6,"committed_update_seq":105}
```

Otherwise, the error message may help to find the origin of the problem.


## If everything failed

If everything else failed, download this [diagnosis script](http://debian.cozycloud.cc/diag.sh), read it carefully and modify it to match your configuration, then execute it and send us the result, so we can help you diagnose the problem.
