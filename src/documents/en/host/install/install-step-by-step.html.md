---
title: "Install Cozy step by step"
layout: "default"
category: "host"
menuOrder: 11
toc: false
---


<div class="install-inner-logo">
<img alt="Cozy logo" src="/assets/images/host/cozy-logo.svg">
</div>

# Install Cozy step by step

This documentation is a formal page aiming to summarize what components you
need in order to run Cozy properly.
You can reproduce those steps on any UNIX operating system (ArchLinux,
FreeBSD, etc.) and on any architecture (armhf, i386, etc.), as long as all
the components are available for it.

Please bear in mind that this documentation is **experimental**, we assume
here that you know what you are doing at each step (and that you are running
them as `root`).

---

**If you are looking for a automated install, you can rely on our other
[installation guides](index.html).**

---


## Step 1: Install dependencies

You will need a few dependencies to run Cozy properly. Here are the Debian
packages' names, feel free to adapt the names regarding your OS.

```
python, openssl, git, imagemagick, curl , wget, sqlite3, sudo
```

(sudo is actually needed by controller and to install apps and cannot be replaced by using a root session)

Some dependencies are required to **build** the Cozy components properly.

```
build-essential, python-dev, python-setuptools, python-pip, libssl-dev,
libxml2-dev, libxslt1-dev
```

Once again, those are Debian names. Do not copy/paste them as is, unless you
know what you are doing.


## Step 2: Install NodeJS 4.3.x

Cozy is only tested and supported on Node LTS versions.
Please check that this step will not interfere with any NodeJS version that
you might have on your server already.

Here we install NodeJS `4.3.`, if you have any other `4.x.y` version, you
should update (there were some important security fixes).

1. Find the sources or the binaries you need on http://nodejs.org/
 (you may want to choose the `arm-pi` version on a RaspberryPi).

2. Download and extract it

3. Build the sources, or link the binaries to a place in your `$PATH`
```bash
# If you have untar in /opt/node
ln -s /opt/node/bin/node /usr/bin/node
ln -s /opt/node/bin/npm /usr/bin/npm
```

4. Test your node installation
```bash
node -e 'console.log("Hello, World!")'
```

## Step 3: Install CouchDB 1.3.0 or greater


The CouchDB version is not (yet) really important. Make sure that it is
available on your OS/architecture.

