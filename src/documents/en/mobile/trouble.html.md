---
title: "Troubleshooting"
layout: "default"
category: "mobile"
menuOrder: 2
toc: true
---

# Troubleshooting

## Send debug informations

When you hit a problem with the application, you can send us a message with the application logs, so we can try to understand and fix the problem.
Here’s how to send the logs:


 * click on the icon on top left corner and select Configuration inside the menu

![Screen browsing](/assets/images/mobile/logs_fr_01.png)

 * Scroll to the bottom of the screen where you’ll find a button to send the logs. Click on it.

![Screen browsing](/assets/images/mobile/logs_fr_02.png)

 * The application will create an email message with the logs. Please also describe your problem by adding as much details as you can. This will help us understand what’s happening.

![Screen browsing](/assets/images/mobile/logs_fr_03.png)

 * Don’t forget to send the message!


## Note about self-signed certificates
About Self hosted instances, you probably have a self-signed certificate. You have to install it on your Android device, to allow Cozy Mobile to recognize it.

1. Install on your Android device the application [CADroid](https://cadroid.bitfire.at/), which will help you in this task (from the [PlayStore](https://play.google.com/store/apps/details?id=at.bitfire.cadroid) or [FDroid](https://f-droid.org/repository/browse/?fdfilter=cadroid&fdid=at.bitfire.cadroid).
2. Run the CADroid application, then touch **Next** (in the upper right corner).
3. Type your cozy URL, then touch **Fetch**.
4. Select your certificate, check it informations and that CADroid didn't find any issue with it, then touch **Next**.
5. CADroid has just exported your certificate in the root of the SD card of your device. Note the filename ! CADroid converted the certificat in the format expected by Android. Touch Next to get some informations from CADroid.
6. Then, still on your ANdroid device, go to Settings/Security/**Install from device storage** (in the _Credential storage_ section).
7. Browse to find your certificate, exported in step 5, and select it.
8. Android will then ask you a certificate name (doesn't matter), and to chose the use of your certificate. Select _VPN and Applications_. Android may also ask you to upgrade the access sécurity level of your device (adding a unlocking  schema, ...).

Now, your certificate will be accepted by any applications on your device !

Complements:
* Android ask to upgrade the access security level. It looks strange, but apparently Android thinks there's a client certificate with a private key that must be protected.
* On Android 4.4+ devices, there'll be an annoying hint _Network may be monitored_ on each device start. This an [Android bug](https://code.google.com/p/android/issues/detail?id=62076).

_Thanks to the DavDroid team, for CADroid and elements for this documentation !_

## I don't have an Android Phone
Let us know on the [forum](https://forum.cozy.io/) you would like to see the application for your system!

## Related resources
* [Playstore page](https://play.google.com/store/apps/details?id=io.cozy.files_client&hl=)
* [Forum discussion](https://forum.cozy.io/t/i-tried-cozy-mobile/188)
* [Android APK](https://files.cozycloud.cc/android/CozyMobile_lastest.apk) (latest version is v1.2.0, its sha1 is: ea13d53e1f94f1948463d08421337e22508d0b96)
