---
title: "Understand the Cozy Architecture"
layout: "default"
category: "hack"
menuOrder: 3
---

# Understand the Cozy Architecture

It is important to understand how Cozy is built to understand how it works. Let's quickly see how it looks like.

![Architecture Overview](/assets/images/cozy-architecture.png)

Too long, don't want to read ? Check out [what you should remember](#what-you-should-remember)!

Cozy is made of three different layers:

* the Proxy
* the pPaaS
* the persistence layer

## The Proxy ([Github repository](https://github.com/mycozycloud/cozy-proxy/))
The proxy main job handles the authentification and authorization to the Cozy. It is the application that manages registration, login, logout and password reset.

It also handles all the routing of Cozy (to send the right request to the right application).

## The pPaaS ([Github repository](https://github.com/mycozycloud/cozy-controller/))
pPaaS stands for "personal Platform as a Service".
You may already know what a PaaS is: an execution environment for applications.
A personal PaaS is a personal execution environment for personal applications collaboring around personal data. You got it, a pPaaS is all about the user!

Technically, the "controller" and the "home application" play with each other to install, run, update and remove applications within Cozy. We've forked [Haibu](https://github.com/nodejitsu/haibu) to add custom options: more security (applications are run by separate users, restrict the access to the controller itself, ...), handling apps authentification to the Data System, logging, ...

The [cozy-controller](https://github.com/mycozycloud/cozy-controller/) can also be used through a dedicated tool, the [cozy-monitor](https://github.com/mycozycloud/cozy-monitor/). You shouldn't worry too much about it since it is unlikely you will use it one day (except if you host your own Cozy or are willing to contribute to the core).

## The persistence layer: the Data System ([Github Repository](https://github.com/mycozycloud/cozy-data-system/))
You've just built your first app using SQLite and you are wondering why we speak about another persistence mecanism? Well, let us present you the Data System.

It's a unified API that allows applications to access:

* the database (CouchDB)
* the file system
* the indexer (Whoosh)

The Data System is Cozy's true power. It keeps the user data safe by restricting their access by applications.
During an application installation, the user is prompted to allow or not the application to access various types of data ("doctypes") so he can **control** whether he trusts the application or not.
It also gives the opportunity to use multiple data-source. Do you want to have contacts in your agenda application? Do it!

You can find the complete API and details about the Data System on the dedicated [cookbook](/cookbooks/data-system.html).

<a name="what-you-should-remember"></a>
## What you should remember
As a developer, you are going to create an application that will be run by Cozy's pPaaS. That application will access the data through the Data System.
Also, you won't have to bother about user authentification and authorization because it is all handled by the Proxy.

Keep in mind you develop for a **personal** environment which is not something we are used to at first but it only changes the relation to data we had until now!

Ready to go one step further with Cozy? Get your hands dirty with [the Data System](/hack/getting-started/play-with-data-system.html).
