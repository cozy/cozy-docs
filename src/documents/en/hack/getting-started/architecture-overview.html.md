---
title: "Understand the Cozy Architecture"
layout: "default"
category: "hack"
menuOrder: 3
toc: true
---

# Understand the Cozy Architecture

It is important to understand how Cozy is built in order to understand how it works. Let's quickly see what it looks like.

![Architecture Overview](/assets/images/architecture-overview.svg)

Too long, don't want to read ? Check out [what you should remember](#what-you-should-remember)!

<br />
Let's detail each part. Cozy is made of three different layers:

* [the platform interface](#the-platform-interface)
* [the pPaaS](#the-ppaas)
* [the persistence layer](#the-persistence-layer-the-data-system)

## The platform interface
The platform interface is composed of two applications: the Proxy and the Home (see previous diagram).

### The Proxy
([Github repository](https://github.com/cozy/cozy-proxy/))

The proxy's main job is handling the authentication and authorization in Cozy. It is the application that manages registration, login, logout and password reset.

It also handles all the routing of Cozy (to send the right request to the right application).

<br />
If you want to learn more about authentication and authorization in Cozy, there is a [dedicated cookbook on the subject](/hack/cookbooks/authentication-authorization-workflows.html).

### The Home
([Github repository](https://github.com/cozy/cozy-home/))

The Home is basically a user interface to manage your Cozy: install, update, and uninstall applications, changing your settings (language, timezone). It is also the central hub for tranverse features like notifications or tags.

This application is basically like the one you could write, except it has specific permissions to manage other applications. That means one could imagine writing another version of the Home with other features and capabilities.

## The pPaaS
([Github repository](https://github.com/cozy/cozy-controller/))

pPaaS stands for "personal Platform as a Service".
You may already know what a PaaS is: an execution environment for applications.

A personal PaaS is a personal execution environment for personal applications collaborating around personal data. You got it, a pPaaS is all about the user!

Technically, the Controller and the Home play with each other to install, run, update and remove applications within Cozy. It makes sure applications are run in a good isolation, manage logging, and more.

The [cozy-controller](https://github.com/cozy/cozy-controller/) can also be used through a dedicated tool, the [cozy-monitor](https://github.com/cozy/cozy-monitor/). The cozy-monitor is a CLI tool, equivalent to the Home: they are both interfaces to the Controller. To use it, you must be root on the machine hosting your Cozy.

## The persistence layer: the Data System
([Github Repository](https://github.com/cozy/cozy-data-system/))

You've just built your first app using SQLite, so you are probably wondering why we're talking about another persistence mechanism. Well, let us introduce you to the Data System.

It's a unified API that allows applications to access:

* the database (CouchDB)
* binaries (in CouchDB too)
* the indexer (a REST wrapper of our own, built around Whoosh)

The Data System is Cozy's true power. It keeps the users data safe by restricting their access by applications.
During the installation of an application, the user is prompted to allow or deny access to various types of data ("doctypes"), so they can **decide** wether they trust the application or not.
It also opens the opportunity to use multiple data sources. Do you want to have contacts in your agenda application? Well, you can. It's all up to you!

One important thing to understand about Cozy, is that the platform owns the data, not the application. Applications are just granted permissions by the user to access and manipulate them.

![Applications collaborating around data](/assets/images/architecture-collaborating-around-data.svg)

In this scenario, if you uninstall "Sync", it won't delete your contacts, they will still be usable by Contacts and Files.

<br / >
You can find the complete API and details about the Data System on the dedicated [cookbook](/hack/cookbooks/data-system.html).

## What you should remember
As a developer, you are going to create an application that will be run by Cozy's pPaaS. That application will access the data through the Data System.
Also, you won't have to bother with user authentication and authorization because it is all handled by the Proxy.

Keep in mind you're developing for a **personal** environment, which is something you might not be used to at first.
It changes the relationship to data we had until now!

Ready to go one step further with Cozy? Get your hands dirty with [the Data System](/hack/getting-started/play-with-data-system.html).
