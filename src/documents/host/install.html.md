---
title: "Install"
layout: "default"
category: "host"
menuOrder: 0
toc: true
---

# Installing Cozy

## Generic information
### Hardware requirements
The CPU is not a limitation, Cozy can even run on RaspberryPi.

#### Mininum
* RAM: 512MB (it allows to have 4 apps running simultaneously)
* Disk space: 2GB

#### Recommended
* RAM: 1024 Mo (it allows to have 10 apps simultaneously).
* Disk space: a lot of space to store all your files.

### About security in pre-installed images
For a production usage, you MUST renew the SSL certificate, reset the database credentials and reset the controller token.

For this purpose, use the following command:
```bash
wget https://raw.github.com/mycozycloud/cozy-setup/master/fabfile.py
fab -H user@ip reset_security_tokens
```

You should also change the superuser credentials and by the way, you should not user a password but a SSH key to connect to your Cozy. Please see [this tutorial](http://www.debian-administration.org/article/SSH_with_authentication_key_instead_of_password) to help you.


## Manual installation

### Use our script

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
you have previously downloaded):

```bash
fab -H sudoer@ip install
```

Enter your settings (such as domain name) when prompted by the installer.

Be patient; some commands or app deployments can take some time. It
depends on your network and hardware capabilities.

#### About local installation

To install Cozy locally, we recommend you to create a virtual machine,
and then to run the fabfile script with your virtual machine as target.
This allows you to experiment with Cozy without installing numerous packages
into your environment.

The way to install it locally without VM or container is to run this command:

```bash
fab -H sudoer@localhost install
```

#### Try Cozy with Vagrant

If you want to use Vagrant to run Cozy Cloud Setup in a virtual machine
we recommend you to use the Ubuntu 12.04 box. Be careful as the update will require that
you configure your boot sequence. Choose the first filesystem that is offered, then click ok.

http://files.vagrantup.com/precise64.box

### Test

Once the installation is done, you can access https://IP:443 to create your Cozy
main account. Be sure that you used the HTTPS protocol, if you just see the nginx
welcome page.

### What will this script install on your server?

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


If you want to know more about how Cozy works, you can check our [architecture
page](https://github.com/mycozycloud/cozy-setup/wiki/Cozy-architecture).


### About virtual machines and containers

Because of the numerous technologies involved, we recommend you to run the Cozy
stack in an isolated virtual machine or in a container (OpenVz or LXC).

## Raspberry Pi image

*Warning: For a production usage you have to change the superuser credentials,
renew the SSL certificate, the database credentials and the controller token.*

In order to run Cozy on your Raspberry Pi, the simplest way is to download our image and
set it up on a SD card.

For that, get the image archive:

```bash
# Download the image (~ 1.5GB)
wget http://files.cozycloud.cc/cozy-raspberrypi.im.tar.gz

# Uncompress it
tar -xvzf cozy-raspberrypi.im.tar.gz
```

Next, find where is mounted your SDCard; let's assume it is on */dev/sdc*,
then make a low level copy of the image to your card.

WARNING: this operation will erase all previously stored data into the card.

```bash
sudo dd bs=4M if=/my/path/cozy-raspberry.im of=/dev/sdc
```

Now insert the SD Card in your Raspberry Pi SD Card reader. Reboot your
Raspberry, then you will be able to access to your Cozy through the port 443
(https protocol).

## Virtualbox image

*Warning: For a production usage you have to change the superuser credentials,
renew the SSL certificate, the database credentials and the controller token.*

### Download requirements

* [Download](https://www.virtualbox.org/wiki/Downloads) and install VirtualBox.
* [Download](http://files.cozycloud.cc/cozycloud-virtualimage.zip) the Cozy
Virtual Machine for VirtualBox

### Import and try

Import the image to Virtualbox and start it.
You should be able to access to your Cozy through your browser by connecting to this URL:

```bash
https://localhost:2223/
```

### Additional informations

To access to the box shell use root/password as login and password.

You can find the box ip with the `ifconfig` command.

You can connect through ssh with:

```bash
ssh -p 2222 root@localhost
```

## OpenVZ image

Here we assume that you have already installed OpenVZ utilities.

### Download and start

```bash
# Download the OpenVz template (~ 1.3GB)
wget http://files.cozycloud.cc/vzdump-openvz-cozycloud-debian.tar

# Mount and start the container
vzrestore vzdump-openvz-cozycloud-debian.tar ctid
vzctl start ctid
```

*Credentials are root/password*

NB: Replace ctid by an available ctid (101, 102, etc.)


### With a configured network

You will probably need to give access to your container from outside of your
host. Here is a way to do it:

```bash
# Download the OpenVz template (~ 1.3GB)
wget http://files.cozycloud.cc/vzdump-openvz-cozycloud-debian.tar

# Mount your new container, give it an IP address and start it:
vzrestore vzdump-openvz-cozycloud-debian.tar ctid
vzctl set ctid --ipadd 10.0.0.10  --save
vzctl start ctid

# Setup a reverse proxy that routes your 8888 port to https://10.0.0.10:443
# (Use Nginx for instance).
# ...
# Then authorize the routing:
/sbin/iptables -t nat -A PREROUTING -i vmbr0 -p tcp --dport 8888 -j DNAT --to 10.0.0.10:443
```

Of course you can change 8888 by the value you want.

## LXC image


Use the LXC webpanel to add and configure containers; it's very easy to use.
For Ubuntu this can be installed this way:

```bash
sudo apt-get install -y lxc debootstrap bridge-utils
sudo su
wget http://lxc-webpanel.github.com/tools/install.sh -O - | bash
exit
```

Now access the webpanel at http://myhost.com:5000, the default login is admin/admin
(change this). Create a container, remember what you named it. Make it run at
startup. Then, go to command line to access the container.

```bash
lxc console <container name>
```


Follow the Cozy installation instructions (install fab, curl fabfile). Once
finished, Cozy is up and running and your Cozy container will be listening on
port 9104. You also need to know the IP address that LXC assigned to your
container:

```bash
/sbin/ifconfig $1 | grep "inet addr" | awk -F: '{print $2}' | awk '{print $1}'
```


Exit your container. Now that it's set up, you should disable the LXC webpanel
since, it's a security risk.

```bash
sudo service lwp stop
sudo update-rc.d -f lwp remove
```

Finally, set up your main server as a reverse proxy for the cozy container. For
nginx we used this template:

```bash
server {
    listen 80;

    server_name cloud.myhost.com;

    access_log  /var/log/nginx/cozy_access.log;
    error_log  /var/log/nginx/cozy_error.log;
    root   /usr/share/nginx/html;
    index  index.html index.htm;

        location / {
                proxy_set_header X-Real-IP $remote_addr;
                proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
                proxy_set_header Host $http_host;
                proxy_set_header X-NginX-Proxy true;
                proxy_pass http://<container IP>:9104;
                proxy_redirect http://<container IP>:9104 https://$server_name/;
        }
}
```

Restart nginx, and your Cozy should be accessible at http://cloud.myhost.com

## Hosting services
### Cozycloud
[Cozycloud](https://cozycloud.cc) is the maintainer of the Cozy project.




