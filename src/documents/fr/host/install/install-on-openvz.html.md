---
title: "Installer Cozy sur OpenVZ"
layout: "default"
category: "host"
menuOrder: 10
toc: false
---


<div class="install-inner-logo"> 
<img alt="Logo d’OpenVZ" src="/assets/images/openvz-logo.png">
</div>

# Installer Cozy sur OpenVZ

Nous prenons en compte que tous les outils OpenVZ sont déjà installés.

---

### Téléchargement
```bash
# Téléchargez le conteneur OpenVZ (environ 340Mo)
wget https://files.cozycloud.cc/openvz/openvz-cozycloud-latest.tar.gz
```

### Montez et démarrez le conteneur
```
vzrestore openvz-cozycloud-latest.tar.gz ctid
vzctl start ctid
```
*Il n'y a pas de mot de passe de définit. Il faut faire un `vzctl enter ctid` pour en définir un.
Ou mettre votre clé SSH.*

**NB** : remplacez `ctid` par un identifiant de conteneur libre (101, 102, etc).

### Avec un réseau configuré

Vous voudrez probablement permettre la connexion au conteneur depuis d’autres
machines. Voici comment faire :

```bash
# Montez et démarrez le conteneur
vzrestore openvz-cozycloud-latest.tar.gz ctid
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
