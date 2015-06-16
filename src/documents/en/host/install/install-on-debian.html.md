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

<br>

1. Make sure that `ca-certificates` and `apt-transport-https` are properly installed
    ```
    apt-get install ca-certificates apt-transport-https
    ```
2. Import the repository public key
    ```
    wget -O - http://debian.cozycloud.cc/cozy.gpg.key 2>/dev/null | apt-key add -
    ```
3. Add the Cozy repository to your software sources
    ```
    echo 'deb [arch=amd64] http://debian.cozycloud.cc/debian jessie main' \
    > /etc/apt/sources.list.d/cozy.list
    ```
4. Install Cozy
    ```
    apt-get update
    apt-get install cozy
    ```
