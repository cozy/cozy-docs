---
title: "Understanding Cozy's development environment"
layout: "default"
category: "hack"
menuOrder: 3
toc: true
---

# Understanding Cozy's development environment

In the step-to-step documentation, we scratch the surface of the development environment, showing you what you need when you need it. This cookbook describes precisely all the available commands, and how you should develop your app for Cozy.

The development environment is made of a CLI tool and a virtual machine. The CLI tool allows you to manage the virtual machine, so don't worry.

<br />
The whole point is to help you focus on your application, without caring too much about how Cozy itself works. If you have any suggestion to help us improve the development environment, let us know!

## Installation
Install the CLI tool:
```bash
sudo npm install -g cozy-dev
```

You also need Virtualbox and Vagrant in order to run the virtual machine. Please see our [getting started](/hack/getting-started/setup-environment.html) if you haven't installed them yet.

## Classic setup
This is how you will develop your applications. Run the application on your computer, test it out. If you need features from Cozy, just use them as if they were on `localhost`, the virtual machine provides them thanks to port forwarding.

The virtual machine is basically a real Cozy without the security. You can use it from `http://localhost:9104/`

<center><a href="/assets/images/cozy-dev-setup.svg" target="_blank">
![Classic setup with cozy-dev](/assets/images/cozy-dev-setup.svg)
(Click to enlarge)
</a></center>

<br />
If you want to see your app in action like if it was installed in Cozy, just use the following command in the root folder of your application:

```bash```
cozy-dev deploy
```
Then you can access it from `http://localhost:9104/apps/{yourAppSlug}/`

`{yourAppSlug}` is defined in `package.json` in the field `name`.

All the commands are details in the next sections.


## Managing the virtual machine
### vm:init

```bash
cozy-dev vm:init
```

You have to use this command only the first time you use cozy-dev. It downloads and setup the virtual machine image.

### vm:start

```bash
cozy-dev vm:start
```

Start the virtual machine.

### vm:status

```bash
cozy-dev vm:status
```

Check that every part of Cozy is properly running in the virtual machine.

### vm:update

```bash
cozy-dev vm:update
```

Run a script to update the software within the virtual machine. NO DATA LOSS.
Before update your virtual machine, you should start it (`cozy-dev vm:start`).

### vm:update-image

```bash
cozy-dev vm:update-image
```

Destroy and re-download the virtual machine image. ALL DATA WILL BE LOST.

### vm:stop

```bash
cozy-dev vm:stop [--halt]
```

Pause the virtual machine (persist its state on your hard drive). If you use `--halt`, it will stop the virtual machine (real stop).

### vm:destroy

```bash
cozy-dev vm:destroy
```

Destroy the virtual machine. ALL DATA WILL BE LOST.


## Developing an application
### new

```bash
cozy-dev new <appName> [--coffee]
```

Create a new application folder `appName` based on https://github.com/cozy/cozy-template.
If you want to create a new application based on the coffee template (https://github.com/cozy/cozy-template-coffee), use the option `--coffee`.

### deploy

```bash
cozy-dev deploy <port>
```

Trick the virtual machine to make it think your application is actually installed in the Cozy. By default, `port` is 9250. It will use the `package.json` at the root of your application to get the application's slug.
Basically, it doesn't change anything for you, except that you can access your app through the Cozy interface. Just run the `deploy` command, and start your application's server like you are used to.


<center><a href="/assets/images/cozy-dev-setup-deploy.svg" target="_blank">
![Classic setup with cozy-dev with deploy](/assets/images/cozy-dev-setup-deploy.svg)
(Click to enlarge)
</a></center>

Normally you just need to deploy one time your app at the root of your document, unless you change his name in package.json (CozyCloud will get the name of the app in this file). You will see your server working when you access your app in CozyCloud. If you make changes in your server but it does not show on CozyCloud, please refresh the page by clicking on F5. Sometimes the app does not load when the cache is not emptied.

An other detail : cozy-dev deploy only gives the port of the machine at the VM. So you still need to start the server on your machine.

### undeploy

```bash
cozy-dev undeploy
```

Revert a previous `cozy-dev deploy` command.

## Managing the database
### db:switch

```bash
cozy-dev db:switch [dbName]
```

Switch the database used by the virtual machine. By default, `dbName` is `cozy`.

This command is very useful if you want to run tests in isolation!

### db:reset

```bash
cozy-dev db: reset <dbName> [--force]
```

Reset the given database. All data will be lost, use at your own risk! If you want to not be prompted a confirmation message, you can use `--force`.

This command is very useful if you want to run tests in isolation!
