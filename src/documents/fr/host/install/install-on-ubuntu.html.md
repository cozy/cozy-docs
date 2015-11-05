---
title: "sur Ubuntu"
layout: "default"
category: "host"
menuOrder: 0
toc: false
---


<div style="height: 0; overflow: shown; text-align: right">
<img alt="Logo d’Ubuntu" src="/assets/images/ubuntu-logo.png">
</div>

# Installer Cozy sur Ubuntu

Vous devez être sous **Ubuntu 14.04 Trusty Tahr** pour pouvoir suivre les étapes ci-dessous.

(Des utilisateurs nous ont signalé que cette procédure pouvait également fonctionner pour GNU/linx Mint)

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
    wget -O - https://ubuntu.cozycloud.cc/cozy.gpg.key 2>/dev/null | sudo apt-key add -
    ```
3. Ajoutez le dépôt Cozy à vos sources de logiciels.
    ```
    echo 'deb https://ubuntu.cozycloud.cc/debian trusty main' \
        | sudo tee /etc/apt/sources.list.d/cozy.list > /dev/null
    ```
4. Installez Cozy
    ```
    sudo apt-get update
    sudo apt-get install cozy
    ```

## Que faire en cas de soucis

### Comment re-générer le certificat ?

    sudo openssl req -x509 -nodes -newkey rsa:2048 -keyout /etc/cozy/server.key -out /etc/cozy/server.crt -days 3650 -subj "/CN=URL.DE.VOTRE.INSTANCE"
