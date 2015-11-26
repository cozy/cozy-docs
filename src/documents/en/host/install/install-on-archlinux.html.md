---
title: "Install on Archlinux"
layout: "default"
category: "host"
menuOrder: 2
toc: false
---


<div style="height: 0; overflow: shown; text-align: right">
<img alt="Logo d’Ubuntu" src="/assets/images/archlinux-logo.png">
</div>

# Install Cozy on Archlinux

Cozy packages are available on the **AUR** (*Archlinux User Repository*) repository, which is not natively supported by Archlinux. In order to install Cozy, you will need an AUR helper, preferably among the ones listed [here](https://wiki.archlinux.org/index.php/AUR_helpers).

In this documentation, we'll be using **Yaourt**, which you can install following [these instructions](https://archlinux.fr/yaourt-en).

## Choosing the right package

On Archlinux, Cozy has three different packages, depending on the [reverse proxy](https://en.wikipedia.org/wiki/Reverse_proxy) you wish you use with Cozy:

#### `cozy-nginx` 

This package uses the **nginx** Web server as reverse proxy, and installs it if it hasn't already been done. If an nginx server is already running on your machine, it's very recommended that you use this package. The Web server's configuration is automatically handled via an include in `/etc/nginx/nginx.conf`.

#### `nginx-apache`

This package is the same as the above one, except that it uses the **Apache** Web server instead of nginx. The Web server's configuration is automatically handled via an include in `/etc/httpd/conf/httpd.conf`.

#### `cozy-standalone`

This package addresses users who wish to configure themselves Cozy's reverse proxy, which can be either nginx, Apache, or another software. Please note that Cozy needs a reverse proxy in order to work properly.

## Installing

Once Yaourt is installed, and the package is chosen (we'll call it `cozy-xxx` from here for simplicity's sake), please enter the following command:

```
yaourt -S cozy-xxx
```

Unless you want to hack the package, please answer "no" when being asked if you want to edit the files `PKGBUILD` and `cozy-xxx.install`, and "yes" when being asked if you want to compile the package.

Among the dependencies is the `nodejs10` package, needed for Cozy to work properly. This package compiles Node.JS completely, which can take a lot of time on smaller configurations. Please wait until the end of this compilation.

Once both the dependencies' installation and the package's creation is over, Yaourt will display the following message:

```
==> Installer cozy-xxx ? [O/n]
```
Please answer it with a positive answer. Cozy's stack installation and configuration will then begin.

## Troubleshooting

If you encounter any issue during the installation, please open an issue on [GitHub](https://github.com/babolivier/cozy-archlinux) or on [the Cozy forum](https://forum.cozy.io/t/cozy-on-archlinux/1342).

### Conflict between `nodejs` and `nodejs10`

In order to run Cozy, we need to install Node.JS v0.10.x, located in the `nodejs10` AUR package. 

Unfortunately, if Node.JS is already installed on your machine with the `nodejs` official package, a conflict will appear between it and `nodejs10`. All you have to do to solve this issue is hitting "y" (letter can vary according to the system language, but you get it) when the installer asks you if you want to replace `nodejs` and `npm`.

### How to regenerate the certificate?

    sudo openssl req -x509 -nodes -newkey rsa:2048 -keyout /etc/cozy/server.key -out /etc/cozy/server.crt -days 3650 -subj "/CN=YOUR.INSTANCE.URL"
