---
title: "Architecture Overview"
layout: "default"
category: "hack"
menuOrder: 3
---

# Architecture Overview

It is important to understand how Cozy is built to understand how it works. Let's see what it looks like.

![Architecture Overview](/assets/images/cozy-architecture.png)

Cozy is made of three different layers:

* the proxy
* the pPaaS
* the persistence layer

## The Proxy
The proxy main job is handling the authentification and authorization to the Cozy. This is the application that manage registration, login, logout and password reset.

It also handles all the routing of Cozy (to send a request to the right application).

## The pPaaS
pPaaS stands for "personal Platform as a Service".
You may already now what is a PaaS: an execution environment for applications.
A personal PaaS is a personal execution environment for personal applications collaboring around personal data. You got it, a pPaaS is all about the user it serves!

Technically, the "controller" and the "home application" play with each other to install, run, update and remove applications within Cozy. We've forked [Haibu](https://github.com/nodejitsu/haibu) to add custom options: more security (applications are run by separate users, restrict the access to the controller itself, ...), handling apps authentification to the Data System, logging, ...

The [cozy-controller](https://github.com/mycozycloud/cozy-controller/) can be manipulated with a dedicated tool: [cozy-monitor](https://github.com/mycozycloud/cozy-monitor/). You shouldn't worried too much about it since it is unlikely you will use it one day (except if you host your own Cozy or are willing to contribute to the core).

## The persistence layer: the Data System
The persistence layer is made of three components: the database (couchDB), the file system and the indexer (woosh).
They are not accessible directly but through a unified API called the Data System.

The Data System is where Cozy's power is. It allows the user to chose which application accesses which type of data so he can **control** and **decide** wether he trusts or not an application.
It also opens the opportunity to use multiple data-source. Do you want to have contacts in your agenda application? Do it!

A dedicated section will tackle the Data System in details.


## What you should remember
As a developer, you are going to create an application that will be run by Cozy's pPaaS. That application will acess the data through the Data System.
Also, you will not have to bother about user authentification and authorization because it is all handled by the Proxy.

Keep in mind you develop for a **personal** environment which is not something we are used to at first. It only changes the relation to data we had until now!
