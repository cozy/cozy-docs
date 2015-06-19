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

```
root@ubuntu-14-04:~# lsb_release -c
Codename:     trusty
```

<br>

1. Assurez-vous que les paquets `ca-certificates` et `apt-transport-https` sont bien installés
    ```
    sudo apt-get install ca-certificates apt-transport-https
    ```
2. Importez la clé publique du dépôt
    ```
    sudo wget -O - https://ubuntu.cozycloud.cc/cozy.gpg.key 2>/dev/null | apt-key add -
    ```
3. Ajoutez le dépôt Cozy à vos sources de logiciels.
    ```
    echo 'deb https://ubuntu.cozycloud.cc/debian trusty main' \
    > /etc/apt/sources.list.d/cozy.list
    ```
4. Installez Cozy
    ```
    sudo apt-get update
    sudo apt-get install cozy
    ```
