---
title: "Installer Cozy sur DigitalOcean"
layout: "default"
category: "host"
menuOrder: 3
toc: false
---


<div class="install-inner-logo">
<img alt="Logo de DigitalOcean" src="/assets/images/host/digitalocean-logo.svg">
</div>

# Installer Cozy sur un VPS DigitalOcean

---

** <img src="/assets/images/warning.png" alt="warning" class="warn">Cette documentation concerne l’installation de l’ancien prototype de Cozy, aujourd’hui déprécié et dont nous n’assurons plus le support. La documentation d’installation de la nouvelle version sera disponible très bientôt.**

---


**DigitalOcean est un hébergeur de serveurs privés virtuels (VPS) américain, qui vous**
**permet de déployer des serveurs en une minute.**
**Créez un compte DigitalOcean et créditez-le avant de continuer.**

<br>

## 1. Créez un « droplet »

Cozy requiert au moins 1 Go de RAM pour fonctionner correctement.

<div>
![step1](/assets/images/digitalocean-capture-1.jpg)
</div>

<br>

Sélectionnez `Debian 8 x64` dans la liste des distributions.

<div>
![step2](/assets/images/digitalocean-capture-2.jpg)
</div>


## 2. Connectez-vous via SSH

Une fois déployé, votre VPS aura une IP propre.

<div>
![step3](/assets/images/digitalocean-capture-3.jpg)
</div>

<br>

Connectez-vous à cette IP via SSH :
```
ssh root@ip.du.serveur
```


## 3. Installez le paquet Debian

```
# Importez la clé publique du dépôt Cozy
wget https://debian.cozycloud.cc/cozy.gpg.key -O /etc/apt/trusted.gpg.d/cozy.gpg

# Ajoutez le dépôt Cozy à vos sources de logiciel
echo 'deb https://debian.cozycloud.cc/debian jessie cozy' \
 > /etc/apt/sources.list.d/cozy.list

# Installez Cozy
apt-get update ;
apt-get install python-cozy-management ;
cozy_management install_cozy
```
