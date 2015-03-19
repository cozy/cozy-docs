---
title: "Installation"
layout: "default"
category: "host"
menuOrder: 0
toc: true
urls: ["/host/"]
---

# Installer Cozy

## Informations générales
### Prérequis matériels

Cozy ne nécessite pas de processeur puissant et peut même fonctionner sur un Raspberry Pi.

#### Configuration minimale

* RAM : 1024MB (permet d’avoir six applications actives simultanément).
* Espace disque : 2GB.

#### Configuration recommandée

* RAM : 2048MB (permet d’avoir seize applications actives simultanément).
* Espace disque : beaucoup, pour stocker tous vos fichiers.

### Considérations sur la sécurité avec les images pré-installées

Pour utiliser une image pré-installée dans un contexte de production, vous *devez* :
 - renouveler le certificat SSL ;
 - modifier le mot de passe de connexion à la base de données ;
 - réinitialiser le jeton d’authentification utilisé par le contrôleur.

Pour réinitialiser ce jeton, vous pouvez utiliser la commande suivante :

```bash
wget https://raw.githubusercontent.com/cozy/cozy-setup/master/fabfile.py
fab -H user@ip reset_security_tokens
```
Pour utiliser cette commande, vous devez avoir Fabric d'installé sur votre machine locale.

