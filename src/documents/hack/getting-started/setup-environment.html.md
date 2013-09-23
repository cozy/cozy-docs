---
title: "Setup the environment"
layout: "default"
category: "hack"
menuOrder: 1
---

# Setup the environment

Welcome to the first step to get you started: the development environment setup process.

Since Cozy is built on many software bricks, we wrapped it into an easy to use virtual machine so you don't pollute your local system. That also means you can use the operation system you like!


## Installaling dependencies

Before doing anything, install the fowlling:

### [Node.js (v0.8.20)](http://blog.nodejs.org/2013/02/15/node-v0-8-20-stable/)
Node.js powers awesome tools that we use to develop apps. We also wrote a tool to manage the virtual machine more easily.

### [VirtualBox (>= v4.2.16)](https://www.virtualbox.org/wiki/Downloads)
Virtual Box allows you to run virtual machine on your computer. We use it indirectly with Vagrant to power our virtual machine.

### [Vagrant (>= v1.2.7)](http://downloads.vagrantup.com/)
Vagrant is a tool to "create and configure lightweight, reproducible and portable development environments." That's what we need here! We use it through a custom CLI tool so you will not manipulate it directly.

### [Git](http://git-scm.com/book/en/Getting-Started-Installing-Git)
Git is a control version tool that is now very common. We use it in combination with [Github](https://github.com) that allows you to store online your repository and much more!

You will also need our tool:

``` bash
npm install -g cozy
```

The `cozy` tool will help you managing the virtual machine and application skeletons!


## Initializing and starting the virtual machine

The next step is to get your virtual machine. Basically, we you are going to have a linux running on your computer with all a Cozy needs to work on already installed and configured.

To help you managing the VM, the Cozy Manager comes to the rescue.
Create a folder that will contains all your source code:
``` bash
mkdir cozy-dev && cd cozy-dev
```

Now you can use the Cozy Manager to initialize the VM by running:
``` bash
cozy dev:init
```
This will download the base box file (~500MB) and a custom configuration ([see it on Github](https://github.com/mycozycloud/cozy-setup/blob/master/dev/Vagrantfile)). Then the VM will be created. The whole process will take you about 15 minutes (depending on your internet connection and your computer).

Then you can start the VM and check that everything is running correctly.
``` bash
cozy dev:start
cozy dev:vm-status
```

We advise you to update the VM the first time you start it (and regularly) because we don't update the base box each time we improve or fix a bug in the "core" of Cozy:
``` bash
cozy dev:light-update
```

You can go to `http://localhost:9104/` see your Cozy running. You can also use it but beware! The Cozy running in your virtual machine is in development mode, meaning that most of the security measures are disabled. Only use it for testing purpose!

We explain in details how the Cozy Manager works in another section.

You are now ready to write your first application, We hope it wasn't too long!