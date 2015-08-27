---
title: "on Debian"
layout: "default"
category: "host"
menuOrder: 1
toc: false
---


<div style="height: 0; overflow: shown; text-align: right">
<img src="/assets/images/debian-logo.png">
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
2. Import the repository public key
    ```
    wget -O - https://debian.cozycloud.cc/cozy.gpg.key 2>/dev/null | apt-key add -
    ```
3. Optionally check that the imported key is valid
    ```
    apt-key --keyring /etc/apt/trusted.gpg finger
    ```
    You should read:
    ```
    pub   2048R/2765B235 2014-11-17 [expires: 2015-11-17]
          Key fingerprint = E28C F8B2 ABBF E285 743B  27F1 BCB2 ED5D 2765 B235
    uid                  Cozy Debian Packaging <debian-packaging@cozycloud.cc>
    sub   2048R/D58A9D35 2014-11-17 [expires: 2015-11-17]
    ```
4. Add the Cozy repository to your software sources
    ```
    echo 'deb [arch=amd64] https://debian.cozycloud.cc/debian jessie main' \
    > /etc/apt/sources.list.d/cozy.list
    ```
5. Install Cozy
    ```
    apt-get update
    apt-get install cozy
    ```
6. Start Nginx service
    ```
    service nginx start
    ```
7. Register your Cozy account and enjoy!
    ```
    https://your-cozy-IP/
    ```

## Troubleshooting

### How to regenerate the certificate?

    sudo openssl req -x509 -nodes -newkey rsa:2048 -keyout /etc/cozy/server.key -out /etc/cozy/server.crt -days 3650 -subj "/CN=YOUR.INSTANCE.URL"
