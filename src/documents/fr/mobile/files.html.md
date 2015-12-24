---
title: "Synchronisation de fichiers"
layout: "default"
category: "mobile"
menuOrder: 0
toc: true
urls: ["/mobile/"]
---
# Synchronisation de fichiers

## Installation et configuration

Pour accéder à vos fichiers depuis votre Cozy, vous devez tout d'abord installer l'application 'files' sur ce dernier.

Pré-requis : téléphone ou tablette Android (version >=4.1)

Vous pouvez soit télécharger l’APK et l’installer directement sur votre terminal, soit l’installer depuis le PlayStore de Google :

* téléchargez le [fichier APK](https://files.cozycloud.cc/android/CozyMobile_lastest.apk) (la dernière version de l’application est la v0.1.16, dont le sha1 est : fd328193b20431ec998071318c3bd38fe2c05043)
* ou allez sur le PlayStore et cherchez "Cozy Cloud" dans la barre de recherche. Puis sélectionnez et installez l'application.
* ou accedez aux [versions précédentes](https://files.cozycloud.cc/android/).

<a href="https://play.google.com/store/apps/details?id=io.cozy.files_client">
  <img alt="Get it on Google Play"
       src="https://developer.android.com/images/brand/fr_app_rgb_wo_45.png"
   />
</a>


![Play Store 01](/assets/images/mobile/playstore_01.png)
![Play Store 02](/assets/images/mobile/playstore_02.png)



Une fois installée, démarrez là. Quleques informations vous seront alors demandées :

* Le domaine où votre Cozy est situé ;
* Le mot de passe de votre Cozy (il ne sera pas stocké, juste utilisé pour enregistrer votre périphérique la première fois) ;
* Le nom du périphérique (il apparaîtra dans l'interface de votre Cozy) ;
* Queques paramètres concernant la sauvegarde de vos photos.

![Installation step 01](/assets/images/mobile/install_01.png)
![Installation step 02](/assets/images/mobile/install_02.png)

![Installation step 03](/assets/images/mobile/install_03.png)

Une fois le processus terminé, vous devrez confirmer et attendre la fin de la première synchronisation de l'arborescence.

## Naviguez dans vos fichiers Cozy depuis votre téléphone

Maintenant que l'arborescence est téléchargée, vous pouvez naviguer dans vos fichiers depuis votre mobile. Si vous voulez afficher un fichier, cliquez dessus. Il sera alors téléchargé sur votre téléphone/tablette. De cette manière, vous pourrez toujours le consulter même si vous perdez votre connexion internet.

Voici quelques cas d'usage couverts par l'application mobile :

* transporter vos e-tickets à un événement sans les imprimer ;
* lire des livres au format numérique dans les transports ;
* écouter votre musique préférée depuis votre Cloud sur haut-parleur via le Bluetooth ;
* regarder des séries télé depuis votre Cloud en faisant la queue ;

 Un champ de recherche est aussi disponible. Très pratique quand vous devez retrouver rapidement un fichier.

![Screen browsing](/assets/images/mobile/screen_01.png)
![Screen browsing](/assets/images/mobile/screen_02.png)

![Screen browsing](/assets/images/mobile/screen_03.png)


## Sauvegardez vos photos, faites des albums et partagez-les
Par défaut, l'application mobile Cozy va sauvegarder toutes les images qu'elle trouve sur votre mobile dans votre Cozy. Ces images seront enregistrées dans un dossier "Appareil photo".

NB : Si vous voulez économiser de la bande passante, vous pouvez désactiver cette fonctionnalité depuis l'écran de configuration.

Une fois que la synchronisation est en place, vous pouvez construire des albums depuis l'application Cozy "Photos" à partir des fichiers stockés dans votre Cozy (et donc depuis votre mobile).

![Screen browsing](/assets/images/mobile/photos_01.png)

Vous pouvez alors partager cet album en un clic, en sélectionnant les contacts avec lesquels vous souhaitez le partager.

![Screen browsing](/assets/images/mobile/photos_02.png)

## Envoyer des informations de debug.
Lorsque vous rencontrez un soucis sur votre téléphone, vous pouvez nous envoyer le journal de votre application, afin que nous puissons comprendre et donc corriger au mieux votre problème.
Pour envoyer ces informations :

 * Accedez au menu de votre application en cliquant sur les trois lignes blanches en haut à droite

![Screen browsing](/assets/images/mobile/logs_fr_01.png)

 * Dans ce menu, sélectionnez 'Configuration'.
 * En bas de la section de configuration, vous trouverez un bouton 'Envoyer Journal'.
 * Cliquez sur ce bouton.

![Screen browsing](/assets/images/mobile/logs_fr_02.png)

 * L'application va vous ouvrir un mail à envoyer.
 * N'oubliez pas d'ajouter une description de votre problème. Il est très difficile de corriger un soucis sans cette description.

![Screen browsing](/assets/images/mobile/logs_fr_03.png)

 * Et enfin, envoyez le mails.

## A propos des certificats auto-signés
A propos des Cozy auto-hébergé : vous avez probablement un certificat SSL auto-signé.
L'application mobile Cozy ne le reconnaîtra pas avant qu'il soit validé sur votre mobile. Suivez les instructions
[suivantes (en)](http://davdroid.bitfire.at/faq/entry/importing-a-certificate) pour savoir comment faire.

## Je n'ai pas de périphérique Android
Faites-nous savoir sur le [forum](https://forum.cozy.io/) que que voudriez avoir l'application sur votre système !

## Ressources connectées
* [Page du Playstore](https://play.google.com/store/apps/details?id=io.cozy.files_client&hl=)
* [Discussion sur le forum (en)](https://forum.cozy.io/t/i-tried-cozy-mobile/188)
* [APK Android](https://files.cozycloud.cc/android/CozyMobile_lastest.apk) (la dernière version de l’application est la v0.1.16, dont le sha1 est : fd328193b20431ec998071318c3bd38fe2c05043)
