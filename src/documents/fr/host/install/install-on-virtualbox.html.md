---
title: "Installer Cozy sur VirtualBox"
layout: "default"
category: "host"
menuOrder: 7
toc: false
---


<div class="install-inner-logo">
<img alt="Logo de VirtualBox" src="/assets/images/host/virtualbox-logo.svg">
</div>

# Installer Cozy sur VirtualBox

**L’utilisation de l'image VirtualBox n’est pas recommandée en production.**
**Référez-vous à l’[installation par paquet Debian](install-on-debian.html) dans ce cas.**

<br>

---

<h3>1. Téléchargez les prérequis</h3>

* [Téléchargez](https://www.virtualbox.org/wiki/Downloads) et installez VirtualBox.
* [Téléchargez](https://files.cozycloud.cc/cozy/cozy-virtualbox_latest.tar.xz) et décompressez là (`xz -d cozy-virtualbox_4.0.1.tar.xz` sur Linux, utilisez votre logiciel de décompression préféré sur Windows et MacOs).
* Téléchargez les signatures de l'image [ici](https://files.cozycloud.cc/cozy/cozy-virtualbox_latest.tar.xz.sha512.asc) et [ici](https://files.cozycloud.cc/cozy/cozy-virtualbox_latest.tar.xz.sha512)
* Vérifiez l'intégrité de l'image :

```
gpgv2 -v cozy-virtualbox-4.0.1.tar.xz.sha512.asc
sha512sum -c cozy-virtualbox-4.0.1.tar.xz.sha512
```

<h3>2. Importez et essayez</h3>

* Importez l’image Cozy dans VirtualBox
* Éditez la configuration de la machine
  * Dans l’onglet « Réseau », changez le mode d’accès de « NAT » à « Accès par pont »
  * Sélectionnez la carte réseau de votre machine physique dans « Nom »
* Démarrez la machine virtuelle
* Ouvrez votre navigateur et rendez vous sur `https://cozy.local`

Alternatively, you can reach your Cozy with the VM's IP address:

  * Connectez-vous à la console (identifiants `root`/`root`)
  * Tapez `hostname -I`
  * Vous devriez avoir accès à votre Cozy via votre navigateur web sur `https://<adresse-ip-machine-virtuelle>/`


<h3>3. Informations complémentaires</h3>

* Pour accéder à un terminal sur votre machine virtuelle, utilisez comme identifiants `root`/`root`. (Attention : le clavier de la machine virtuelle utilise probablement la disposition qwerty.)
* Vous pouvez vous connecter en SSH via `ssh root@cozy.local` ou `ssh root@<adresse-ip-machine-virtuelle>`.
