---
title: "Installer Cozy sur Archlinux"
layout: "default"
category: "host"
menuOrder: 6
toc: false
---


<div class="install-inner-logo"> 
<img alt="Logo d’Archlinux" src="/assets/images/archlinux-logo.png">
</div>

# Installer Cozy sur Archlinux

## Avertissement

Les paquets de Cozy sont disponibles sur le dépôt d'utilisateurs d'Archlinux, ou **AUR** (pour *Archlinux User Repository*). Ce dépôt n'est pas supporté nativement, il vous faudra donc installer un utilitaire vous permettant d'y accéder, parmi la liste disponible [ici](https://wiki.archlinux.org/index.php/AUR_helpers).

Dans cette documentation, nous utiliserons **Yaourt**, que vous pouvez installer en suivant les instructions disponibles [ici](https://archlinux.fr/yaourt).

## Choisir le bon paquet

Sous Archlinux, Cozy se décline en trois paquets, dépendant du [reverse proxy](https://fr.wikipedia.org/wiki/Proxy_inverse) que vous souhaitez utiliser avec Cozy :

#### `cozy-nginx`

Ce paquet utilise le serveur Web **nginx** comme *reverse proxy*, et l'installe si cela n'a pas été fait précédemment. Si un serveur nginx tourne déjà sur votre machine, l'utilisation de ce paquet est vivement conseillé. La configuration est effectuée automatiquement, via une inclusion dans `/etc/nginx/nginx.conf`.

#### `cozy-apache`

Ce paquet est exactement le même que le précédent, à la différence qu'il s'adresse au serveur Web **Apache**. La configuration est effectuée automatiquement, via un fichier `/etc/httpd/conf/extra/cozy.conf` inclus dans `/etc/httpd/conf/httpd.conf`.

#### `cozy-standalone`

Ce paquet est à destination des utilisateurs souhaitant configurer eux-même leur *reverse proxy*, qu'il soit nginx, Apache, ou autre. Notez que Cozy nécessite un *reverse proxy* pour fonctionner correctement.

## L'installation

Une fois Yaourt installé et le paquet choisi (qu'on appellera `cozy-xxx` dans cet exemple), entrez la commande suivante :

```
yaourt -S cozy-xxx
```

A moins que vous ne souhaitiez bidouiller le paquet, répondez par la négative quand on vous demande si vous voulez modifier les fichiers `PKGBUILD` et `cozy-xxx.install`, et par l'affirmative lorsqu'on vous demande si vous souhaitez lancer la compilation du paquet.

Le paquet contient dans ses dépendances le paquet `nodejs10`, nécessaire au bon fonctionnement de Cozy, qui compile entièrement Node.JS, ce qui peut prendre beaucoup de temps sur les petites configurations. Patientez jusqu'à la fin de cette compilation.

Une fois l'installation des dépendances et la création du paquet terminées, Yaourt vous affichera le message suivant :

```
==> Installer cozy-xxx ? [O/n]
```
Message auquel vous répondrez par l'affirmative.

S'en suit la procédure d'installation des différents composants de Cozy, et de configuration.

Au cours de l'installation, il vous sera demandé le nom de votre instance Cozy. Il s'agit de l'adresse à laquelle votre instance sera disponible.

## Que faire en cas de soucis

Si vous rencontrez un soucis lors de l'installation, merci d'ouvrir un ticket sur [GitHub](https://github.com/babolivier/cozy-archlinux) ou sur [le forum Cozy](https://forum.cozy.io/t/cozy-sur-archlinux/1341).

### Impossible d'accéder à Cozy

Si votre Cozy n'est pas accessible une fois l'installation terminée, il se peut que la configuration de votre *reverse proxy* ne se soit pas correctement appliquée. Ceci peut être corrigé en rechargeant la configuration du serveur Web :

```
systemctl reload nginx  ## pour nginx
systemctl reload httpd  ## pour apache
```

### Conflit entre `nodejs` et `nodejs10`

Comme précisé ci-dessus, afin de permettre le fonctionnement de Cozy, nous avons besoin de la version 0.10.x de Node.JS, via le package AUR `nodejs10`.

Malheureusement, si vous avez déjà Node.JS d'installé sur votre machine via le paquet officiel `nodejs`, un conflit apparaitra lors de l'installation de `nodejs10`. Afin de pallier ce problème, il vous suffit de répondre "o" (ou "oui") quand l'installateur vous demande si vous souhaitez remplacer `nodejs` et `npm`.

### Comment re-générer le certificat ?

    sudo openssl req -x509 -nodes -newkey rsa:2048 -keyout /etc/cozy/server.key -out /etc/cozy/server.crt -days 3650 -subj "/CN=URL.DE.VOTRE.INSTANCE"
