---
title: "sur un CubieTruck"
layout: "default"
category: "host"
menuOrder: 3
toc: false
---


<div style="height: 0; overflow: shown; text-align: right">
<img alt="Logo de CubieBoard" src="/assets/images/cubieboard-logo.png">
</div>

# Installer Cozy sur un CubieTruck

**Le CubieTruck est le [3ème modèle](http://www.cubietruck.com/collections/frontpage/products/cubietruck-cubieboard3-cortex-a7-dual-core-2gb-ram-8gb-flash-with-wifi-bt-1) fabriqué par Cubieboad.**    
**L’utilisation d’une carte SD rapide (class10) est fortement recommandée.**

<br>

---

Le moyen le plus simple d’utiliser Cozy sur une carte Cubietruck est de
télécharger notre image, basée sur la distribution [Cubian](http://cubian.org),
et de l’installer sur une carte SD.

Commencez par télécharger l’image :

```bash
# Téléchargez l’image (environ 1.5GB)
wget http://files.cozycloud.cc/cozy-cubietruck.im.tar.gz

# Décompressez-la
tar -xvzf cozy-cubietruck.im.tar.gz
```

Recherchez ensuite où est montée votre carte SD. Supposons que ce soit sur
`/dev/sdc`. Faites alors une copie de l’image sur la carte :

**NB :** une carte SD Class 10 est recommandée pour avoir de meilleures
performances.

**ATTENTION :** cette opération va irrémédiablement supprimer toutes les
données présentes sur la carte.

```bash
sudo dd bs=4M if=/my/path/cozy-cubietruck.im of=/dev/sdc
```

Insérez à présent la carte SD dans le lecteur de votre Cubietruck.
Redémarrez-la, et vous devriez pouvoir accéder à votre instance Cozy en vous
connectant au port 443 via le protocole https.

Pour trouvez l’adresse de votre Cubietruck, vous pouvez utiliser `nmap` sur
votre machine locale :

```
$ nmap -T4 -sP 192.168.x.0/24
```

Pour vous connecter à la carte, utilisez les accréditations par défaut
de Raspbian : ```cubie``` and ```cubie```:
```
$ ssh -p 36000 cubie@<ip-of-your-cubieboard>
```
