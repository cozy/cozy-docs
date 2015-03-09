---
title: "Calendar synchronization"
layout: "default"
category: "mobile"
menuOrder: 1
toc: true
---
# Calendar Synchronization

## Prepare your Cozy
Cozy uses CalDav, which is the standard, to synchronize your calendars across devices. Everything is handled in a specific applications, Sync.

* First, go to your Cozy, under the "Choose your apps" menu.
* Then select the "Sync" application.
* Accept the application's permission, to process the installation.

<center>![Sync's installation intructions](/assets/images/mobile/install_sync_steps.gif)</center>

<br />
<br />
* Next, you need to get your CalDav credentials.
* Open the Sync application.
* Write down your password.

<center>![Get CalDav credentials intructions](/assets/images/mobile/use_sync_steps.gif)</center>

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
Select the calendars you want to synchronize. If you want to synchronize your contacts too, select the available address book too.
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
Touch the "Calendar" button and it'll trigger a synchronization.
<center>![Android step 9](/assets/images/mobile/android/step9.png)</center>

<br />
<br />
Congratulations, your mobile device is now synchronized with your Cozy!

## iOS

#### Configure your CalDav account
Open the Settings, select the "Mail, Contacts, Calendars" view, and click on "Add Account":
<center>![iOS step 1](/assets/images/mobile/ios/calendar/step1.jpg)</center>

<br />
<br />
Then select "Other" account:
<center>![iOS step 2](/assets/images/mobile/ios/calendar/step2.jpg)</center>

<br />
<br />
Then select "Add CalDav Account", in the Calendars section:
<center>![iOS step 3](/assets/images/mobile/ios/calendar/step3.jpg)</center>

<br />
<br />
Finally, fill the form with the credentials you got from Cozy's Sync app:

* the "Server" input will vary vor each user: yourcozyaddress/public/sync/principals/me
* the "Username input will always be "me",
* the "Password" input will be the password you got earlier from Cozy,
* the "Description" input stands for the user-friendly name of your choice, "Cozy" is just fine.

<center>![iOS step 4](/assets/images/mobile/ios/calendar/step4.jpg)</center>

<br />
<br />
And then click next. Activate or not reminders, and click save:
<center>![iOS step 5](/assets/images/mobile/ios/calendar/step5.jpg)</center>

<br />
<br />
Congratulations, your mobile device is now synchronized with your Cozy!
You can now configure the mobile Calendars application to choose which calendar you want to display.

#### Configure your calendars

Open the Calendar app.

You can already visualize the calendars of your Cozy.
Click on calendars to toggle calendar's visibility.
<center>![iOS step 6](/assets/images/mobile/ios/calendar/step6.jpg)</center>

<br />
<br />
Open the menu and click the button to add a new calendar.
<center>![iOS step 7](/assets/images/mobile/ios/calendar/step7.jpg)</center>

<br />
That's it! You can seamlessly manage your events from your mobile and your Cozy.

## Firefox OS

#### Install
There is nothing to install to get started with Firefox OS! Just open the "Calendar" application.

#### Configure
Open the menu and click the button to add a new calendar.
<center>![Firefox OS step 1](/assets/images/mobile/firefoxos/step1.png)</center>

<br />
<br />
Then choose "CalDav" option in the menu.
<center>![Firefox OS step 2](/assets/images/mobile/firefoxos/step2.png)</center>

<br />
<br />
Finally, fill the form with the credentials you got from Cozy's Sync app:

* the first input will always be "me".
* the second will be the password you got earlier from Cozy.
* the third will vary for each user: https://yourcozyaddress/public/sync/principals/me

<center>![Firefox OS step 3](/assets/images/mobile/firefoxos/step3.png)</center>

<br />
<br />
That's it! Your calendars will now be synchronized on a regular basis (default is 15 minutes). You can select calendars you want to synchronize directly from the menu.
<center>![Firefox OS step 4](/assets/images/mobile/firefoxos/step4.png)</center>

<br />
<br />
Congratulations, your mobile device is now synchronized with your Cozy!

## Related resources
* [Forum discussion](https://forum.cozy.io/)

