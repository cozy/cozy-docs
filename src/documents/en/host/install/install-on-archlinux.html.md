---
title: "Install Cozy on Archlinux"
layout: "default"
category: "host"
menuOrder: 6
toc: false
---


<div class="install-inner-logo">
<img alt="Archlinux logo" src="/assets/images/host/archlinux-logo.svg">
</div>

# Install Cozy on Archlinux

## Warning

The Cozy package is available on the **AUR** (*Archlinux User Repository*) repository, which is not natively supported by Archlinux. In order to install Cozy, you will need an AUR helper, preferably among the ones listed [here](https://wiki.archlinux.org/index.php/AUR_helpers).

In this documentation, we'll be using **Yaourt**, which you can install following [these instructions](https://archlinux.fr/yaourt-en).

## Installing

Once Yaourt is installed, please enter the following command:

```
yaourt -S cozy
```

Unless you want to hack the package, please answer "no" when being asked if you want to edit the files `PKGBUILD` and `cozy.install`, and "yes" when being asked if you want to compile the package.

Once both the dependencies' installation and the package's creation is over, Yaourt will display the following message:

```
==> Install cozy ? [Y/n]
```

Please answer it with a positive answer. Cozy's stack installation and configuration will then begin.

## Configuring

Once the package is installed, Cozy won't instantly be usable. Before that, you will have to configure your Cozy's domain name and a [reverse proxy](https://en.wikipedia.org/wiki/Reverse_proxy).

### Configuring the domain name

The package comes with a script allowing the user to easily set Cozy's domain name and generate the needed certificates. You can run it with

```
sudo configure-cozy-domain cozy.example.tld
```

where you will replace `cozy.example.tld` with your Cozy's domain name.

This script can also be run whenever you wish to change your Cozy's domain name.

### Configuring the reverse proxy

In order for Cozy to work, it is necessary to use a reverse proxy. It can be a Web server or any software including this feature.

Among the software able to act as a reverse proxy, we have [Apache](https://wiki.archlinux.org/index.php/Apache_HTTP_Server) or [nginx](https://wiki.archlinux.org/index.php/Nginx), for which configurations examples are available ([here](https://github.com/cozy/cozy-debian/blob/master/apache-config) for Apache and [here](https://github.com/cozy/cozy-debian/blob/master/nginx-config) for nginx).

## Troubleshooting

If you encounter any issue during the installation, please open an issue on [GitHub](https://github.com/babolivier/cozy-archlinux) or on [the Cozy forum](https://forum.cozy.io/t/cozy-on-archlinux/1342).

### Conflict between `nodejs` and `nodejs-lts-bin`

In order to run Cozy, we need to install Node.JS v4.x.x (LTS), located in the `nodejs-lts-bin` AUR package.

Unfortunately, if Node.JS is already installed on your machine with the `nodejs` official package, a conflict will appear between it and `nodejs-lts-bin`. All you have to do to solve this issue is hitting "y" (letter can vary according to the system language, but you get it) when the installer asks you if you want to replace `nodejs` and `npm`.

### How to regenerate the certificate?

    sudo openssl req -x509 -nodes -newkey rsa:2048 -keyout /etc/cozy/server.key -out /etc/cozy/server.crt -days 3650 -subj "/CN=YOUR.INSTANCE.URL"