If you want to build it from the sources (http://apache.crihan.fr/dist/couchdb/source/)
ensure that you have those build dependencies installed:

```
libicu-dev, libcurl4-openssl-dev, erlang
```

Once installed, you should able to run the `couchdb` command.


## Step 4: Install Postfix (recommended)

Postfix is recommended in order to enable your Cozy to send you notification
and password recovery emails.

Just install the package regarding your OS. On Debian:
```
apt-get install postfix
```

The mail domain parameter asked during the configuration is not important, put
whatever you want (`mydomain.net` for example).


## Step 5: Install a supervisor

In order to ensure that your processes are running properly, it is recommended
to use a supervisor: a program that checks background processes and enables
you to manipulate (start/stop) them.

On Cozy instances we typically use `supervisord` for that purpose.

There are [several ways of installing supervisor](http://supervisord.org/installing.html), for example using `pip`:

```
pip install supervisor
```

**On the below steps we will use supervisord configuration files.**
You can find them at:

https://github.com/cozy-labs/cozy-docker/tree/master/supervisor

The file `supervisord.conf` is the main file to put in `/etc/`, then you will
have to create a `/etc/supervisor/conf.d/` directory to put the rest of the
configuration files. One for each service, except `cozy-init` that you won't
need here.

⚠ In `cozy-controller.conf`, you should replace the line with
`%(ENV_NODE_ENV)s` with the following:
```
environment=NODE_ENV="production"
```

Don’t forget to [start the supervisor daemon](http://supervisord.org/running.html#running), for example:
```
/usr/bin/python /usr/bin/supervisord -c /etc/supervisor/supervisord.conf
```

## Step 6: Initialize users, directories and tokens

1. 3 UNIX users to create (without home directory)
```
useradd -MU cozy
useradd -MU cozy-data-system
useradd -MU cozy-home
```

2. Create the `/etc/cozy` directory with the proper permissions
```
mkdir /etc/cozy
chown -hR cozy /etc/cozy
```

3. Generate 3 tokens (you can use a tool like `pwgen` to do so) and **replace the tokens below with them**
```bash
# The CouchDB credentials
echo "MY_TOKEN1" > /etc/cozy/couchdb.login
echo "MY_TOKEN2" >> /etc/cozy/couchdb.login
chown cozy-data-system /etc/cozy/couchdb.login
chmod 640 /etc/cozy/couchdb.login
```
```bash
# The Cozy Controller token
echo "MY_TOKEN3" > /etc/cozy/controller.token
chown cozy-home /etc/cozy/controller.token
chmod 700 /etc/cozy/controller.token
```

4. Configure a new CouchDB admin
```bash
# Ensure that a couchdb daemon is running, then
# request the database via HTTP to add a new admin
service couchdb start
curl -s -X PUT 127.0.0.1:5984/_config/admins/$(head -n1 /etc/cozy/couchdb.login) -d "\"$(tail -n1 /etc/cozy/couchdb.login)\""
```


## Step 8: Install Cozy core modules

Now you should have everything you need to install the core NodeJS modules of
Cozy.

1. Install cozy-monitor and cozy-controller
```bash
npm install -g coffee-script cozy-monitor cozy-controller
```

2. Ensure that CouchDB, Cozy Indexer and Cozy Controller are running
```bash
# If you are running supervisord with the proper configuration files, try
service couchdb start
supervisorctl start cozy-controller
```
```bash
# Then check their status by requesting their port
# (respectively 5984, 9102 and 9002)
curl -s 127.0.0.1:5984 \
  && echo "CouchDB is running" \
  || echo "CouchDB is NOT running"
curl -s 127.0.0.1:9002 \
  && echo "Cozy Controller is running" \
  || echo "Cozy Controller is NOT running"
```

3. Install the 3 core applications
```bash
cozy-monitor install data-system
cozy-monitor install home
cozy-monitor install proxy
```


## Step 9: Configure a reverse proxy

If you followed the previous steps carefully, you should have a working Cozy
by now.

The Cozy Proxy listens locally on the port `9104`.

To protect your privacy, Cozy only accepts connections through https. Every
request sent through http will be redirected to the login page. So if you want
to check the installation, you can go to http://localhost:9104 but you won’t
be able to connect: you first need to setup TLS.

The recommended way to expose your Cozy to the outside world is to use a
reverse proxy (an alternative solution is documented below)

Here is an example `location` directive for **Nginx**:

```nginx
location / {
    proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
    proxy_set_header Host $http_host;
    proxy_redirect http:// https://;
    proxy_pass http://127.0.0.1:9104;
    proxy_http_version 1.1;
    proxy_set_header Upgrade $http_upgrade;
    proxy_set_header Connection "upgrade";
}
```

Note that a standard **Apache** reverse proxy will work too, there’s a
[sample Apache configuration file](https://github.com/cozy/cozy-debian/blob/master/apache-config).

---


If you seek for a complete Nginx configuration with SSL:

```bash
# Select your domain name
DOMAIN=example.com

# Create your SSL certificate and DH param
openssl dhparam -out /etc/cozy/dh2048.pem -outform PEM -2 2048
openssl req -x509 -nodes -newkey rsa:2048 -keyout /etc/cozy/server.key -out /etc/cozy/server.crt -days 3650 -subj "/CN=$DOMAIN"
```

Then, this configuration file should do the trick:

https://github.com/cozy-labs/cozy-docker/blob/master/nginx/cozy-ssl


**Do not forget to add a `server_name` directive if you have multiple virtualhosts.**

### Without a reverse proxy

It is recommended to run Cozy Proxy behind a reverse proxy that does the
SSL/TLS stuff. But if you don’t want to use a reverse proxy (low memory server
for example), you can also [configure the cozy-proxy itself to listen on
https](https://github.com/cozy/cozy-proxy/#listen-on-https). This will allow
to connect on https://localhost.


## Step 10: Install cozy_management

[cozy_management](https://github.com/cozy/python_cozy_management) is an
optional tool that provide useful commands that ease the management of
a Cozy server. This tool has been designed to work on a standard Cozy
install, and some commands may not work on custom installations. Just
[give it a try](https://github.com/cozy/python_cozy_management#install).
It is mostly a wrapper around shell commands, so if some commands doesn’t
work, you can probably read the code and adapt the commands to your
configuration.

## Troubleshooting

Please refer to [the dedicated section](https://docs.cozy.io/en/host/troubleshooting.html).

---

**If you encounter any problem during those steps, please leave a message on the [forum](https://forum.cozy.io) or come say "Hi!" on our [IRC channel](irc://irc.freenode.net/cozycloud).**
