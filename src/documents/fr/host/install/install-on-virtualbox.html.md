---
title: "Installer Cozy sur VirtualBox"
layout: "default"
category: "host"
menuOrder: 7
toc: false
---


<div class="install-inner-logo">
<img alt="Logo de VirtualBox" src="/assets/images/virtualbox-logo.png">
</div>

# Installer Cozy sur VirtualBox

**L’utilisation de l'image VirtualBox n’est pas recommandée en production.**    
**Référez-vous à l’[installation par paquet Debian](install-on-debian.html) dans ce cas.**

<br>

---

<h3>1. Téléchargez les prérequis</h3>

* [Téléchargez](https://www.virtualbox.org/wiki/Downloads) et installez VirtualBox.
* [Téléchargez](https://files.cozycloud.cc/cozy/virtualbox-cozycloud-latest.zip) et dézippez l’image Cozy pour VirtualBox.

<h3>2. Importez et essayez</h3>

* Importez l’image Cozy dans VirtualBox
* Éditez la configuration de la machine
  * Dans l’onglet « Réseau », changez le mode d’accès de « NAT » à « Accès par pont »
  * Sélectionnez la carte réseau de votre machine physique dans « Nom »
* Démarrez la machine virtuelle
* Obtenez l’adresse IP de votre machine virtuelle
  * Connectez-vous à la console (identifiants `vagrant`/`vagrant`)
  * Tapez `ifconfig eth0`
  * L’adresse est disponible sur la ligne `inet`
* Vous devriez avoir accès à votre Cozy via votre navigateur web sur `https://<adresse-ip-machine-virtuelle>:2223/`

<h3>3. Informations complémentaires</h3>

* Pour accéder à un terminal sur votre machine virtuelle, utilisez comme identifiants `vagrant`/`vagrant`. (attention, le clavier de la machine virtuelle utilise probablement la disposition Qwerty)
* Vous trouverez l’IP de votre machine virtuelle en y tapant `ifconfig`.
* Connectez-vous en SSH à l'aide de cette commande :

```bash
ssh -p 2222 vagrant@localhost
```
