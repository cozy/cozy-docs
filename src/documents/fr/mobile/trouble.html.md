---
title: "En cas de problème"
layout: "default"
category: "mobile"
menuOrder: 4
toc: true
---

# En cas de problème

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
A propos des Cozy auto-hébergé : vous avez probablement un certificat SSL auto-signé. Celui-ci doit être ajouté à votre terminal Android pour être reconnu par l'application mobile Cozy. Pour ce faire :

1. Installez sur votre terminal Android l'application [CADroid](https://cadroid.bitfire.at/), qui va vous assister dans cette tâche (sur le [PlayStore](https://play.google.com/store/apps/details?id=at.bitfire.cadroid) ou sur [FDroid](https://f-droid.org/repository/browse/?fdfilter=cadroid&fdid=at.bitfire.cadroid))
2. Lancez l'application CADroid, puis toucher **Next** (dans le coin en haut à droite).
3. Entrez l'url de votre Cozy, puis touchez **Fetch**.
4. Sélectionez votre certificat, vérifiez ses informations et que CADroid ne vous notifie pas d'erreurs, puis touchez **Next**.
5. CADroid vient d'exporter votre certificat à la racine de la carte SD de votre terminal. Pensez-à noter le nom du fichier ! Le certificat a été converti dans le format attendu par Android. Vous pouvez toucher Next pour visualiser quelques explication de la part de CADroid.
6. Ensuite, toujours sur votre terminal Android, rendez-vous dans Paramètres/Sécurité/**Installer depuis la carte SD** (dans la section _Stockage des identifiants_).
7. Parcourez l'arborescence pour retrouver le certificat exporté à l'étape 5, et sélectionnez-le.
8. Android vous demande alors de donner un nom au certificat (sans importance), et de choisir son usage. Il faut choisir _VPN et Application_ dans notre cas. De plus Android peut éventuellement vous demander d'augmenter le niveau de sécurité d'accès à votre terminal (ajouter un schéma de débloquage, ...).

Votre certificat sera désormais accepté par les applications de votre terminal Android !

Informations complémentaires :
* Android demande d'augmenter le niveau de sécurité d'accès au terminal. Cela semble incongrue, mais apparemment, Android immagine que ces certificats contiennent des clés privé qu'il faudrait protéger.
* Sur Android 4.4 et supérieurs, suite à l'ajout du certificat, une notification _Il est possible que le réseau soit surveillé. Par un tier inconnu_ apparait au démarrage du terminal. C'est un [bug d'Android](https://code.google.com/p/android/issues/detail?id=62076).

_Remerciements à l'équpe DavDroid pour l'application CADroid, et beaucoup d'inspiration pour cette documentation !_

## Je n'ai pas de périphérique Android
Faites-nous savoir sur le [forum](https://forum.cozy.io/) que vous voudriez avoir l'application sur votre système !

## Ressources connectées
* [Page du Playstore](https://play.google.com/store/apps/details?id=io.cozy.files_client&hl=)
* [Discussion sur le forum (en)](https://forum.cozy.io/t/i-tried-cozy-mobile/188)
* [APK Android](https://files.cozycloud.cc/android/CozyMobile_lastest.apk) (la dernière version de l’application est la v1.4.0, dont le sha1 est : b0caf993e8ba7897fcde05b7baa91d3ccbb07bfb)

