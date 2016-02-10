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

1. Assurez-vous que les paquets `wget`, ca-certificates` et `apt-transport-https` sont bien installés
    ```
    sudo apt-get install ca-certificates apt-transport-https
    ```
2. Importez la clé publique du dépôt
    ```
    wget -O - https://ubuntu.cozycloud.cc/cozy.gpg.key 2>/dev/null | sudo apt-key add -
    ```
3. Ajoutez le dépôt Cozy à vos sources de logiciels.
    ```
    echo 'deb https://ubuntu.cozycloud.cc/debian trusty cozy' \
        | sudo tee /etc/apt/sources.list.d/cozy.list > /dev/null
    ```
4. Installez Cozy
    ```
    sudo apt-get update
    apt-get install -y python-cozy-management
    cozy_management install_cozy
    ```
    (lisez également le paragraphe ci-dessous à propos des dépendances)

5. Assurez vous que le service Nginx est bien démarré :
    ```
    service nginx start
    ```

6. Paramétrez votre compte Cozy et profitez !
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
