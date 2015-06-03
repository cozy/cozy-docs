---
title: "Contacts synchronization"
layout: "default"
category: "mobile"
menuOrder: 1
toc: true
---
# Contacts Synchronization

## Prepare your Cozy
Cozy uses CardDav, which is the standard, to synchronize your contacts across devices. Everything is handled in a specific applications, Sync.

* First, go to your Cozy, under the "Choose your apps" menu.
* Then select the "Sync" application.
* Accept the application's permission, to process the installation.

<center>![Sync's installation intructions](/assets/images/mobile/install_sync_steps.gif)</center>

<br />
<br />
* Next, you need to get your CardDav credentials.
* Open the Sync application.
* Write down your password.

<center>![Get CardDav credentials intructions](/assets/images/mobile/use_sync_steps.gif)</center>

<br />
<br />
You are now ready to synchronize your devices!

Check the section relevant to your device's system to continue.

## Android

#### Install
There are multiple applications that can achieve what we want, but we advise you to use [DavDroid](http://davdroid.bitfire.at/) because it's open-source, though it's a paid app on the PlayStore.

Note: you can download it and install for free from the [F-droid store](https://f-droid.org/repository/browse/?fdid=at.bitfire.davdroid).

#### Configure
Once it's installed, open the application and click on the button to create a new account (see the blue circle on the picture below).
<center>![Android step 1](/assets/images/mobile/android/step1.png)</center>

<br />
<br />
Next, select "DAVDroid".
<center>![Android step 2](/assets/images/mobile/android/step2.png)</center>

<br />
<br />
You will have two choice. Choose "Login with URL and user name".
<center>![Android step 3](/assets/images/mobile/android/step3.png)</center>

<br />
<br />
Fill the form with the credentials you got from the Cozy's Sync app.
<center>![Android step 4](/assets/images/mobile/android/step4.png)</center>

<br />
<br />
Select the available address book. If you want to synchronize your calendars, select them too.
<center>![Android step 5](/assets/images/mobile/android/step5.png)</center>

<br />
<br />
Choose a name for your account, you can choose anything, "Cozy" is just fine.
<center>![Android step 6](/assets/images/mobile/android/step6.png)</center>

<br />
<br />
You are actually done, but if you want to force the first synchronization, go to the accounts list.
<center>![Android step 7](/assets/images/mobile/android/step7.png)</center>

<br />
<br />
Then select your DAVDroid account in the list.
<center>![Android step 8](/assets/images/mobile/android/step8.png)</center>

<br />
<br />
Touch the "Contacts" button and it'll trigger a synchronization.
<center>![Android step 9](/assets/images/mobile/android/step9.png)</center>

<br />
<br />
Congratulations, your mobile device is now synchronized with your Cozy!

## iOS

#### Configure your CardDav account
Open the Settings, select the "Mail, Contacts, Calendars" view, and click on "Add Account":
<center>![iOS step 1](/assets/images/mobile/ios/contacts/step1.jpg)</center>

<br />
<br />
Then select "Other" account:
<center>![iOS step 2](/assets/images/mobile/ios/contacts/step2.jpg)</center>

<br />
<br />
Then select "Add CardDav Account", in the Contacts section:
<center>![iOS step 3](/assets/images/mobile/ios/contacts/step3.jpg)</center>

<br />
<br />
Finally, fill the form with the credentials you got from Cozy's Sync app:

* the "Server" input will vary vor each user: yourcozyaddress/public/sync
* the "Username input will always be "me".
* the "Password" input will be the password you got earlier from Cozy.
* the "Description" input stands for the user-friendly name of your choice, "Cozy" is just fine.

<center>![iOS step 4](/assets/images/mobile/ios/contacts/step4.jpg)</center>

<br />
<br />
Congratulations, your mobile device is now synchronized with your Cozy!
<center>![iOS step 5](/assets/images/mobile/ios/contacts/step5.jpg)</center>

## OSX

#### Configure your CardDav account
Once the software "Contacts" open, click on Contacts and "Ajouter un compte" :
<center>![OSX step 1](/assets/images/mobile/osx/contacts/step1.jpg)</center>

<br />
<br />
Then select "Add other Account" :
<center>![OSX step 2](/assets/images/mobile/osx/contacts/step2.jpg)</center>

<br />
<br />
Be sure that "CardDav" is selected in the list.
Finally, fill the form with the credentials you got from Cozy's Sync app:

* the "Server" input will vary vor each user: yourcozyaddress/public/sync
* the "Username input will always be "me".
* the "Password" input will be the password you got earlier from Cozy.
* the "Description" input stands for the user-friendly name of your choice, "Cozy" is just fine.

<center>![OSX step 3](/assets/images/mobile/osx/contacts/step3.jpg)</center>

<br />
<br />
Congratulations, your computer is now synchronized with your Cozy!
<center>![OSX step 4](/assets/images/mobile/osx/contacts/step4.jpg)</center>

## Firefox OS

Firefox OS doesn't have support to synchronize contacts as of today (version 2.1) :(
We will definitely add a guide when it is ready!

## Related resources
* [Forum discussion](https://forum.cozy.io/)
