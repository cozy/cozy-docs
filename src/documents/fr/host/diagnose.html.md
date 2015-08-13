---
title: "Diagnostiquer l’état d’un Cozy"
layout: "default"
category: "host"
menuOrder: 4
toc: true
---

# Diagnostiquer l’état d’un Cozy

Si vous rencontrez des soucis avec votre serveur, voici quelques conseils pour essayer d’en déterminer la cause.

Votre serveur utilise un proxy inverse, généralement Apache ou Nginx, qui fait la passerelle avec les logiciels du Cozy lui-même. Si vous n’arrivez pas du tout à vous connecter à l’URL de votre instance, commencez par essayer de redémarrer ce serveur. Par exemple, pour Nginx, avec l’une de ces commandes :

```bash
sudo /etc/init.d/nginx start
sudo service nginx start
```

Si le proxy vous affiche une page d’erreur 502, cela signifie qu’il n’arrive pas à communiquer avec les applications de la pile Cozy. Pour vérifier leur état, tapez :

```bash
sudo supervisorctl status
sudo cozy-monitor status
```

Si l’une des applications surveillées par `supervisorctl` est arrêtée, relancez-la. Par exemple, pour relancer le contrôleur :

```bash
sudo supervisorctl restart cozy-controller
```

Cozy-monitor affiche l’état de toutes les applications, aussi bien de la pile Cozy que de celles que vous avez installées vous-même. Les premières doivent toutes être démarrées : postfix, couch, controller, data-system, home, proxy, index. Si l’une d’elles est arrêtée, relancez-la :

- avec supervisorctl pour le contrôleur et l’indexeur :
```bash
sudo supervisorctl restart cozy-controller
sudo supervisorctl restart cozy-indexer
```

- avec cozy-monitor pour le data-system, la home, et le proxy :
```bash
sudo cozy-monitor start couch
```

- avec les commandes de votre système pour le MTA et CouchDB, par exemple :
```bash
sudo service couchdb restart
sudo /etc/init.d/couchdb restart
```

Si l’un des composants de la pile n’est pas démarré, il est probable que `cozy-monitor` ne puisse découvrir l’état des autres applications et affiche une erreur. Une fois toute la pile démarrée, vous devriez pouvoir découvrir l’état de toutes vos applications.


## CouchDB

Parfois, CouchDB est démarrée, mais inaccessible depuis les applications Cozy. Pour tester son bon fonctionnement :

```bash
sudo cozy-monitor curlcouch /
```

Si tout se passe bien, vous devriez voir quelque chose comme
```
{"db_name":"cozy","doc_count":24,"doc_del_count":0,"update_seq":105,"purge_seq":0,"compact_running":false,"disk_size":233575,"data_size":15079,"instance_start_time":"1434965494928586","disk_format_version":6,"committed_update_seq":105}
```

Sinon, un message d’erreur peut vous mettre sur la piste du problème.


## Si tout a échoué

Enfin, si tout a échoué, vous pouvez télécharger ce [script de diagnostique](http://debian.cozycloud.cc/diag.sh), le lire attentivement et l’adapter à votre configuration, puis l’exécuter et nous envoyer le résultat, afin de nous aider à déterminer la cause du souci.
