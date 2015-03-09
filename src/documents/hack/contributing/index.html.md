---
title: "Contributing"
layout: "default"
category: "hack"
menuOrder: 4
toc: true
---

# Contributing to Cozycloud

You can contribute to Cozy in many ways, whether you are a NodeJS Ninja or a
Net-Citizen willing to protect her/his privacy, all contributions are welcome!
Report a bug, submit a feature request or improve the documentation to ease
self-hosting, translations, developing new applications...

**There's something for everyone!**

Everything is free and open-source and hosted on
[Github](https://github.com/cozy/), this page will explain you how can
help.


## Reporting a bug or submitting a feature request

We use Github's issues to report the bugs or submit a feature request. Every
application or module has its own Github page.
Try to be accurate in your descriptions and add, if possible, screenshots, especially for bug reports.


## The documentation

You can improve the documentation you are currently reading by modifying and
submitting us a pull request on the
[dedicated Github repository](https://github.com/cozy/cozy-docs/).

## Building and sharing an application

If you have an idea and don't know where to start, check out [our tutorials](/hack/getting-started/). All you need to know is a bit of JavaScript!

## Translating Cozy and applications
You can be very helpful by translating Cozy and applications. See the [translator guide](/hack/cookbooks/localization.html#Summary-for-translator-contributors) and make sure you follow the [localization guidelines](/hack/cookbooks/localization.html#Localization-guidelines).

## Documentation's roadmap

What's coming next? Here is what we plan to add (order is relevant). Feel free to ask for something you are interested in.

* cookbook: how to deploy a cozy app (permissions, ...)
* data system's [current documentation](https://github.com/cozy/cozy-data-system/wiki/)
* data system's API cookbook: adding the authentication and authorization section
* cookbook: how to make your app notified by data system's changes in realtime
* cookbook: how to add Cozy notifications from your app
* cookbook: how to send emails from your app
* cookbook: how to add public routes to your application
* cookbook: cozy-dev documentation
* cookbook: resetting cozy
* cookbook: everything about security in Cozy
* cookbook: unit and functional testing
* cookbook: how to easily manage the fixtures with cozy-fixtures

## Contributing to the core code

These are explanations on how to test modifications done on the core modules:
Data System, Home, Controller or Proxy.

1. Setup Vagrant

2. Get the development virtual machine

    ```bash
    vagrant box add cozycloud-dev-latest http://files.cozycloud.cc/cozycloud-dev-latest.box
    ```

3. Run the development virtual machine

    ```bash
    vagrant init cozycloud-dev-latest
    vagrant up
    ```

4. Update it, if needed

    ```bash
    vagrant ssh

    sudo supervisorctl stop cozy-controller
    sudo pkill -9 node # make sure no process is remaining.
    sudo npm -g install cozy-controller
    sudo supervisorctl start cozy-controller

    sudo cozy-monitor install data-system
    sudo cozy-monitor install home
    sudo cozy-monitor install proxy

    cozy-monitor stop home
    ```

5. Clone the repository you want to work with (home in this example), install and run it.
The --no-bin-links is needed because you can't symlink in the shared folder.

    ```bash
    cd /vagrant/
    git clone https://github.com/cozy/cozy-home
    cd /vagrant/cozy-home
    sudo npm install --no-bin-links
    node build/server.js
    ```

6. On the host, browse to http://127.0.0.1:9104, register a user, and then check http://127.0.0.1:9104/#home.
You should see logs popping up in your console. IF you are asked to login instead of registering, use this fix:

    ```bash
    Ctrl + C
    sudo cozy-monitor start home
    cd /usr/local/cozy/apps/home/home/cozy-home/
    sudo coffee commands cleanuser
    sudo cozy-monitor stop home
    cd /vagrant/cozy-home
    node server
    ```

7. Hack ! You should see the repository on your host system in the same directory as where you did vagrant up.
Use your favorite editor to edit the .coffee files. You will need to compile before seeing your changes.

    For server changes :

         Ctrl + C
         cake convert
         node server

    For client changes, open a new vagrant ssh and :

         cd /vagrant/cozy-home/client/
         npm install --no-bin-links
         brunch w
