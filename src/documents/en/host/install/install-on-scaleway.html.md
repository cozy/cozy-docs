---
title: "Install Cozy on Scaleway"
layout: "default"
category: "host"
menuOrder: 2
toc: false
---


<div class="install-inner-logo">
<img alt="Scaleway logo" src="/assets/images/host/scaleway-logo.svg">
</div>

# Install Cozy on Scaleway

---

** <img src="/assets/images/warning.png" alt="warning" class="warn">This document with instructions explains how to install the old Cozy prototype, but is now out of date. Instructions on how to install the new Cozy will be available soon. Stay tuned!**

---


**Scaleway is a pre-configured Private Server provider.**

**They enable you to start with Cozy in a minute.**

**You need a credited account to follow the steps below.**

<br>

## 1. Connect to your account and create a server.

Subscribe to [https://scaleway.com](https://scaleway.com) then connect to your
account. Once connected, click on the *Create Server* button to start the
Cozy creation process.

<div>
![step1](/assets/images/scaleway-capture-1.png)
</div>


<br>

## 2. Set a name for the new server.

Enter a name for your server in the dedicated field,  then scroll down to the
image selection.

<div>
![step2](/assets/images/scaleway-capture-2.png)
</div>

<br>

## 3. Create the server.

Select the Cozy image in the imagehub tab, then click on the create server
button. At the bottom of the page.

<div>
![step3](/assets/images/scaleway-capture-3.png)
</div>

<br>

## 4. Wait for certificate generation and connect to your Cozy.

Certificate generation is very long on Scaleway hardware. So wait for 20
minutes to one hour, then connect with your browser to the IP address given by
the Scaleway team (https://ip.of.your.cozy/). You should see the registration
screen of your Cozy. Let's enjoy your new personal server!


## 5. Allow server to send emails.

By default, outgoing connections to email servers are blocked. To allow your server to send emails (for example, if you forgot your password or when you share some content), you have to go to the Scaleway admin panel and [change the option](https://www.scaleway.com/faq/server/network/#-I-cannot-send-any-email).

<div>
![step3](/assets/images/scaleway-capture-4.png)
</div>

