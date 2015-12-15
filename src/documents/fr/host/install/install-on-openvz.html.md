---
title: "sur OpenVZ"
layout: "default"
category: "host"
menuOrder: 6
toc: false
---


<div style="height: 0; overflow: shown; text-align: right">
<img alt="Logo d’OpenVZ" src="/assets/images/openvz-logo.png">
</div>

# Installer Cozy sur OpenVZ

**Le conteneur OpenVZ n’est pas forcément à jour.**    
**N’oubliez pas de le mettre à jour manuellement une fois lancé.**

<br>

---

Nous prenons en compte que tous les outils OpenVZ sont déjà installés.

---

### Téléchargement et installation

```bash
# Téléchargez le conteneur OpenVZ (environ 470Mo)
wget https://files.cozycloud.cc/vzdump-openvz-cozycloud-debian.tar.xz

# Décompressez le conteneur pour obtenir un .tar
xz -d vzdump-openvz-cozycloud-debian.tar.xz

# Montez et démarrez le conteneur
vzrestore vzdump-openvz-cozycloud-debian.tar ctid
vzctl start ctid
```
NB : remplacez `ctid` par un identifiant de conteneur libre (101, 102, etc).

*Le mot de passe du compte `root` est `password`.*


### Avec un réseau configuré

Vous voudrez probablement permettre la connexion au conteneur depuis d’autres
machines. Voici comment faire :

```bash
# Téléchargez le conteneur OpenVZ (environ 470Mo)
wget https://files.cozycloud.cc/vzdump-openvz-cozycloud-debian.tar.xz

# Décompressez le conteneur pour obtenir un .tar
xz -d vzdump-openvz-cozycloud-debian.tar.xz

# Montez et démarrez le conteneur
vzrestore vzdump-openvz-cozycloud-debian.tar ctid
vzctl set ctid --ipadd 10.0.0.10  --save
vzctl start ctid

# Mettez en place un proxy inverse qui redirige les requêtes du port 8888
# vers https://10.0.0.10:443 (par exemple avec Nginx)
# ...
# Puis autorisez le routage :
/sbin/iptables -t nat -A PREROUTING -i vmbr0 -p tcp --dport 8888 -j DNAT --to 10.0.0.10:443
```

Vous pouvez naturellement remplacer 8888 par le port que vous souhaitez exposer
à l’extérieur.
