---
title: "Desktop"
layout: "default"
category: "mobile"
menuOrder: 1
toc: true
---

# Synchronisation desktop

Le client Cozy-desktop vous permet de synchroniser vos fichiers et vos dossiers entre votre Cozy et votre ordinateur. Vous pouvez ainsi travailler sur vos fichiers hors ligne. Les modifications seront alors synchronisées dès que vous retrouverez du réseau.

## Installation

Avant de commencer l'installation de Cozy-desktop, nous vous conseillons de mettre à jour votre Cozy.


### Linux

Pour Debian et Ubuntu, vous pouvez installer cozy-desktop via notre dépôt :

```bash
sudo apt-get install ca-certificates apt-transport-https

wget -O - https://cozy-desktop.cozycloud.cc/debian/cozy-desktop.gpg.key 2>/dev/null | sudo apt-key add -

echo 'deb [arch=amd64] https://cozy-desktop.cozycloud.cc/debian jessie cozy-desktop' | sudo tee /etc/apt/sources.list.d/cozy.list

sudo apt-get update
sudo apt-get install cozy-desktop-gui
```

Si vous êtes sous Arch, un de nos contributeurs maintient https://aur.archlinux.org/packages/cozy-desktop-gui/.

### OSX

A venir ... :)

### Windows

A venir ... :)


## Configuration

Une fois votre client installé, demarrez le. Quelques informations vous seront alors demandées :

* Tout d'abord l'url de votre Cozy. C'est-à-dire l'adresse web avec laquelle vous accéder à votre Cozy.
* Puis, le mot de passe de votre Cozy. Nous n'enregistrons pas le mot de passe en local, il ne sert que le temps de créer des identifiants à votre nouveau client pour qu'il puisse se connecter par la suite à votre Cozy et ainsi synchroniser vos fichiers.
* Enfin, l'application va vous demander de sélectionner le dossier dans lequel vous voulez synchroniser les fichiers de votre Cozy.

![Onboarding](/assets/images/desktop/fr_onboarding.png)


Une fois ces quatre écrans passés, l'application va vous rediriger vers le tableau de bord et la première synchronisation peut démarrer. Le tableau de bord est composé : 

* D'un panneau d'information sur les synchronisations en cours et l'espace disque disponible de votre Cozy.
* D'une section de préférences vous permettant de démarrer votre client au démarrage de votre ordinateur et vous indiquant la version de votre client.
* D'une page de compte vous informant du Cozy auquel est lié votre client et la possibilité de délier votre Cozy.
* D'une page d'aide en cas de soucis avec votre client.

![Dashboard](/assets/images/desktop/fr_dashboard.png)


## FAQ

Si vous rencontrez une erreur qui ressemble à :


    [Error: Error: /tmp/.org.chromium.Chromium.ox2yyn: failed to map segment from shared object: Operation not permitted: unable to import leveldown]

Cela signifie que le client Cozy-desktop ne peut pas démarrer correctement à cause du dossier temporaire qui est monté avec l'option noexec. Cela empêche le chargement dynamique de librairie comme leveldown dans notre cas. 

Pour résoudre ce soucis, la solution est d'utiliser un autre dossier temporaire :

```bash
export TMPDIR="$HOME/tmp"
mkdir -p $TMPDIR
cozy-desktop
```


## En cas de soucis

Si vous rencontrez un soucis avec le client de synchronisation Cozy-desktop, vous pouvez nous le signaler et nous envoyer le journal de logs depuis l'interface.

Ouvrez l'interface d'aide de votre client, puis cliquer sur ***Send us a message*** dans la partie ***Official support***.

![Trouble](/assets/images/desktop/fr_trouble.png)


N'oubliez pas de décrire votre soucis dans le contenu du mail, cela nous aide pour améliorer au mieux notre application.
