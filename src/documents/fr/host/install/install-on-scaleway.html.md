---
title: "Installer Cozy sur Scaleway"
layout: "default"
category: "host"
menuOrder: 2
toc: false
---


<div class="install-inner-logo">
<img alt="Scaleway logo" src="/assets/images/host/scaleway-logo.svg">
</div>

# Installer Cozy sur Scaleway

---

** <img src="/assets/images/warning.png" alt="warning" class="warn">Cette documentation concerne l’installation de l’ancien prototype de Cozy, aujourd’hui déprécié et dont nous n’assurons plus le support. La documentation d’installation de la nouvelle version sera disponible très bientôt.**

---


**Scaleway est un fournisseur de serveur privé.**

**Il vous permet de déployer Cozy en quelques minutes en utilisant que le
navigateur.**

**Pour suivre ces instructions vous avez besoin d'un compte configuré et
crédité.**

<br>

## 1. Connectez vous à votre compte et créez un serveur.

Inscrivez vous sur [https://scaleway.com](https://scaleway.com) puis connectez
vous à votre compte. Une fois connectés, cliquez sur *Create Server* pour
démarrer le processus de création du Cozy.

<div>
![step1](/assets/images/scaleway-capture-1.png)
</div>


<br>

## 2. Donnez un nom à votre nouveau serveur.

Entrez un nom pour votre serveur dans le champ dédié. Puis descendez jusqu'au
panneau de sélection d'image.

<div>
![step2](/assets/images/scaleway-capture-2.png)
</div>

<br>

## 3. Créez le serveur.

Sélectionnez l'image Cozy dans l'interface Image Hub. Puis cliquez sur le
bouton *Create Server* situé en bas.

<div>
![step3](/assets/images/scaleway-capture-3.png)
</div>

<br>

## 4. Attendez la génération de votre certificat Cozy puis connectez vous.

La génération de certificat SSL (pour HTTPS),est longue sur les hardware
Scaleway. Vous devrez attendre 20 minutes comme une heure avant de vous
connecter. Une fois connecté avec votre navigateur à l'adresse IP donée par
l'équipe Scaleway, vous devriez voir l'écran d'enregistrement du Cozy !


## 5. Activez l’envoi de courriels.

Par défaut, les serveurs Scaleway ne sont pas autorisés à envoyer des courriels. Pour permettre à votre Cozy d’envoyer des messages (par exemple si vous avez oublié votre mot de passe ou pour partager des contenus), vous devez aller dans l’interface d’administration de Scaleway et [débloquer l’envoi des courriels](https://www.scaleway.com/faq/server/network/#-I-cannot-send-any-email).

<div>
![step3](/assets/images/scaleway-capture-4.png)
</div>

