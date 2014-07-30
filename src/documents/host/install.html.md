---
title: "Install"
layout: "default"
category: "host"
menuOrder: 0
toc: true
urls: ["/host/"]
---

# Installing Cozy

## Generic information
### Hardware requirements

The CPU is not a limitation; Cozy can even run on RaspberryPi.

#### Minimum

* RAM: 512MB (it allows to have 4 apps running simultaneously).
* Disk space: 2GB.

#### Recommended

* RAM: 1024 Mo (it allows to have 10 apps running simultaneously).
* Disk space: a lot of space to store all your files.

### About security in pre-installed images

For a production usage, you MUST renew the SSL certificate, reset the database credentials and reset the controller token.

For this purpose, use the following command:
```bash
wget https://raw.githubusercontent.com/cozy/cozy-setup/master/fabfile.py
fab -H user@ip reset_security_tokens
```

You should also change the superuser credentials (and by the way, you should not use a password but a SSH key to connect to your Cozy). Please refer to [this tutorial](http://www.debian-administration.org/article/SSH_with_authentication_key_instead_of_password).


## Manual installation

### Use our script

On your local machine, install Fabric and fabtools:

```bash
apt-get install python python-pip python-dev software-properties-common
sudo pip install fabric fabtools
```

Download our Fabric file (a script that will run commands on your remote
server):

```bash
wget https://raw.githubusercontent.com/cozy/cozy-setup/master/fabfile.py
```


Once your system is prepared, use the Fabric script from your local
machine to launch the Cozy installation (run it in the same directory as the fabfile
you have previously downloaded):

```bash
fab -H sudoer@ip install
```

Where "sudoer" is a sudo user and "ip" your server IP.

Enter your settings (such as domain name) when prompted by the installer.

Be patient; some commands or app deployments can take some time. It
depends on your network and hardware.

#### About local installation

To install Cozy locally, we recommend you create a virtual machine,
and then run the fabfile script with your virtual machine as target.
This allows you to experiment with Cozy without installing numerous packages
into your environment.

To install it locally without VM or container, run this command:

```bash
fab -H sudoer@localhost install
```

#### Try Cozy with Vagrant

You can use Vagrant to run Cozy Cloud Setup in a virtual machine. To do so, 
we recommend you use the Ubuntu 12.04 box. Be careful as the update will require that
you configure your boot sequence. Choose the first filesystem that is offered, then click ok.

http://files.vagrantup.com/precise64.box

### Test

Once the installation is done, you can access https://IP:443 to create your Cozy
main account. If you're just seeing the nginx welcome page, make sure you're
using the HTTPS protocol.

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


If you want to know more about how Cozy works, check out our [architecture
page](/hack/getting-started/architecture-overview.html).


### About virtual machines and containers

Because of the many technologies involved, we recommend you run the Cozy
stack in an isolated virtual machine or in a container (OpenVz or LXC).

## Ansible Playbook

[Ansible](www.ansible.com) is a simple configuration system that allows people
to automate installation and maintenance of services on a remote server. Its
simplicity makes it very popular among people who hosts services on a personal
server.

It's based on the concept of playbooks. A playbook describes the state of a
service and its requirements to work properly. If something is missing Ansible
will perform required operations to bring the service to the required state.

So, first [install Ansible](http://docs.ansible.com/intro_installation.html)
on your local machine:

```bash
# Install ansible (for Ubuntu 14.04)
sudo apt-get install ansible
```

Then get the description of the Cozy playbook.

```bash
# Get the Cozy Ansible Playbook (maintained by the community)
git clone https://github.com/zaurky/ansible-cozy-playbook.git
cd ansible-cozy-playbook
```

Cozy requires several software specific versions (Node.js, CouchDB, etc.).
Ansible Galaxy provides a role repository (playbooks are set of roles) where
users share installation for common softwares. Here we download the
"dependencies" of the Cozy playbook.

```bash
# Install role dependencies
ansible-galaxy install -r galaxy.yml -p ./roles
```

You have to store the information of the remote server on which you want to
install your Cozy.

```bash
# Store your remote server address
echo "[myserver]" > hosts
echo "your.domain.me" >> hosts
```

Then you can perform the installation by running the playbook. You can run the
playbook as much as you want. It will ensure that your Cozy is in the right
state.

```bash
# Run the playbook
ansible-playbook playbook.yml -i hosts
```

Once donce, your Cozy should be up on the 443 port. Now, enjoy!

## Raspberry Pi image

*Warning: For production use, you must change the superuser credentials,
renew the SSL certificate, the database credentials and the controller token.*

In order to run Cozy on your Raspberry Pi, the simplest way is to download our
image and set it up on a SD card. The image is based on the
[Raspbian](http://www.raspbian.org/) distribution.

First, get the image archive:

```bash
# Download the image (~ 0.9GB)
wget http://files.cozycloud.cc/cozy-raspberrypi.im.tar.gz

# Uncompress it
tar -xvzf cozy-raspberrypi.im.tar.gz
```

Next, find where your SD card is mounted; let's assume it is on */dev/sdc*,
then make a low-level dump of the image onto your card.

NB: SD Class 10 card are recommended for better performance. 

WARNING: this operation will erase all previously stored data on the card.

```bash
sudo dd bs=4M if=./cozy-raspberrypi-1.0.6.im of=/dev/sdc
```

Now insert the SD card in your Raspberry Pi SD card reader. Reboot your
Raspberry, and you will be able to access your Cozy through port 443
(https protocol).

If you want to login to the pi, use the default raspbian credentials ```pi```
and ```raspberry```. By the way, don't forget to change the password and to
[reset the security
tokens](http://cozy.io/host/install.html#about-security-in-pre-installed-images)!

NB: The keyboard layout is
azerty, so the a is switched with the q. We'll change that soon.

## Cubieboard2 image

*Warning: For production use, you must change the superuser credentials,
renew the SSL certificate, the database credentials and the controller token.*

In order to run Cozy on your Cubieboard2, the simplest way is to download our
image and set it up on a SD card.

First, get the image archive:

```bash
# Download the image (~ 1.5GB)
wget http://files.cozycloud.cc/cozy-cubieboard2.im.tar.gz

# Uncompress it
tar -xvzf cozy-cubieboard2.im.tar.gz
```

Next, find where your SD card is mounted; let's assume it is on */dev/sdc*,
then make a low-level dump of the image onto your card.

NB: SD Class 10 card are recommended for better performance.

WARNING: this operation will erase all previously stored data on the card.

```bash
sudo dd bs=4M if=/my/path/cozy-cubieboard2.im of=/dev/sdc
```

Now insert the SD card in your Cubieboard2 SD card reader. Reboot your
Cubieboard, and you will be able to access your Cozy through port 443
(https protocol).

If you want to login to the board, use the default Cubian credentials ```cubie```
and ```cubie```. By the way, don't forget to change the password and to
[reset the security
tokens](http://cozy.io/host/install.html#about-security-in-pre-installed-images)!

## Cubietruck image

*Warning: For production use, you must change the superuser credentials,
renew the SSL certificate, the database credentials and the controller token.*

In order to run Cozy on your Cubietruck, the simplest way is to download our
image and set it up on a SD card. It is based on the 
[Cubian](http://cubian.org/) distribution.

First, get the image archive:

```bash
# Download the image (~ 1.5GB)
wget http://files.cozycloud.cc/cozy-cubietruck.im.tar.gz

# Uncompress it
tar -xvzf cozy-cubietruck.im.tar.gz
```

Next, find where your SD card is mounted; let's assume it is on */dev/sdc*,
then make a low-level dump of the image onto your card.

NB: SD Class 10 card are recommended for better performance.

WARNING: this operation will erase all previously stored data on the card.

```bash
sudo dd bs=4M if=/my/path/cozy-cubietruck.im of=/dev/sdc
```

Now insert the SD card in your Cubietruck SD card reader. Reboot your
Cubietruck, and you will be able to access your Cozy through port 443
(https protocol).

If you want to login to the board, use the default Cubian credentials ```cubie```
and ```cubie```. By the way, don't forget to change the password and to
[reset the security
tokens](http://cozy.io/host/install.html#about-security-in-pre-installed-images)!



## Virtualbox image

*Warning: For production use, you must change the superuser credentials,
renew the SSL certificate, the database credentials and the controller token.*

### Download requirements

* [Download](https://www.virtualbox.org/wiki/Downloads) and install VirtualBox.
* [Download](http://files.cozycloud.cc/cozycloud-virtualimage.zip) the Cozy
Virtual Machine for VirtualBox

### Import and try

Import the image to Virtualbox and start it.
You should be able to access your Cozy through your browser by connecting to this URL:

```bash
https://localhost:2223/
```

### Additional informations

To access the box shell, use root/password as login and password.

You can find the box' IP with the `ifconfig` command.

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

You will probably need to give access to your container from outside your
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
For Ubuntu this can be installed like so:

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
since it's a security risk.

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
[Cozycloud](https://cozycloud.cc) is the maintainer of the Cozy project. We can
provide you a Cozy instance for free if you write us an 
[email](mailto:contact@cozycloud.cc).