Vous devriez également modifier les accréditations du super utilisateur (et utiliser une clé SSH de préférence à un mot de passe pour vous connecter à la machine hébergeant votre Cozy, comme expliqué dans [ce tutoriel](http://www.debian-administration.org/article/SSH_with_authentication_key_instead_of_password) (en anglais)).


## Installation manuelle

### Utilisation de notre script

Sur votre machine locale, installez Fabric et les fabtools. Par exemple, sur Debian :

```bash
apt-get install python python-pip python-dev software-properties-common
sudo pip install fabric fabtools
```

Puis téléchargez notre fichier Fabric (c’est un script qui va exécuter des commandes sur votre serveur distant) :

```bash
wget https://raw.githubusercontent.com/cozy/cozy-setup/master/fabfile.py
```

Une fois que votre système est prêt, utilisez le script Fabric depuis votre
machine locale pour lancer l’installation sur le serveur (lancez le script
depuis le dossier dans lequel vous avez téléchargé le fichier `fabfile.py`) :

```bash
fab -H sudoer@ip install
```

où `sudoer` est un utilisateur autorisé à utiliser sudo, et `ip` l’adresse de votre serveur.

Répondez ensuite aux questions posées par l’installateur (par exemple le nom de domaine de votre instance).

Soyez patients, certaines commandes ou le déploiement des applications
peuvent demander un peu de temps, en fonction de votre bande passante et
de la puissance de votre serveur.

#### Installer Cozy en local

Pour installer Cozy sur votre machine locale, nous vous recommandons de créer
une machine virtuelle et d’exécuter le script Fabric en ciblant cette machine.
Cela vous permettra d’expérimenter Cozy sans installer ses nombreuses dépendances
dans votre environnement principal.

Si vous souhaitez vraiment l’installer directement sur votre machine, utilisez
cette commande :

```bash
fab -H sudoer@localhost install
```

#### Installer Cozy avec Apache

Pour utiliser le serveur web Apache plutôt que celui installé avec Cozy, il est nécessaire de modifier le fichier `fabfile.py` pour commenter l'installation de nginx (insérer un # devant l'appel de `install_nginx()` dans la fonction `install()`), avant de lancer la commande `fab -H …`.

Ensuite, il faudra définir un fichier vhost `cozy.conf` contenant ceci :

```
    # /etc/apache2/sites-available/cozy.conf
    <IfModule mod_ssl.c>
     <VirtualHost *:443>
            ServerName      mydomain.net
            ServerAdmin     admin@mydomain.net

            # On active le chiffrement (HTTPS)
            SSLEngine               On
            SSLCertificateFile      /etc/cozy/server.crt
            SSLCertificateKeyFile   /etc/cozy/server.key

            # Redirection des requêtes vers l'application Cozy Cloud
            ProxyPass               / http://127.0.0.1:9104/ retry=0 Keepalive=On timeout=1600
            ProxyPassReverse        / http://127.0.0.1:9104/
            setenv proxy-initial-not-pooled 1

            CustomLog               /var/log/apache2/cozy-access.log "%t %h %{SSL_PROTOCOL}x %{SSL_CIPHER}x \"%r\" %b"
            ErrorLog                /var/log/apache2/cozy-error.log

     </VirtualHost>
    </IfModule>
```

Assurez-vous enfin que les modules `proxy` et `proxy_http` d’Apache sont installés et activés :

```bash
a2enmod proxy
a2enmod proxy_http
service apache2 restart
```


#### Essayer Cozy avec Vagrant

Vous pouvez également utiliser [Vagrant](https://www.vagrantup.com/) pour installer
une instance de Cozy dans une machine virtuelle. Pour cela, nous vous recommandons
d’utiliser l’[image Ubuntu 12.04](http://files.vagrantup.com/precise64.box).
Soyez attentifs car la mise à jour nécessite de configurer votre séquence de
démarrage. Sélectionnez le premier système de fichiers proposé et cliquez sur OK.


### Tester l’installation

Une fois l’installation achevée, vous pouvez accéder à votre instance en
vous connectant avec un navigateur à https://IP:443 où vous pourrez créer votre compte.
Si au lieu de la page d’accueil de Cozy vous voyez la page par défaut de nginx,
assurez-vous que vous utilisez bien le protocole HTTPS.


### Qu’est-ce que le script va installer sur votre serveur ?

Le script d’installation de Cozy installe les outils suivants :

* Python ;
* Node.js ;
* le serveur web nginx ;
* la base de données CouchDB ;
* des outils Node.js : coffee-script, compound, brunch…
* Cozy Controller, le serveur principal ;
* Cozy Monitor, un outil en ligne de commande pour administrer l’instance ;
* Cozy Data indexer ;
* Cozy Data layer ;
* Cozy Proxy ;
* Cozy Home (l’application Web).

Pour mieux comprendre comment fonctionne une instance Cozy, vous pouvez
consulter la [description de l’architecture (en)](/en/hack/getting-started/architecture-overview.html).

### Machines virtuelles et conteneurs

Du fait du grand nombre de technologies mises en œuvre, nous recommandons
de faire tourner les instances Cozy dans un environnement isolé, une machine
virtuelle ou un conteneur (OpenVz ou LXC).


## Utiliser l’image pour Raspberry Pi 2

**Pour utiliser Cozy dans de bonnes conditions, vous aurez besoin du
[Raspberry Pi 2](http://en.wikipedia.org/wiki/Raspberry_Pi)**

*Note pour les possesseurs de Raspberry Pi :* Cozy demande un peu trop de
ressources pour fonctionner correctement sur les précédents modèles B et B+
de Raspberry Pi. Pour ces modèles, une version alternative et plus légère de
Cozy existe : [Cozy Light](https://github.com/cozy-labs/cozy-light).

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

Et n’oubliez pas de changer le mot de passe par défaut et le [jeton
d’authentification](#about-security-in-pre-installed-images) !


## Image pour Cubietruck

*Attention, pour un usage en production, n’oubliez pas de modifier le mot de
passe du super-utilisateur et de la base de données, installer un nouveau
certificat SSL et renouveller le [jeton
d’authentification](#about-security-in-pre-installed-images) !*

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

Et n’oubliez pas de changer le mot de passe par défaut et le [jeton
d’authentification](#about-security-in-pre-installed-images) !



## Image pour Virtualbox

*Attention, pour un usage en production, n’oubliez pas de modifier le mot de
passe du super-utilisateur et de la base de données, installer un nouveau
certificat SSL et renouveller le [jeton
d’authentification](#about-security-in-pre-installed-images) !*

### Prérequis

* [Téléchargez](https://www.virtualbox.org/wiki/Downloads) et installez
VirtualBox ;
* [Téléchargez](http://files.cozycloud.cc/cozycloud-virtualimage.zip) l’image
de machine virtuelle Cozy pour VirtualBox.

### Installation

Importez l’image dans Virtualbox et démarrez-la. Vous devriez pouvoir vous
connecter à votre instance en dirigeant un navigateur vers ```https://localhost:2223/```

Si vous êtes sous OS X, vous devez ajouter la redirection des ports :
le port 22 de votre machine virtuelle doit être redirigé vers le 127.0.0.1:2222
 et le port 443 vers le 127.0.0.1:2223.

### Informations complémentaires

Vous pouvez trouver l’adresse de la machine virtuelle au moyen de la
commande `ifconfig`.

Vous pouvez vous y connecter en ssh, le mot de passe du compte `root` est
`password` :

```bash
ssh -p 2222 root@localhost
```

## Image OpenVZ

Nous assumerons que vous avez déjà installé OpenVZ et ses utilitaires.

### Téléchargement et installation

```bash
# Téléchargez le conteneur OpenVZ (environ 1.3GB)
wget http://files.cozycloud.cc/vzdump-openvz-cozycloud-debian.tar

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
# Téléchargez le conteneur OpenVZ (environ 1.3GB)
wget http://files.cozycloud.cc/vzdump-openvz-cozycloud-debian.tar

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


## Image LXC

Utilisez l’interface Web de configuration de LXC pour ajouter et configurer des
conteneurs. Elle est très simple à utiliser. Pour Ubuntu, elle peut être
installée ainsi :

```bash
sudo apt-get install -y lxc debootstrap bridge-utils
sudo su
wget http://lxc-webpanel.github.com/tools/install.sh -O - | bash
exit
```

Accédez à l’interface en vous connectant sur http://myhost.com:5000, les
accréditations par défaut sont `admin/admin` (n’oubliez pas de les modifier).
Créez un conteneur, et paramétrez-le pour qu’il se lance au démarrage.
Accédez ensuite au conteneur via la ligne de commande :

```bash
lxc console <nom du conteneur>
```

Suivez les installations d’instruction de Cozy ci-dessus (installer Fabric,
télécharger la recette). Une fois l’installation terminée, votre Cozy sera
accessible sur le port 9104 du conteneur. Pour connaitre l’adresse de celui-ci,
vous pouvez taper :

```bash
/sbin/ifconfig $1 | grep "inet addr" | awk -F: '{print $2}' | awk '{print $1}'
```

Vous pouvez à présent sortir du conteneur. N’oubliez pas de désactiver
l’interface d’administration de LXC une fois que vous n’en avez plus besoin,
pour augmenter votre sécurité.

```bash
sudo service lwp stop
sudo update-rc.d -f lwp remove
```

Enfin, configurez sur le serveur hôte un proxy inverse pour le conteneur
hébergeant votre instance Cozy. Pour Nginx, vous pouvez utiliser cette
configuration :

```bash
server {
    listen 80;

    server_name cloud.myhost.com;

    access_log  /var/log/nginx/cozy_access.log;
    error_log  /var/log/nginx/cozy_error.log;
    root   /usr/share/nginx/html;
    index  index.html index.htm;

        location / {
                proxy_set_header X-Real-IP $remote_addr;
                proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
                proxy_set_header Host $http_host;
                proxy_set_header X-NginX-Proxy true;
                proxy_pass http://<container IP>:9104;
                proxy_redirect http://<container IP>:9104 https://$server_name/;
        }
}
```

Une fois Nginx redémarré, votre instance devrait être accessible sur `http://cloud.myhost.com`.


## Docker image


* Vous aures besoin d'une version 1.0.1 de [Docker](https://www.docker.com/)
ou supérieur.*

Vous pouvez essayer Cozy très simplement en téléchargeant l'image officielle
depuis Docker Hub :

```
sudo docker pull cozy/full
```

Si vous souhaitez l'utiliser dans un environnement de production, il est
recommandé de construite l'image sur votre machine :

```
sudo docker build -t cozy/full github.com/cozy-labs/cozy-docker
```

Vous pouvez ensuite lancer l'image avec la commande :

```
sudo docker run -d -p 80:80 -p 443:443 cozy/full
```

Il vous est possible de changer les ports affectés l'image, par exemple si
les ports 80 et 443 sont déjà utilisé :
```
sudo docker run -d -p 6500:443 cozy/full
```

Vous pouvez ensuite accéder à votre Cozy en vous rendant sur
https://localhost:443 (ou https://localhost:6500 pour le deuxième exemple)


## Héberger une instance de Cozy chez un prestataire

### CozyCloud

[Cozycloud](https://cozycloud.cc) est la société qui développe le projet Cozy.
Nous pouvons vous fournir gratuitement, en échange de retours, une instance.
Envoyez-nous simplement un message [via le formulaire d'inscription](/fr/#instance-request).

### Serveurs virtuels

Louer un serveur personnel virtuel (VPS) et y lancer le script d’installation
est une bonne option. Nous avons validé le fonctionnement de Cozy chez ces
deux hébergeurs :

* [OVH](http://www.ovh.com/fr/vps/vps-classic.xml), nous recommandons le VPS
  Classic 2.
* [Digital Ocean](https://www.digitalocean.com/pricing/). L’offre à 10$ est
  la configuration minimale, nous recommandons plutôt celle à 20$.

