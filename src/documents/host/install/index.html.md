---
title: "Install Cozy on your server"
layout: "default"
category: "host"
menuOrder: 0
toc: true
---

# Install Cozy on your server

## Use our script

On your local machine install Fabric and fabtools:

```bash
apt-get install python python-pip python-dev software-properties-common
sudo pip install fabric fabtools
```

Download our Fabric file (a script that will run commands on your remote
server):

```bash
wget https://raw.github.com/mycozycloud/cozy-setup/master/fabfile.py
```


Once your system is prepared, use the Fabric script from your local
machine to launch the Cozy installation (run it in the same directory as the fabfile
you downloaded before):

```bash
fab -H sudoer@ip install
```

Enter your settings (such as domain name) when prompted by the installer.

Be patient; some commands or app deployments can take some time. It
depends on your network and hardware capabilities.

### About local installation

To install Cozy locally, we recommend you to create a virtual machine,
and then to run the fabfile script with your virtual machine as target.
This allows you to experiment with Cozy without installing numerous packages
into your environment.

The way to install it locally without VM or container is to run this command:

```bash
fab -H sudoer@localhost install
```

### Try Cozy with Vagrant

If you want to use Vagrant to run Cozy Cloud Setup in a virtual machine
we recommend you use the Ubuntu 12.04 box. Be careful as the update will require that
you configure your boot sequence. Choose the first filesystem that is offered, then click ok.

http://files.vagrantup.com/precise64.box


## Recommended Hardware

The CPU is not a limitation, Cozy can even run on RaspberryPi.

### Mininum

RAM: 512MB (it allows to have 4 apps running simultaneously)

Disk space: 2GB

### Recommended

RAM: 1024 Mo (it allows to have 10 apps simultaneously).

Disk space: a lot of space to store all your files.

## Test

Once the installation is done, you can access https://IP:443 to create your Cozy
main account. Be sure that you used the HTTPS protocol if you just see the nginx
welcome page.

## What will this script install on your server?

The Cozy install script installs the following tools:

* Python runtime
* Node.js runtime
* CouchDB document database
* Node tools: cozy-controller, cozy-monitor, coffee-script, compound, brunch
* Cozy Controller Daemon
* Cozy data indexer
* Cozy data layer
* Cozy proxy
* Cozy Home (web app)


If you want to know more about how Cozy works you can check our [architecture
page](https://github.com/mycozycloud/cozy-setup/wiki/Cozy-architecture).


## About virtual machines and containers

Because of the numerous technologies involved, we recommend you to run the Cozy
stack in an isolated virtual machine or in a container (OpenVz or LXC).
