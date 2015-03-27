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

* RAM: 1024MB (it allows to have 6 apps running simultaneously).
* Disk space: 2GB.

#### Recommended

* RAM: 2048 MB (it allows to have 16 apps running simultaneously).
* Disk space: a lot of space to store all your files.

### About security in pre-installed images

For a production usage, you MUST renew the SSL certificate, reset the database credentials and reset the controller token.

For this purpose, use the following command:
```bash
wget https://raw.githubusercontent.com/cozy/cozy-setup/master/fabfile.py
fab -H user@ip reset_security_tokens
```
To use this command, you should install Fabric on your local machine.

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

#### How to use Apache Web server

By default, Cozy install a Nginx Web server. If you already have an Apache server, you may want to use it instead of Nginx. Here’s how you can do it.

First, before executing `fab -H install`, edit `fabfile.py` and comment out the lines in charge of Nginx install (add a `#` in front of `install_nginx` inside `install` method).

Then create a new vhost into your Apache config, with the following configuration:

```
    # /etc/apache2/sites-available/cozy.conf
    <IfModule mod_ssl.c>
     <VirtualHost *:443>
            ServerName      mydomain.net
            ServerAdmin     admin@mydomain.net

            # On active le chiffrement (HTTPS)
            SSLEngine               On
            SSLCertificateFile      /etc/cozy/server.crt
            SSLCertificateKeyFile   /etc/cozy/server.key

            # Redirection des requêtes vers l'application Cozy Cloud
            ProxyPass               / http://127.0.0.1:9104/ retry=0 Keepalive=On timeout=1600
            ProxyPassReverse        / http://127.0.0.1:9104/
            setenv proxy-initial-not-pooled 1

            CustomLog               /var/log/apache2/cozy-access.log "%t %h %{SSL_PROTOCOL}x %{SSL_CIPHER}x \"%r\" %b"
            ErrorLog                /var/log/apache2/cozy-error.log

     </VirtualHost>
    </IfModule>
```

At last, ensure that the `proxy` and `proxy_http` Apache modules are loaded:

```bash
a2enmod proxy
a2enmod proxy_http
service apache2 restart
```
#### How to use your own Nginx Web server

The default installation of Cozy comes with a specific configuration of nginx. This redirects every request made to your host to the Cozy proxy. But you may need to use your own server.
Depending on your `nginx.conf` file, you may adapt the following file paths.

##### Create a self-signed certificate

Input the following commands :

```
cd /etc/cozy
openssl dhparam -out ./dh2048.pem -outform PEM -2 2048
openssl genrsa -out ./server.key 2048
openssl req -new -x509 -days 3650 -key ./server.key -out ./server.crt
chmod 640 server.key
```

Be careful during the last `openssl` command. The fields are not required *except* the `Common Name`. It has to be the name of your server. For instance: `cozy.mydomain.com`

##### Create a vitual host

Once this is done, create a specific vhost for your cozy instance. For instance `conf.d/cozy.conf` :

```
server {
    listen 443;
    server_name cozy.mydomain.com;
    ssl_certificate /etc/cozy/server.crt;
    ssl_certificate_key /etc/cozy/server.key;
    ssl_dhparam /etc/cozy/dh2048.pem;
    ssl_session_cache shared:SSL:10m;
    ssl_session_timeout  10m;
    ssl_protocols TLSv1 TLSv1.1 TLSv1.2;
    ssl_ciphers ALL:!aNULL:!eNULL:!LOW:!EXP:!RC4:!3DES:+HIGH:+MEDIUM;
    ssl_prefer_server_ciphers   on;
    ssl on;

    gzip_vary on;
    client_max_body_size 1024M;

    add_header Strict-Transport-Security max-age=2678400;

    location / {
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header Host $http_host;
        proxy_redirect http:// https://;
        proxy_pass http://127.0.0.1:9104;
        proxy_http_version 1.1;
        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection "upgrade";
    }

    access_log /var/log/nginx/cozy.log;
}

# Always redirect http:// to https://
server {
    listen 80;
    server_name cozy.mydomain.com;
    return 301 https://$host$request_uri;
}
```
Then restart your server

```
service nginx restart
```

You should be able to acces your cozy by browsing to cozy.mydomain.com. Of course, the DNS zone has to be properly configured.

##### Specific case : DavDroid

If you intend to sync your own cozy with an Android phone and using DavDroid, you'll have to do several things: follow [this link](https://davdroid.bitfire.at/faq/entry/importing-a-certificate).
The automatic method using `CaDroid` is fast and efficient.

Be careful : since you enabled a reverse proxy to serve your Cozy instance, you need to specify the full URL while configuring your DavDroid account, for instance 'https://cozy.mydomain.com/public/sync/principals/me`. If you don't, you will face this error :

