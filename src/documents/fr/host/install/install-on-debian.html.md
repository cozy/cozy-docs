---
title: "sur Debian"
layout: "default"
category: "host"
menuOrder: 1
toc: false
---


<div style="height: 0; overflow: shown; text-align: right">
<img src="/assets/images/debian-logo.png">
</div>

# Installer Cozy sur Debian

Vous devez être sous **Debian 8 Jessie (stable)** pour pouvoir suivre les étapes ci-dessous.

<br>

1. Assurez-vous que le paquet `ca-certificates` est bien installé
    ```
    apt-get install ca-certificates
    ```
2. Importez la clé publique du dépôt
    ```
    wget -O - http://ubuntu.cozycloud.cc/cozy.gpg.key 2>/dev/null | apt-key add -
    ```
3. Ajoutez le dépôt Cozy à vos sources de logiciels.
    ```
    echo 'deb http://debian.cozycloud.cc/debian jessie main' \
    > /etc/apt/sources.list.d/cozy.list
    ```
4. Installez Cozy
    ```
    apt-get update
    apt-get install cozy
    ```
