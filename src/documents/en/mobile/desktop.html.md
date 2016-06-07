---
title: "Desktop"
layout: "default"
category: "mobile"
menuOrder: 1
toc: true
---

# Desktop Synchronization

Cozy-desktop client allows you to synchronize your files and folders between your Cozy and your desktop. Thus, you can work on your files offline. Your modifications will be synchronized as soon as network will be available.

## Installation

Before installing Cozy-desktop, your Cozy should be up-to-date.



### Linux
```bash
apt-get install ca-certificates apt-transport-https

wget -O - https://cozy-desktop.cozycloud.cc/debian/cozy-desktop.gpg.key 2>/dev/null | apt-key add -

echo 'deb [arch=amd64] https://cozy-desktop.cozycloud.cc/debian jessie cozy-desktop' > /etc/apt/sources.list.d/cozy.list


apt-get update
apt-get install cozy-desktop-gui
```

### OSX

Coming soon ... :)

### Windows

Coming soon ... :)


## Configuration

Once installed, run it. It will ask you for a few information:

* Your Cozy url. In other words, address used to access to your Cozy.
* Your Cozy password. We don't save your password, we only use it to create a new device login which it uses to synchronize your files.
* The folder where you want to synchronize your files.

![Onboarding](/assets/images/desktop/en_onboarding.png)

Once done, you will be redirected to the dashboard. First synchronization can now start.

The dashboard is composed of :

* An information panel about synchronizations and available disk space on your Cozy.
* A settings panel to configure autostart.
* An account panel with information on your Cozy and possibility to unlink your Cozy.
* A help panel in case of problem

![Dashboard](/assets/images/desktop/en_dashboard.png)


## FAQ

If you have an error that looks like this:

    [Error: Error: /tmp/.org.chromium.Chromium.ox2yyn: failed to map segment from shared object: Operation not permitted: unable to import leveldown]

It means that Cozy-desktop can't run correctly because the temporary directory is mounted with the noexec option and that prevents loading dynamic library like leveldown from there. The work-around is to use another temp directory:


```bash
export TMPDIR="$HOME/tmp"
mkdir -p $TMPDIR
cozy-desktop
```


##  Troubleshooting

When you hit a problem with the application, you can send us a message with the application logs, so we can try to understand and fix the problem.

Open help panel, then click on ***Send us a message*** in ***Official support***.

![Trouble](/assets/images/desktop/en_trouble.png)

Don't forget to describe your problem by adding as many details as you can.

