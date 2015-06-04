---
title: "Synchronisation de contacts"
layout: "default"
category: "mobile"
menuOrder: 1
toc: true
---
# Synchronisation de contacts

## Préparer votre Cozy
Cozy utilise CardDav, qui est le protocole standard, pour synchroniser vos contacts sur tous vos périphériques. Tout est géré dans une application spécifique, Sync.

* Premièrement, allez dans votre Cozy dans le menu "Choisissez vos apps".
* Puis sélectionnez l'application "Sync".
* Acceptez les permissions de l'application et attendez la fin de l'installation.

<center>![Sync's installation intructions](/assets/images/mobile/install_sync_steps.gif)</center>

<br />
<br />
* Après ça, vous devez récupérer vos identifiants CardDav.
* Ouvrez l'application Sync.
* Notez le mot de passe.

<center>![Get CardDav credentials intructions](/assets/images/mobile/use_sync_steps.gif)</center>

<br />
<br />
Vous êtes maintenant prêt à synchroniser vos périphériques !

Consultez la section correspondant au système de votre périphérique pour continuer.

## Android

#### Installation
Il y a de nombreuses applications qui permettent de synchroniser les contacts sur Android, mais nous conseillons d'utiliser [DavDroid](http://davdroid.bitfire.at/) car c'est une application open-source, et ce même si l'application est payante sur le PlayStore.

Note : vous pouvez télécharger l'application gratuitement et l'installer depuis [F-droid store](https://f-droid.org/repository/browse/?fdid=at.bitfire.davdroid).

#### Configuration
Une fois l'application installée, ouvrez-là et cliquez sur le bouton pour créer un nouveau compte (suivez le cercle bleu dans l'image ci-dessous).
<center>![Android step 1](/assets/images/mobile/android/step1.png)</center>

<br />
<br />
Puis, sélectionnez "DavDroid".
<center>![Android step 2](/assets/images/mobile/android/step2.png)</center>

<br />
<br />
Vous aurez deux choix. Choisissez "Connexion avec URL et identifiants".
<center>![Android step 3](/assets/images/mobile/android/step3.png)</center>

<br />
<br />
Remplissez le formulaire avec les identifiants que vous avez noté lors de l'étape 1.
<center>![Android step 4](/assets/images/mobile/android/step4.png)</center>

<br />
<br />
Sélectionnez le carnet d'adresses disponible. Si vous voulez synchroniser vos agendas, sélectionnez les aussi.
<center>![Android step 5](/assets/images/mobile/android/step5.png)</center>

<br />
<br />
Choisissez un nom pour votre compte, "Cozy" fera très bien l'affaire.
<center>![Android step 6](/assets/images/mobile/android/step6.png)</center>

<br />
<br />
Vous avez terminé, mais si vous voulez forcer la première synchronisation, allez dans la liste des comptes.
<center>![Android step 7](/assets/images/mobile/android/step7.png)</center>

<br />
<br />
Sélectionnez le compte DavDroid dans la liste.
<center>![Android step 8](/assets/images/mobile/android/step8.png)</center>

<br />
<br />
Touchez le bouton "Contacts", ce qui aura pour effet de démarrer une synchronisation.
<center>![Android step 9](/assets/images/mobile/android/step9.png)</center>

<br />
<br />
Félicitations, votre périphérique mobile est maintenant synchronisé avec votre Cozy !

## iOS

#### Configurez votre compte CardDav
Ouvrez les options, sélectionnez "Email, Contacts, Agendas" et cliquez sur "Ajouter un compte" :
<center>![iOS step 1](/assets/images/mobile/ios/contacts/step1.jpg)</center>

<br />
<br />
Puis sélectionnez "Autre compte" :
<center>![iOS step 2](/assets/images/mobile/ios/contacts/step2.jpg)</center>

<br />
<br />
Sélectionnez ensuite "Ajouter un compte CardDav" dans la section Contacts :
<center>![iOS step 3](/assets/images/mobile/ios/contacts/step3.jpg)</center>

<br />
<br />
Enfin, remplissez le formulaire avec les identifiants que vous avez notés lors de l'étape 1 :

* le champ "Serveur" va changer pour chaque utilisateur : adresse-de-votre-cozy/public/sync
* le champ "Nom d'utilisateur" sera toujours "me".
* le champ "Mot de passe" sera celui que vous avez noté.
* le champ "Description" permet de choisir un nom pour identifier ce compte. "Cozy" fera très bien l'affaire.

<center>![iOS step 4](/assets/images/mobile/ios/contacts/step4.jpg)</center>

<br />
<br />
Félicitations, votre périphérique mobile est maintenant synchronisé avec votre Cozy !
<center>![iOS step 5](/assets/images/mobile/ios/contacts/step5.jpg)</center>

## OSX

#### Configurez votre compte CardDav
Dans le logiciel Contacts, cliquez sur "Contacts", puis "Ajouter un compte" :
<center>![OSX step 1](/assets/images/mobile/osx/contacts/step1.jpg)</center>

<br />
<br />
Puis sélectionnez "Autre compte contacts" :
<center>![OSX step 2](/assets/images/mobile/osx/contacts/step2.jpg)</center>

<br />
<br />
Assurez vous que la liste déroulante soit bien sur "CardDav".
Enfin, remplissez le formulaire avec les identifiants que vous avez notés lors de l'étape 1 :

* le champ "Serveur" va changer pour chaque utilisateur : adresse-de-votre-cozy/public/sync
* le champ "Nom d'utilisateur" sera toujours "me".
* le champ "Mot de passe" sera celui que vous avez noté.
* le champ "Description" permet de choisir un nom pour identifier ce compte. "Cozy" fera très bien l'affaire.

<center>![OSX step 3](/assets/images/mobile/osx/contacts/step3.jpg)</center>

<br />
<br />
Félicitations, votre ordinateur est maintenant synchronisé avec votre Cozy !
<center>![OSX step 4](/assets/images/mobile/osx/contacts/step4.jpg)</center>

## Firefox OS

Firefox OS ne supporte pas encore la synchronisation de contacts (dans sa version 2.1) :(
Nous mettrons à disposition un guide dès que ce sera possible !

## Ressources connectées
* [Discussion sur le forum](https://forum.cozy.io/)
