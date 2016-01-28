---
title: "sur VirtualBox"
layout: "default"
category: "host"
menuOrder: 4
toc: false
---


<div style="height: 0; overflow: shown; text-align: right">
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

Importez l’image Cozy dans VirtualBox et démarrez la machine virtuelle.
Vous devriez avoir accès à votre Cozy via vore navigateur web sur :

```bash
https://localhost:2223/
```

Si vous êtes sous Max OS X, vous devrez ouvrir certains ports manuellement.
Ouvrez le port 22 de votre machine virtuelle vers 127.0.0.1:2222, et le port 443 vers 127.0.0.1:2223.

<h3>3. Informations complémentaires</h3>

* Pour accéder à un terminal sur votre machine virtuelle, utilisez comme identifiants `root`/`password`.
* Vous trouverez l’IP de votre machine virtuelle en y tapant `ifconfig`.
* Connectez-vous en SSH à l'aide de cette commande :

```bash
ssh -p 2222 root@localhost
```
