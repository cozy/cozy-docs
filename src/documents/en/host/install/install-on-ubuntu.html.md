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

## Troubleshooting

### How to regenerate the certificate?

    sudo openssl req -x509 -nodes -newkey rsa:2048 -keyout /etc/cozy/server.key -out /etc/cozy/server.crt -days 3650 -subj "/CN=YOUR.INSTANCE.URL"
