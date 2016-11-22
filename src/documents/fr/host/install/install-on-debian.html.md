---
title: "Installer Cozy sur Debian"
layout: "default"
category: "host"
menuOrder: 5
toc: false
---


<div class="install-inner-logo">
<img alt="Logo de Debian" src="/assets/images/host/debian-logo.svg">
</div>

# Installer Cozy sur Debian

Vous devez être sous **Debian 8 Jessie (stable)** pour pouvoir suivre les étapes ci-dessous.
<br>
<br>
<br>

```
root@debian-8:~# lsb_release -c
Codename:     jessie
```

Si `lsb_release` n'est pas installé, vous être probablement sur une version
trop ancienne de Debian. Vous pouvez vous en assurer en regardant la version
de cette façon :

```
root@debian-8:~# cat /etc/debian_version
8.1
```

<br>

Cozy a besoin d’un serveur web. Par défaut, nous installons et configurons un serveur Nginx, mais si un serveur Web est déjà installé, vous pouvez l’utiliser en ajoutant un hôte virtuel pour Cozy.

<br>

1. Assurez-vous que les paquets `wget`, `ca-certificates` et `apt-transport-https` sont bien installés
    ```
    apt-get install wget ca-certificates apt-transport-https
    ```
2. Importez la clé publique du dépôt
    ```
    wget https://debian.cozycloud.cc/cozy.gpg.key -O /etc/apt/trusted.gpg.d/cozy.gpg
    ```
3. En option, vérifiez que la clé importée est valide
    ```
    apt-key --keyring /etc/apt/trusted.gpg finger
    ```
    Vous devriez lire:
    ```
    pub   2048R/2765B235 2014-11-17 [expires: 2016-11-17]
          Key fingerprint = E28C F8B2 ABBF E285 743B  27F1 BCB2 ED5D 2765 B235
    uid                  Cozy Debian Packaging <debian-packaging@cozycloud.cc>
    sub   2048R/D58A9D35 2014-11-17 [expires: 2016-11-17]
    ```
4. Ajoutez le dépôt Cozy à vos sources de logiciels.
    ```
    echo 'deb https://debian.cozycloud.cc/debian jessie cozy' \
    > /etc/apt/sources.list.d/cozy.list
    ```
5. Installez Cozy
    ```
    apt-get update ;
    apt-get install python-cozy-management ;
    cozy_management install_cozy
    ```
    (lisez également le paragraphe ci-dessous à propos des dépendances)

6. Assurez vous que le service Nginx est bien démarré :
    ```
    service nginx start
    ```

7. Paramétrez votre compte Cozy et profitez !
    ```
    https://your-cozy-IP/
    ```

## Que faire en cas de soucis

### À propos des dépendances

Pour fonctionner, Cozy a absolument besoin d’une base de données CouchDB, celle-ci sera donc installée automatiquement. Mais il a également besoin d’un serveur SMTP écoutant sur le port 25 de la machine, et d’un serveur Web agissant comme un proxy inversé. Le paquet Cozy n’impose pas l’installation de ces composants, car, selon votre configuration, vous pouvez vous en passer (le proxy peut par exemple être installé sur une autre machine). Cependant, pour une installation basique de Cozy, vous devriez installer les dépendances recommandées en utilisant la commande `apt-get install --install-recommends cozy`.

Les paquets recommandés sont :

* un serveur Web, de préférence Nginx. Il va gérer les certificats SSL et rediriger les requêtes vers le serveur Cozy lui-même ;
* un serveur SMTP, pour envoyer des messages de la part de votre Cozy (par exemple pour réinitialiser votre mot de passe, vous rappeler un rendez-vous ou inviter des contacts à un évènement).

### Comment re-générer le certificat ?

    sudo openssl req -x509 -nodes -newkey rsa:2048 -keyout /etc/cozy/server.key -out /etc/cozy/server.crt -days 3650 -subj "/CN=URL.DE.VOTRE.INSTANCE"

### Debian 8 : la version de nodejs

Les versions récentes de Cozy nécessitent nodejs 4.x, et Cozy est tellement sympa que son installeur "cozy_management" comprend une étape qui :
* Inclue le dépôt nodesource.com dans les sources APT
* Installe nodejs 4.x à partir de ce dépôt

Le problème, c'est que Debian 8 (Jessie) propose déjà, dans ses dépôts standards, une version de nodejs, malheureusement obsolète (0.10.x) ; et que si vous avez eu le malheur, par le passé, d'installer nodejs via le dépôt standard de Debian, cette version, même désinstallée via un bon vieux `apt-get purge nodejs`, entrera en conflit avec l'installation de nodejs 4.x, ce qui fera planter toute l'installation de Cozy. De plus, le message d'erreur que vous rencontrerez sera très bas niveau :
```
update-alternatives: error: alternative link /usr/bin/node is already managed by nodejs
dpkg: error processing package nodejs (--configure): subprocess installed post-installation script returned error exit status
```
La solution (qui nous vient de [cette question StackOverflow](http://stackoverflow.com/questions/25094718/error-on-update-alternatives-when-installing-upgrading-nodejs-v0-10-30)) : `update-alternatives --remove-all nodejs`, qui supprime toute trace de nodejs 0.10.x de votre système et laisse ainsi la voie libre à Cozy pour installer nodejs 4.x.
