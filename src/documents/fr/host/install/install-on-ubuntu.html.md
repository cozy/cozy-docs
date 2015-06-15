---
title: "sur Ubuntu"
layout: "default"
category: "host"
menuOrder: 0
toc: false
---


<div style="height: 0; overflow: shown; text-align: right">
<img src="/assets/images/ubuntu-logo.png">
</div>

# Installer Cozy sur Ubuntu

Vous devez être sous **Ubuntu 14.04 Trusty Tahr** pour pouvoir suivre les étapes ci-dessous.

<br>

1. Importez la clé publique du dépôt
    ```
    wget -O - http://ubuntu.cozycloud.cc/cozy.gpg.key 2>/dev/null | apt-key add -
    ```
2. Ajoutez le dépôt Cozy à vos sources de logiciels.
    ```
    echo 'deb [arch=amd64] http://ubuntu.cozycloud.cc/debian trusty main' \
    > /etc/apt/sources.list.d/cozy.list
    ```
3. Installez Cozy
    ```
    apt-get update
    apt-get install cozy
    ```
