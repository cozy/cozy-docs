---
title: "Installer Cozy sur Raspberry Pi"
layout: "default"
category: "host"
menuOrder: 4
toc: false
---


<div class="install-inner-logo">
<img alt="Logo de Raspberry" src="/assets/images/raspberry-logo.png">
</div>

# Installer Cozy sur un Raspberry Pi

**Vous aurez besoin du dernier [Raspberry Pi 2 ou Raspberry Pi 3](http://fr.wikipedia.org/wiki/Raspberry_Pi)
pour y faire tourner Cozy efficacement.**

**L’utilisation d’une carte SD rapide (class10) est fortement recommandée.**

Pour installer Cozy sur votre Raspberry Pi, vous devez :

* Télécharger notre [image](https://files.cozycloud.cc/raspberrypi/cozy-raspberrypi_latest.img.xz) et la décompresser (`xz -d cozy-raspberrypi_4.1.0.img.xz` sur Linux, utilisez votre logiciel de décompression préféré sur Windows et MacOs).
* Télécharger les signatures de l'image [ici](https://files.cozycloud.cc/raspberrypi/cozy-raspberrypi_latest.img.xz.sha512.asc) et [ici](https://files.cozycloud.cc/raspberrypi/cozy-raspberrypi_latest.img.xz.sha512).
* Vérifier l'intégrité de l'image :

```
gpgv2 -v cozy-raspberrypi_4.1.0.img.xz.sha512.asc
sha512sum -c cozy-raspberrypi_4.1.0.img.xz.sha512
```

L’image est basée sur la distribution [Raspbian Jessie lite](https://www.raspberrypi.org/downloads/raspbian/).

**ATTENTION :** cette opération va irrémédiablement supprimer toutes les
données présentes sur la carte.

Suivez le guide officiel sur [Installing operating system images](https://www.raspberrypi.org/documentation/installation/installing-images/README.md).

---

Insérez à présent la carte SD dans le lecteur de votre Raspberry Pi et démarrez
le.

Vous pouvez accéder à votre Cozy via `https://cozy.local/`.

Pour vous connecter à la carte, utilisez les informations de connexion par
défaut de Raspbian : ```pi``` and ```raspberry``` :

```bash
$ ssh pi@cozy.local # ou ssh pi@<ip-du-raspberrypi>
```

Pour étendre la partition, suivez ces étapes :

* connectez vous au PI en SSH
* exécutez cette commande: `/usr/bin/raspi-config --expand-rootfs`

# En cas de problèmes…

## L'hôte cozy.local ne fonctionne pas

Vous pourrez trouver l’adresse de votre Raspberry Pi via la console. Sinon vous pouvez
utiliser `nmap` sur votre machine locale :

```
$ nmap -T4 -sP 192.168.x.0/24 # Ou votre sous-réseau
```

## Système de fichiers corrompu

Après un arrêt brutal de votre Raspberry, il se peut que le serveur refuse de redémarrer. Branchez alors un écran pour afficher le message d’erreur. Si vous voyez « vfs unable to mount root fs on unknown-block », cela signifie que le système de fichiers de la carte est corrompu. Vous pouvez essayer de le réparer en connectant la carte à un autre ordinateur, utilisant `lsblk` pour identifier son point de montage, puis `e2fsck` pour tenter de corriger les erreurs.
