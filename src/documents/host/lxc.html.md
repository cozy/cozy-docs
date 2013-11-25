---
title: " LXC"
layout: "default"
category: "host"
menuOrder: 4
---

# Setup a LXC image on your server.


Use the LXC webpanel to add and configure containers, it's very easy to use.
For Ubuntu this can be installed like so:

```bash
sudo apt-get install -y lxc debootstrap bridge-utils
sudo su
wget http://lxc-webpanel.github.com/tools/install.sh -O - | bash
exit
```

Now access the webpanel at http://myhost.com:5000, default login is admin/admin
(change this). Create a container, remember what you named it. Make it run at
startup. Then go to command line to access the container.

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
nginx I used this template:

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
