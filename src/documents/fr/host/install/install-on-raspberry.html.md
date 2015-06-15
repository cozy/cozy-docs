---
title: "sur un Raspberry Pi"
layout: "default"
category: "host"
menuOrder: 2
toc: false
---


<div style="height: 0; overflow: shown; text-align: right">
<img src="/assets/images/raspberry-logo.png">
</div>

# Installer Cozy sur un Raspberry Pi

**Vous aurez besoin du dernier [Raspberry Pi 2](http://fr.wikipedia.org/wiki/Raspberry_Pi) pour y faire tourner Cozy efficacement.**    
**L’utilisation d’une carte SD rapide (class10) est fortement recommandée.**

<br>

---

*Note pour les possesseurs de Raspberry Pi :* Cozy demande un peu trop de
ressources pour fonctionner correctement sur les précédents modèles B et B+
de Raspberry Pi. Pour ces modèles, une version alternative et plus légère de
Cozy existe : [Cozy Light](https://github.com/cozy-labs/cozy-light).

---

Le moyen le plus simple d’utiliser Cozy sur un Raspberry Pi 2 est de télécharger
notre image et de l’installer sur une carte SD. L’image est basée sur la
distribution [Raspbian](http://www.raspbian.org/).

Commencez par télécharger l’archive :

```bash
# Téléchargez l’image (environ 650MB)
wget http://files.cozycloud.cc/2015-02-19-cozy-raspberry-pi2.img.7z

# Décompressez-la
7zr e 2015-02-19-cozy-raspberry-pi2.img.7z
```

Recherchez ensuite où est montée votre carte SD. Supposons que ce soit sur
`/dev/sdc`. Faites alors une copie de l’image sur la carte :

**NB :** une carte SD Class 10 est recommandée pour avoir de meilleures
performances.

**ATTENTION :** cette opération va irrémédiablement supprimer toutes les
données présentes sur la carte.

```bash
sudo dd bs=4M if=2015-02-19-cozy-raspberry-pi2.img of=/dev/sdc
```

Insérez à présent la carte SD dans le lecteur de votre Raspberry Pi.
Redémarrez-le, et vous devriez pouvoir accéder à votre instance Cozy en vous
connectant au port 443 via le protocole https.

Pour trouvez l’adresse de votre Raspberry Pi, vous pouvez utiliser `nmap` sur
votre machine locale :

```
$ nmap -T4 -sP 192.168.x.0/24
```

Pour vous connecter à la carte, utilisez les accréditations par défaut
de Raspbian : ```pi``` and ```raspberry```:
```
$ ssh pi@<ip-of-your-raspberrypi>
```
