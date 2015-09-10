---
title: "sur Docker"
layout: "default"
category: "host"
menuOrder: 5
toc: false
---


<div style="height: 0; overflow: shown; text-align: right">
<img alt="Logo de Docker" src="/assets/images/docker-logo.png">
</div>

# Installer Cozy sur Docker

**Le support de Docker est encore expérimental, utilisez le conteneur avec précaution.**

<br>

---

*L’image nécessite une version 1.0.1 ou plus récente de [Docker](https://www.docker.com/).*

---

Vous pouvez essayer Cozy très simplement en téléchargeant l'image officielle
depuis Docker Hub :

```
sudo docker pull cozy/full
```

Si vous souhaitez l'utiliser dans un environnement de production, il est
recommandé de construire l'image sur votre machine :

```
sudo docker build -t cozy/full github.com/cozy-labs/cozy-docker
```

Vous pouvez ensuite lancer l'image avec la commande :

```
sudo docker run -d -p 80:80 -p 443:443 cozy/full
```

Il vous est possible de changer les ports affectés à l'image, par exemple si
les ports 80 et 443 sont déjà utilisés :
```
sudo docker run -d -p 6500:443 cozy/full
```

Vous pouvez ensuite accéder à votre Cozy en vous rendant sur
https://localhost:443 (ou https://localhost:6500 pour le deuxième exemple)
