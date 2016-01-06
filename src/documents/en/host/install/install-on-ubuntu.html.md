---
title: "on Ubuntu"
layout: "default"
category: "host"
menuOrder: 0
toc: false
---


<div style="height: 0; overflow: shown; text-align: right">
<img alt="Ubuntu logo" src="/assets/images/ubuntu-logo.png">
</div>

# Install Cozy on Ubuntu

You need **Ubuntu 14.04 Trusty Tahr** in order to proceed to theses steps.

(It has been reported that the Ubuntu repository may also work for installing Cozy on GNU/Linux Mint)

```
root@ubuntu-14-04:~# lsb_release -c
Codename:     trusty
```

<br>

1. Make sure that `ca-certificates` and `apt-transport-https` are properly installed
    ```
    sudo apt-get install ca-certificates apt-transport-https
    ```
2. Import the repository public key
    ```
    wget -O - https://ubuntu.cozycloud.cc/cozy.gpg.key 2>/dev/null | sudo apt-key add -
    ```
3. Add the Cozy repository to your software sources
    ```
    echo 'deb https://ubuntu.cozycloud.cc/debian trusty main' \
    | sudo tee /etc/apt/sources.list.d/cozy.list > /dev/null
    ```
4. Install Cozy
    ```
    sudo apt-get update
    sudo apt-get install cozy
    ```
    (please read comment bellow about the recommended dependencies).
6. Start Nginx service
    ```
    service nginx start
    ```
7. Register your Cozy account and enjoy!
    ```
    https://your-cozy-IP/
    ```

## Troubleshooting

### Some words about the dependencies

Cozy requires a CouchDB database, which will be automatically installed. It also needs a SMTP server listening on port 25 of the same host, and a Web server acting as a reverse proxy. Both are only recommended dependencies, because, depending on your architecture, you may install them on other server. For example, you can use a reverse proxy hosted on another server in front of your Cozy. However, for a typical installation, you should probably install the recommended dependency, by using `apt-get install --install-recommends cozy`.

The recommended packages are:

* a Web server, preferably Ninx. It handles the SSL certificate and redirects requests to the Cozy server itself;
* a SMTP server, used to send emails from your server (for example, the reset password message, events reminder, or to invite some of your contacts).


### How to regenerate the certificate?

    sudo openssl req -x509 -nodes -newkey rsa:2048 -keyout /etc/cozy/server.key -out /etc/cozy/server.crt -days 3650 -subj "/CN=YOUR.INSTANCE.URL"
