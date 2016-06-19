---
title: "Désinstaller"
layout: "default"
category: "host"
menuOrder: 3
toc: true
---

# Désinstaller votre instance Cozy

**Attention : désinstaller votre instance Cozy supprimera toutes les données
que vous y avez stockées. Sauvegardez-les si nécessaire !**

## Instance dans une machine virtuelle ou un conteneur

Si vous avez installé votre instance dans une machine virtuelle ou un conteneur,
il suffit de les supprimer.

## Instance sur un serveur

### Suppression manuelle

Pour supprimer toute trace de Cozy sur votre serveur, vous pouvez
exécuter les commandes suivantes sur votre serveur :

```bash
supervisorctl stop cozy-controller
supervisorctl stop cozy-indexer
service couchdb stop
rm -rf /usr/local/var/cozy-indexer
rm -f /etc/supervisor/conf.d/cozy-controller.conf
rm -f /etc/supervisor/conf.d/cozy-indexer.conf
rm -rf /usr/local/cozy
rm -rf /etc/cozy
rm -rf /usr/local/var/cozy/
apt-get purge supervisor
```