```
Missing capatibilities. Invalid DAV response. Neither CalDAV nor CardDAV available.
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
* Nginx Web server
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

## Hosting services

### Cozycloud

[Cozycloud](https://cozycloud.cc) is the maintainer of the Cozy project. We can
provide you a Cozy instance for free, to get your feedbacks. Simply fill
[the subscription form](/en/#instance-request).

### VPS

Renting a VPS and running the installation script is a good option. Here are
the two hosting providers we performed tests on:

* [OVH](http://www.ovh.com/fr/vps/vps-classic.xml), we recommend the VPS
  Classic 2.
* [Digital Ocean](https://www.digitalocean.com/pricing/). The $10 plan is a
  minimum. We recommend the $20 plan.


## Raspberry Pi 2 image

**You will need the latest [Raspberry Pi 2](http://en.wikipedia.org/wiki/Raspberry_Pi) to be able to run Cozy properly.**

*Note for previous Raspberry Pi:* Cozy is a little bit heavy to run on the previous Raspberry Pi model B/B+, you can check for a
lightweight alternative called
[Cozy Light](https://github.com/cozy-labs/cozy-light)


In order to run Cozy on your Raspberry Pi 2, the simplest way is to download our
image and set it up on a SD card. The image is based on the
[Raspbian](http://www.raspbian.org/) distribution.

First, get the image archive:

```bash
# Download the image (~ 650MB)
wget http://files.cozycloud.cc/2015-02-19-cozy-raspberry-pi2.img.7z

# Uncompress it
7zr e 2015-02-19-cozy-raspberry-pi2.img.7z
```

Next, find where your SD card is mounted; let's assume it is on */dev/sdc*,
then make a low-level dump of the image onto your card.

**NB:** SD Class 10 card are recommended for better performance.

**WARNING:** This operation will erase all data previously stored on the card.

```bash
sudo dd bs=4M if=2015-02-19-cozy-raspberry-pi2.img of=/dev/sdc
```

Now insert the SD card in your Raspberry Pi SD card reader. Reboot your
Raspberry, and you will be able to access your Cozy through port 443
(https protocol).

To find the IP address of your Raspberry Pi, you can use `nmap`
on your local machine:

```
$ nmap -T4 -sP 192.168.x.0/24
```

If you want to login to the board, use the default Raspbian credentials
```pi``` and ```raspberry```:
```
$ ssh pi@<ip-of-your-raspberrypi>
```

By the way, don't forget to change the password and [reset the security
tokens](#about-security-in-pre-installed-images)!


## Cubietruck image

*Warning: For production use, you must change the superuser credentials,
renew the SSL certificate, the database credentials and the controller token.*

In order to run Cozy on your Cubietruck, the simplest way is to download our
image and set it up on a SD card. It is based on the
[Cubian](http://cubian.org/) distribution.

First, get the image archive:

```bash
# Download the image (~ 860MB)
wget http://files.cozycloud.cc/2015-03-09-cozy-cubietruck.img.7z

# Uncompress it
7zr e 2015-03-09-cozy-cubietruck.img.7z
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

To find the IP address of your Cubieboard, you can use nmap on your local machine:

```
$ nmap -T4 -sP 192.168.x.0/24
```

If you want to login to the board, use the default Cubian credentials ```cubie```
and ```cubie```:
```
$ ssh -p 36000 cubie@<ip-of-your-cubieboard>
```


By the way, don't forget to change the password and to
[reset the security
tokens](#about-security-in-pre-installed-images)!



## Virtualbox image

*Warning: For production use, you must change the superuser credentials,
renew the SSL certificate, the database credentials and the [controller token](#about-security-in-pre-installed-images).*

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

If you are on OS X, you have to forward ports.
Port 22 form your virtual machine should forward to 127.0.0.1:2222 and port 443 should forward to 127.0.0.1:2223.

### Additional informations

To access the box shell, use root/password as login and password.

You can find the box' IP with the `ifconfig` command.

You can connect through ssh with:

```bash
ssh -p 2222 root@localhost
```

## OpenVZ image

*Warning: For production use, you must change the superuser credentials,
renew the SSL certificate, the database credentials and the [controller token](#about-security-in-pre-installed-images).*

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


## Docker image


*You will need [Docker](https://www.docker.com/) v1.0.1 or newer to run this image*

You can try Cozy very easily by pulling the official automatically built image
from Docker Hub:

```
sudo docker pull cozy/full
```

If you want to run it in a production environment, it is recommended to build
the image yourself:

```
sudo docker build -t cozy/full github.com/cozy-labs/cozy-docker
```

Then you can run the image:

```
sudo docker run -d -p 80:80 -p 443:443 cozy/full
```

You can indicate different ports if your port 80 and 443 are already in use.
For example:
```
sudo docker run -d -p 6500:443 cozy/full
```

Then your Cozy should be accessible on https://localhost:443 (or
https://localhost:6500 for the second example)

