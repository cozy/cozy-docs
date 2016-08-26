---
title: "Installer Cozy sur Archlinux"
layout: "default"
category: "host"
menuOrder: 6
toc: false
---


<div class="install-inner-logo">
<img alt="Logo d’Archlinux" src="/assets/images/host/archlinux-logo.svg">
</div>

# Installer Cozy sur Archlinux

## Avertissement

Le paquet Cozy est disponible sur le dépôt d'utilisateurs d'Archlinux, ou **AUR** (pour *Archlinux User Repository*). Ce dépôt n'est pas supporté nativement, il vous faudra donc installer un utilitaire vous permettant d'y accéder, parmi la liste disponible [ici](https://wiki.archlinux.org/index.php/AUR_helpers).

Dans cette documentation, nous utiliserons **Yaourt**, que vous pouvez installer en suivant les instructions disponibles [ici](https://archlinux.fr/yaourt).

## L'installation

Une fois Yaourt installé, entrez la commande suivante :

```
yaourt -S cozy
```

A moins que vous ne souhaitiez bidouiller le paquet, répondez par la négative quand on vous demande si vous voulez modifier les fichiers `PKGBUILD` et `cozy.install`, et par l'affirmative lorsqu'on vous demande si vous souhaitez lancer la compilation du paquet.

Une fois l'installation des dépendances et la création du paquet terminées, Yaourt vous affichera le message suivant :

```
==> Installer cozy ? [O/n]
```
Message auquel vous répondrez par l'affirmative.

S'en suit la procédure d'installation des différents composants de Cozy.

## Configuration initiale

Une fois Cozy installé, il ne sera pas directement utilisable. Il faudra d'abord passer par la configuration du nom du domaine de Cozy et par la configuration d'un [*reverse proxy*](https://fr.wikipedia.org/wiki/Proxy_inverse).

### Configuration du nom de domaine

Le paquet installe un script permettant de modifier le nom de domaine associé à Cozy et de générer les certificats nécessaires à son bon fonctionnement. Il s'exécute avec la commande suivante :

```
sudo configure-cozy-domain cozy.example.tld
```

où on remplacera `cozy.example.tld` par le nom de domaine que l'on souhaite associer à Cozy.

Ce script est utilisable chaque fois que vous souhaitez modifier le nom de domaine de votre Cozy.

### Configuration d'un reverse proxy

Afin de permettre le fonctionnement de Cozy, il est nécessaire d'utiliser un proxy inverse (ou *reverse proxy*). Ce dernier peut être un serveur Web ou n'importe quel programme exécutant cette fonction.

Dans les logiciels permettant d'agir en tant que *reverse proxy*, on observe notamment Apache ou nginx, pour lesquels des exemples de configuration sont fournis ([ici](https://github.com/cozy/cozy-debian/blob/master/apache-config) pour Apache et [ici](https://github.com/cozy/cozy-debian/blob/master/nginx-config) pour nginx).

## Que faire en cas de soucis

Si vous rencontrez un soucis lors de l'installation, merci d'ouvrir un ticket sur [GitHub](https://github.com/babolivier/cozy-archlinux) ou sur [le forum Cozy](https://forum.cozy.io/t/cozy-sur-archlinux/1341).

### Conflit entre `nodejs` et `nodejs-lts-bin`

Afin de permettre le fonctionnement de Cozy, nous avons besoin de la version 4.x.x (LTS) de Node.JS, via le package AUR `nodejs-lts-bin`.

Malheureusement, si vous avez déjà Node.JS d'installé sur votre machine via le paquet officiel `nodejs`, un conflit apparaitra lors de l'installation de `nodejs-lts-bin`. Afin de pallier ce problème, il vous suffit de répondre "o" (ou "oui") quand l'installateur vous demande si vous souhaitez remplacer `nodejs` et `npm`.

### Comment re-générer le certificat ?

    sudo openssl req -x509 -nodes -newkey rsa:2048 -keyout /etc/cozy/server.key -out /etc/cozy/server.crt -days 3650 -subj "/CN=URL.DE.VOTRE.INSTANCE"
