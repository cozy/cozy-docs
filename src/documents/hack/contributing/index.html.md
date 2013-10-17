---
title: "Contributing"
layout: "default"
category: "hack"
menuOrder: 4
---

# Contributing to Cozycloud

You can contribute to Cozy in many ways, wether you are a NodeJS Ninja or a
Net-Citizen willing to protect her/his privacy, all contributions are welcome!
Report a bug, submit a feature request or improve the documentation to ease
self-hosting, translations, develop new applications...
**There's something for everyone!**

Everything is libre and open-source and hosted on
[Github](https://github.com/mycozycloud/), this page will explain you how can
help.


## Reporting a bug or submitting a feature request

We use Github's issues to report the bugs or submit a feature request. Every
application or module has its own Github page.
Try to be as descriptive as possible and add screenshots if you can,
espescially for bug reports.


## The documentation

You can improve the documentation you are currently reading by modifying and
submitting us a pull request on the
[dedicated Github repository](https://github.com/mycozycloud/cozy-docs/).

## Building and sharing an application

If you have an idea and don't know where to start, check out [our tutorials](/hack/getting-started/). All you need to know is a bit of JavaScript!

## Translating Cozy and applications
You can be very helpful by translating Cozy and applications. See the [translator guide](/hack/cookbooks/localization.html#summary) and make sure you follow the [localization guidelines](/hack/cookbooks/localization.html#guidelines).

## Documentation's roadmap

What's coming next? Here is what we plan to add (order is relevant). Feel free to ask for something you are interested in.

* cookbook: how to deploy a cozy app (permissions, ...)
* data system's [current documentation](https://github.com/mycozycloud/cozy-data-system/wiki/)
* data system's API cookbook: adding the authentification and authorization section
* cookbook: how to make your app notified by data system's changes in realtime
* cookbook: how to add Cozy notifications from your app
* cookbook: how to send emails from your app
* cookbook: how to add public routes to your application
* cookbook: how to make your app translatable
* cookbook: cozy-manager documentation
* cookbook: resetting cozy
* cookbook: everything about security in Cozy
* cookbook: unit and funcitonal testing
* cookbook: how to easily manage the fixtures with cozy-fixtures
* improve the menus: drop-down top menu + internal menus

## Contributing to the core code

These are explainations on how to test modifications done on the core modules:
Data System, Home, Controller or Proxy.

1. Setup Vagrant

2. Get the development virtual machine

    vagrant box add cozycloud-dev-latest http://files.cozycloud.cc/cozycloud-dev-latest.box
   
3. Run the development virtual machine

    vagrant init cozycloud-dev-latest
    vagrant up
    
3. Update it if needed

    vagrant ssh

    sudo supervisorctl stop cozy-controller
    sudo pkill -9 node # make sure no process is remaining.
    sudo npm -g install cozy-controller 
    sudo supervisorctl start cozy-controller

    sudo cozy-monitor install data-system
    sudo cozy-monitor install home
    sudo cozy-monitor install proxy

    cozy-monitor stop home

4. Changed directories to the shared cozy-home repo folder (/vagrant/cozy-home
for me) and followed Romain's instructions to install all the needed node bits
using

    sudo npm install --no-bin-links

5. Remove existing user if needed:

    cozy-monitor start home
    cd /usr/local/cozy/apps/home/home/cozy-home/
    sudo coffee commands cleanuser
    cozy-monitor stop home
    cd /vagrant/cozy-home
    node server

6. Browse the dev Cozy on the host system to http://127.0.0.1:9104, register a
user, and then check http://127.0.0.1:9104/#home

7. Modify the module you work on and restart it. For modifications, work only on the coffeescript code then run the following command to convert coffeescript to javascript and see the result.

     cake convert


