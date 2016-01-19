---
title: "sur un Raspberry Pi"
layout: "default"
category: "host"
menuOrder: 2
toc: false
---


<div style="height: 0; overflow: shown; text-align: right">
<img alt="Logo de Raspberry" src="/assets/images/raspberry-logo.png">
</div>

# Installer Cozy sur un Raspberry Pi

**Vous aurez besoin du dernier [Raspberry Pi 2](http://fr.wikipedia.org/wiki/Raspberry_Pi)
pour y faire tourner Cozy efficacement.**

**L’utilisation d’une carte SD rapide (class10) est fortement recommandée.**

---

*Note pour les possesseurs de Raspberry Pi :* Cozy demande un peu trop de
ressources pour fonctionner correctement sur les précédents modèles B et B+
de Raspberry Pi. Pour ces modèles, une version alternative et plus légère de
Cozy existe : [Cozy Light](https://github.com/cozy-labs/cozy-light).

---

Le moyen le plus simple d’utiliser Cozy sur un Raspberry Pi 2 est de
télécharger notre image et de l’installer sur une carte SD. L’image est basée
sur la distribution [Raspbian Jessie lite](https://www.raspberrypi.org/downloads/raspbian/).

Commencez par télécharger l’archive :

```bash
# Téléchargez l’image (environ 680MB)
wget https://files.cozycloud.cc/cozy-raspberrypi-latest.zip

# Décompressez-la
unzip cozy-raspberrypi-latest.zip
```

**ATTENTION :** cette opération va irrémédiablement supprimer toutes les
données présentes sur la carte.

Suivez le guide [Installing operating system images](https://www.raspberrypi.org/documentation/installation/installing-images/README.md).

---

Insérez à présent la carte SD dans le lecteur de votre Raspberry Pi et démarrez
le.

Vous pourrez trouver l’adresse de votre Raspberry Pi sur la console. Sinon vous pouvez
utiliser `nmap` sur votre machine locale :

```
$ nmap -T4 -sP 192.168.x.0/24 # Ou votre sous réseau
```

Pour vous connecter à la carte, utilisez les informations de connexion par
défaut de Raspbian : ```pi``` and ```raspberry``` :

```bash
$ ssh pi@<ip-du-raspberrypi>

# Passer en root pour la suite des commandes :
sudo -s

## Remettre à zéro les tokens CouchDB :

# Arrêter le cozy :
supervisorctl stop cozy-controller

# Vérifier les informations de connexion à la base de données :
admin_user="$(sed -n '1,1p' /etc/cozy/couchdb.login)";admin_pass="$(sed -n '2,1p' /etc/cozy/couchdb.login)";curl http://${admin_user}:${admin_pass}@127.0.0.1:5984/cozy

# Supprimer l'utilisateur CouchDB :
admin_user="$(sed -n '1,1p' /etc/cozy/couchdb.login)";admin_pass="$(sed -n '2,1p' /etc/cozy/couchdb.login)";curl -X DELETE http://${admin_user}:${admin_pass}@127.0.0.1:5984/_config/admins/${admin_user}

# Vérifier que l'utilisateur est bien supprimé :
curl http://127.0.0.1:5984/_config/admins/

# Dois renvoyer : {}

# Si c'est bon, supprimer le fichier avec les informations de connexions :
rm /etc/cozy/couchdb.login

# Si vous voulez changer le FQDN du certificat autosigné :
rm /etc/cozy/server.crt /etc/cozy/server.key

# Reconfigurer les tokens d'accès à CouchDB et le certificat SSL :
dpkg-reconfigure cozy

# Agrandir le système de fichier /
/usr/bin/raspi-config --expand-rootfs

# Vous pouvez en profiter pour changer le mot de passe de pi :
passwd pi

# Redémarer le Raspberry π2
systemctl reboot
```

Une fois redémarré, vous devriez pouvoir accéder à votre instance Cozy en vous
connectant au port 443 via le protocole https.

`https://<ip-du-raspberrypi>`

**ATTENTION :** l’installation, la configuration et le démarrage de Cozy peuvent
être assez lentes, il n’est pas rare de devoir attendre près d’une heure avant
que le serveur ne soit prêt et à l’écoute sur le port 443.  Laissez-lui un peu
de temps avant de vous inquiéter.

# En cas de problèmes…

## Système de fichiers corrompu

Après un arrêt brutal de votre Raspberry, il se peut que le serveur refuse de redémarrer. Branchez alors un écran pour afficher le message d’erreur. Si vous voyez « vfs unable to mount root fs on unknown-block », cela signifie que le système de fichiers de la carte est corrompu. Vous pouvez essayer de le réparer en connectant la carte à un autre ordinateur, utilisant `lsblk` pour identifier son point de montage, puis `e2fsck` pour tenter de corriger les erreurs.
