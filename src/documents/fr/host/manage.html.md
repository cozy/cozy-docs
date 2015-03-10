---
title: "Gérez votre instance"
layout: "default"
category: "host"
menuOrder: 1
toc: true
---
# Gérez votre instance Cozy

## Maintenance
### Mise à jour

#### La méthode simple

Le moyen le plus simple de mettre à jour votre instance est d’utiliser le
script Fabric d’installation. Il suffit d’appeler la tâche de mise à jour
au lieu de celle d’installation :

```bash
fab -H user@ip update_stack
fab -H user@ip update_all_apps
```

#### Mise à jour manuelle

Si vous voulez mettre à jour votre instance sans utiliser Fabric, vous pouvez
exécuter les commandes suivantes directement dans votre serveur :

```bash
sudo cozy-monitor update data-system
sudo cozy-monitor update home
sudo cozy-monitor update proxy
sudo supervisorctl stop cozy-controller
sudo pkill -9 node # make sure no process is remaining.
sudo npm -g update cozy-controller
sudo supervisorctl start cozy-controller
```

#### Mise à jour de l’indexeur

Mise à jour manuelle :

```bash
cd /usr/local/cozy-indexer/cozy-data-indexer
. virtualenv/bin/activate
git pull origin master
pip install --use-mirrors --upgrade -r ./requirements/common.txt
supervisorctl restart cozy-indexer
```

Mise à jour en utilisant Fabric :

```bash
fab -H sudoer@host:ip update_indexer
```


#### Mise à jour des applications

Pour mettre à jour une application, lancez cette commande dans votre serveur :

```bash
sudo cozy-monitor update <app>
```

### Redémarrer la pile Cozy

La pile Cozy comprend les applications Home, Proxy et Data System, c’est à dire
les applications qui permettent le fonctionnement de votre instance.

```bash
cozy-monitor restart-cozy-stack
```
### Obtenir des informations sur votre instance

Avoir la liste des applications et leur statut (allumée ou éteinte) :

```bash
cozy-monitor status
```

Afficher la version des applications de la pile :

```bash
cozy-monitor versions
```

Afficher la version de toutes les applications installées :

```bash
cozy-monitor versions-apps
```

## Gestion des applications

### Installation

Pour installer une application depuis la ligne de commande, utilisez :

```bash
cozy-monitor install <app> [-r <repo>] [-d <displayName>] [-b <branch>]
```

Si l’application n’est pas maintenue par CozyCloud, il faut préciser l’adresse
de son dépôt. Vous pouvez également préciser une branche du dépôt à utiliser,
et le nom sous lequel l’application apparaitra sur la page d’accueil.


### Gestion

Pour stopper une application :

```bash
cozy-monitor stop <app>
```

Pour stopper toutes les applications :

```bash
cozy-monitor stop-all <app>
```

Pour démarrer une application :

```bash
cozy-monitor start <app>
```

Pour redémarrer une application

```bash
cozy-monitor restart <app>
```

Pour mettre à jour une application (cela implique de cloner le dépôt Git,
exécuter `npm install` et re-démarrer l’applicationi). Préciser l’adresse du
dépôt n’est nécessaire que pour utiliser un dépôt spécifique :

```bash
cozy-monitor update <app> [repo]
```

Mettre à jour toutes les applications installées :

```bash
cozy-monitor update-all
```


### Désinstallation

Pour désinstaller une application, tapez simplement :

```bash
cozy-monitor uninstall <app>
```

## Gestion de la base de données

Par défaut, le nom de la base de données utilisée par ces commandes est `cozy`.

Pour compresser la base (en supprimant les versions non utilisées des documents) :

```bash
cozy-monitor compact [database]
```

Compresser une vue CouchDB spécifique :

```bash
cozy-monitor compact-view <view> [database]
```

Compresser toutes les vues :

```bash
cozy-monitor compact-all-view [database]
```

Faire une sauvegarde de la base en la répliquant sur une autre instance CouchDB :

```bash
cozy-monitor backup [target]
```

Nettoyer la base de données :

```bash
cozy-monitor cleanup [database]
```

## Commandes diverses

Recharger toutes les routes du Proxy applicatif à partir du système de données :

```bash
cozy-monitor reset-proxy
```

Exécuter un script fourni par une application (option dépréciée) :

```bash
cozy-monitor script <app> <script> [argument]
```


## Augmenter l’espace disque

Toutes les données et les fichiers sont stockés dans CouchDB.  Le moyen le plus
simple d’allouer plus d’espace disque à votre instance est de modifier la
configuration de CouchDB.  Actuellement, les données sont enregistrées dans le
dossier :

```bash
/usr/local/var/lib/couchdb/
```

Vous pouvez modifier ce chemin, par exemple pour le faire pointer vers un autre
disque avec plus d’espace libre.  Pour cela, éditez le fichier :

```bash
/usr/local/etc/couchdb/local.ini
```

Ajoutez une section couchdb si elle n’es pas déjà présente. Vous pouvez alors
modifier le paramètre spécifiant le dossier où est stocké la base de données :

```bash
[couchdb]
database_dir = /home/storage/cozy-data
view_index_dir = /home/storage/cozy-data
```

Ceci fait, il faut couper CouchDB, déplacer le fichier contenant la base, puis
la relancer :

```bash
supervisorctl stop couchdb
mkdir /home/storage/cozy-data/
# cp here, to have a copy of the data in case of problem.
cp /usr/local/var/lib/couchdb/* /home/storage/cozy-data/
chown -R couchdb:couchdb /home/storage/cozy-data/ # Rights required.
supervisorctl start couchdb
```

**Il est fortement recommandé de sauvegarder vos données avant une telle
opération** Vous pouvez soit faire une sauvegarde des fichiers contenant la
base, soit répliquer la base sur une autre instance CouchDB.

