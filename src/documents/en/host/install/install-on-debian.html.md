---
title: "on Debian"
layout: "default"
category: "host"
menuOrder: 1
toc: false
---


<div style="height: 0; overflow: shown; text-align: right">
<img alt="Debian logo" src="/assets/images/debian-logo.png">
</div>

# Install Cozy on Debian

You need **Debian 8 Jessie (stable)** in order to proceed to theses steps.

```
root@debian-8:~# lsb_release -c
Codename:     jessie
```

If `lsb_release` is not installed, you are probably on a too old version of
Debian. You can see which version like this:

```
root@debian-8:~# cat /etc/debian_version
8.1
```

<br>

1. Make sure that `ca-certificates` and `apt-transport-https` are properly installed
    ```
    apt-get install ca-certificates apt-transport-https
    ```
2. Cozy needs npm 2, which is not available for now in Debian Stable, so we need to install it by hand:
   ```
   apt-get install nodejs nodejs-legacy npm && npm install -g npm@latest-2
   ```
3. Import the repository public key
    ```
    wget -O - https://debian.cozycloud.cc/cozy.gpg.key 2>/dev/null | apt-key add -
    ```
4. Optionally check that the imported key is valid
    ```
    apt-key --keyring /etc/apt/trusted.gpg finger
    ```
    You should read:
    ```
    pub   2048R/2765B235 2014-11-17 [expires: 2016-11-17]
          Key fingerprint = E28C F8B2 ABBF E285 743B  27F1 BCB2 ED5D 2765 B235
    uid                  Cozy Debian Packaging <debian-packaging@cozycloud.cc>
    sub   2048R/D58A9D35 2014-11-17 [expires: 2016-11-17]
    ```
5. Add the Cozy repository to your software sources
    ```
    echo 'deb [arch=amd64] https://debian.cozycloud.cc/debian jessie main' \
    > /etc/apt/sources.list.d/cozy.list
    ```
6. Install Cozy
    ```
    apt-get update
    apt-get install cozy
    ```
    (please read comment bellow about the recommended dependencies).
7. Start Nginx service
    ```
    service nginx start
    ```
8. Register your Cozy account and enjoy!
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
