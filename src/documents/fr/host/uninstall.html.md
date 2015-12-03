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

### Méthode simple

La méthode la plus simple est d’utiliser la tâche de désinstallation du script
Fabric que vous avez utilisée pour l’installation :

```bash
fab -H user@ip uninstall_all
```

## Suppression manuelle

Si vous voulez désinstaller votre Cozy sans utiliser Fabric, vous pouvez
exécuter les commandes suivantes sur votre serveur :

```bash
supervisorctl stop cozy-controller
supervisorctl stop cozy-indexer
service stop couchdb
rm -rf /usr/local/var/cozy-indexer
rm -f /etc/supervisor/conf.d/cozy-controller.conf
rm -f /etc/supervisor/conf.d/cozy-indexer.conf
rm -rf /usr/local/cozy
rm -rf /etc/cozy
rm -rf /usr/local/var/cozy/
apt-get purge supervisord
```
