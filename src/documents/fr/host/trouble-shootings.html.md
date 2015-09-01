---
title: "En cas de soucis"
layout: "default"
category: "host"
menuOrder: 2
toc: true
---

# Que faire en cas de soucis

Vous trouverez ici le moyen de résoudre la plupart des soucis qui peuvent survenir lors de l’installation de votre instance Cozy. Si vous rencontrez des problèmes qui ne sont pas listés ici, n’hésitez pas à nous les signaler, et nous enrichirons ce document dès que possible.

## Je n’arrive à installer qu’une seule application

*Description :* Lorsque vous essayez d’installer une application, l’installation
échoue et l’application est marquée comme cassée. Ce comportement se reproduit
pour chaque application que vous essayez d’installer.

*Solution :* Vérifiez la quantité de mémoire disponible dans votre instance. Les
informations sur votre instance sont disponibles sur la page de gestion des
applications, à laquelle vous pouvez accéder depuis la page d’accueil. Si votre
instance n’a plus assez de RAM, vous ne pourrez pas installer de nouvelles
applications.

## L’installation ne s’achève pas jusqu’à ce que je rafraichisse la page avec F5

C’est probablement dû à un problème de synchronisation entre le gestionnaire de
données de Cozy et la base de données. Pour le résoudre, connectez-vous en
console à votre instance et redémarrez le gestionnaire de données :

```bash
sudo cozy-monitor restart data-system
```

## Des erreurs apparaissent sur la page de connexion

### Problème avec la page d’accueil

Vérifiez que l’application gérant la page d’accueil est bien installée.
Pointez votre navigateur vers
[https://yourcozyurl/status](https://yourcozyurl/status).  Vous devriez
récupérer un fichier JSON contenant la liste des applications de la pile Cozy
et leur statut.  Vérifiez qu’elles sont toutes installées (valeur à `true`).
Si la page d’accueil (`home`) est à `false`, connectez-vous à la console de
votre instance pour la réinstaller :

```bash
cozy-monitor uninstall home
cozy-monitor install home
```

### Problèmes avec le système de données

Connectez-vous à la console de votre instance et vérifiez les fichiers journaux,
notamment `/usr/local/cozy/apps/data-system/data-system/cozy-data-system/log/production.log`.
Si ce fichier contient des lignes comme `Database cozy on localhost:5984
doesn't exist.` et `The database could not be created, the file already exists.`,
cela signifie que le système de données de l’instance n’arrive pas à se connecter
à la base de données. Une réinstallation devrait régler l’affaire :

```bash
cozy-monitor uninstall data-system
cozy-monitor install data-system
cozy-monitor restart home
cozy-monitor restart proxy
```

### Erreurs Npm

Cozy est basé sur Node.js et le gestionnaire de paquets Npm. Les applications
téléchargent les outils dont elles ont besoin depuis les dépôts de Npm. Il
arrive que ceux-ci soient temporairement inaccessibles, générant des erreurs
lors de l’installation d’application. Si vous rencontrez de telles erreurs,
attendez un peu et essayez à nouveau d’exécuter l’application.


## Cozy sur des processeurs ARM

### Node.js

Node.js a besoin d’une configuration spécifique pour fonctionner sur un
Raspberry Pi. Installez la version binaire de Node spécifique disponible
sur leur site.

Concernant les autres processeurs ARM, nous avons réussi à compiler Node pour
l’A20 Allwinner.


### Nginx

Voici un [bon tutoriel](http://virtualitblog.blogspot.fr/2013/05/install-nginx-141-raspberry-pi.html)
(en anglais et uniquement pour les distributions basées sur Debian) pour
installer Nginx sur un Raspberry Pi.

Vous pouvez le télécharger ici : [http://nginx.org/packages/debian/pool/nginx/n/nginx/](http://nginx.org/packages/debian/pool/nginx/n/nginx/)


## Le contrôleur ne démarre pas

Si, lorsque vous installez une application en ligne de commande avec `cozy-monitor`,
vous faites face à des erreurs `ECONNRESET`, vérifiez que `cozy-controller` est
bien démarré :

```bash
sudo supervisorctl
```

Et vérifiez que `cozy-monitor` utilise le port 9002 :

```bash
sudo netstat -plunt | grep 9002
tcp     0     0 0.0.0.0:9002      0.0.0.0:*        LISTEN      997/node
```


## Mot de passe CouchDB

Si vous ré-installez plusieurs fois votre instance Cozy, le mot de passe de la
base CouchDB et celui utilisé par le système de données de Cozy peuvent devenir
différents. Pour réinitialiser le mot de passe, éditez le fichier
`/usr/local/etc/couch/local.ini` et mettez en commentaire la dernière ligne
de la section `admin`, puis effacez le fichier `/etc/cozy/couchdb.login` et
re-lancez l’installation, ou exécutez :

```bash
fab config_couchdb
```

## Processus dupliqués

Il arrive parfois qu’un processus Node.js soit dupliqué. Dans ce cas, le moyen
le plus simple pour retourner à un état normal est d’exécuter :

```bash
sudo supervisorctl stop cozy-controller
sudo pkill -9 node
sudo supervisorctl start cozy-controller
```

## J'ai perdu mon mot de passe Cozy

Si vous avez perdu votre mot de passe, la première chose à faire est de cliquer sur le lien `Mot de passe oublié` afin de le recevoir par email.

Si vous hébergez Cozy sur un serveur qui ne dispose pas de serveur email (comme Postfix par exemple), il vous faudra accéder à la page `Futon Web Admin` pour supprimer l'utilisateur courant. Vous avez 2 options:

#### Vous pouvez accéder à 127.0.0.1 via un navigateur

Cela devrait être le cas si vous hébergez Cozy sur votre propre serveur.

Naviguez sur `http://localhost:5984/_utils/`

#### Vous utilisez un nom de domaine pour accéder à Cozy

Cela devrait être le cas si vous hébergez Cozy sur un VPS par exemple.
Pour éviter d'ouvrir l'accès à CouchDB à toutes les IP externes, nous utiliserons SSH.
Sur le terminal de votre poste, tapez:

```
ssh -L 5984:127.0.0.1:5984 cozy.mydomain.com
```

Si vous avez déjà une instance CouchDB lancée sur votre serveur, vous devrez propablement changer le premier `5984`. Choisissez n'importe quel port disponible.
Vous avez maintenant accès à `http://127.0.0.1:5984/_utils/`

Une fois fait, vous devez vous connecter. Le lien de connexion est tout en bas à droite de la page. Vous trouverez vos identifiants CouchDB pour Cozy dans le fichier `/etc/cozy/couchdb.login`. La première ligne correspond au login, la seconde au mot de passe.

Une fois connecté, utilisez le menu déroulant `View` et choisissez `User -> all`. Vous devriez voir une ligne, que vous pouvez supprimer.
En rafraîchissant la page de votre Cozy, celui-ci devrait vous proposer de vous enregistrer.
