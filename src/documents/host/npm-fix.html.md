---
title: "Fix NPM Certificate Configuration"
layout: "default"
category: "host"
isCategoryMaster: "true"
menuOrder: 5
---

# Problem

NPM changed its certificate policy. Since Cozy runs on an old version of
Node.js, it doesn't support the new policy. 
[More details
here](http://blog.npmjs.org/post/78085451721/npms-self-signed-certificate-is-no-more).

# The fix

Run the following command on your server:

    sudo npm config set ca ""

Or use this our fabric file to target the machine that hosts Cozy:

    sudo apt-get install python python-pip python-dev software-properties-common
    sudo pip install fabric fabtools
    wget https://raw.github.com/mycozycloud/cozy-setup/master/fabfile.py
    fab -H sudoer@ip install fix_npm_ca_config
