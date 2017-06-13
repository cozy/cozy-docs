---
title: "Install Cozy on Ubuntu"
layout: "default"
category: "host"
menuOrder: 5
toc: false
---


<div class="install-inner-logo">
<img alt="Ubuntu logo" src="/assets/images/host/ubuntu-logo.svg">
</div>

# Install Cozy on Ubuntu

You need **Ubuntu 14.04 Trusty Tahr** in order to proceed to theses steps.

(It has been reported that the Ubuntu repository may also work for installing Cozy on GNU/Linux Mint)

```
root@ubuntu-14-04:~# lsb_release -c
Codename:     trusty
```

<br>

Cozy needs a web server. By default, we will install and configure Nginx, but if a web server is already installed, you can use it, just add a virtual host for Cozy.

<br>

1. Make sure that `wget`, ca-certificates` and `apt-transport-https` are properly installed
    ```
    sudo apt-get install ca-certificates apt-transport-https
    ```
2. Import the repository public key
    ```
    wget https://debian.cozycloud.cc/cozy.gpg.key -O /etc/apt/trusted.gpg.d/cozy.gpg
    ```
3. Add the Cozy repository to your software sources
    ```
    echo 'deb [arch=amd64] https://ubuntu.cozycloud.cc/debian trusty cozy' \
    | sudo tee /etc/apt/sources.list.d/cozy.list > /dev/null
    ```
4. Install Cozy
    ```
    sudo apt-get update ;
    sudo apt-get install -y python-cozy-management ;
    sudo cozy_management install_cozy
    ```
    (please read comment bellow about the recommended dependencies).
6. Start Nginx service
    ```
    sudo service nginx start
    ```
7. Register your Cozy account and enjoy!
    ```
    https://your-cozy-IP/
    ```

## Troubleshooting

### Some words about the dependencies

Cozy requires a CouchDB database, which will be automatically installed. It also needs a SMTP server listening on port 25 of the same host, and a Web server acting as a reverse proxy. Both are only recommended dependencies, because, depending on your architecture, you may install them on other server. For example, you can use a reverse proxy hosted on another server in front of your Cozy. However, for a typical installation, you should probably install the recommended dependency, by using `apt-get install --install-recommends cozy`.

The recommended packages are:

* a Web server, preferably Nginx. It handles the SSL certificate and redirects requests to the Cozy server itself;
* a SMTP server, used to send emails from your server (for example, the reset password message, events reminder, or to invite some of your contacts).


### How to regenerate the certificate?

    sudo openssl req -x509 -nodes -newkey rsa:2048 -keyout /etc/cozy/server.key -out /etc/cozy/server.crt -days 3650 -subj "/CN=YOUR.INSTANCE.URL"
