# Jenkins   
after Jenkins is installed, need to visit http://public_ip:8080
from there proceed to next step:
cat /var/lib/jenkins/secrets/initialAdminPassword
*Production-ready Jenkins Server*

Note: terraform handles EC2 instance creation and java, jenkins installation, all other steps are done manually

## Set up an NGINX as Peverse Proxy
**Step 1. Update repo and instal nginx**

```sudo apt update ```
```sudo apt install nginx -y```

**Step 2. Allow nginx through your firewall**
```sudo ufw allow 'Nginx HTTP'```

If need, check your nginx status

```systemctl status nginx```

**Step 3. Configure your server block**

```sudo vi /etc/nginx/sites-available/your_domain```

Paste this into the file:

~~~ 
server {
    listen 80;
    listen [::]:80;

    server_name your_domain www.your_domain;
        
    location / {
        proxy_pass app_server_address;
    }
}
~~~

Note: change your_domain and www.your_domain to your domain or IP address of the server, change app_server_address, e.g http://localhost:8080/

**Step 4. Next, enable this configuration file by creating a link from it to the sites-enabled directory that Nginx reads at startup:**

```sudo ln -s /etc/nginx/sites-available/your_domain /etc/nginx/sites-enabled/```

You can now test your configuration file for syntax errors:

```sudo nginx -t```

With no problems reported, restart Nginx to apply your changes:
```sudo systemctl restart nginx```

If everything is correct, you should be able to access your app via domain without typing **your_domain:8080**


## Getting TLS certificate using certbot

Certbot recommends using their snap package for installation. Snap packages work on nearly all Linux distributions, but they require that you’ve installed snapd first in order to manage snap packages. 

```sudo snap install core; sudo snap refresh core```

If you’re working on a server that previously had an older version of certbot installed, you should remove it before going any further:

```sudo apt remove certbot```

After that, you can install the certbot package:

```sudo snap install --classic certbot```

Finally, you can link the certbot command from the snap install directory to your path, so you’ll be able to run it by just typing certbot. This isn’t necessary with all packages, but snaps tend to be less intrusive by default, so they don’t conflict with any other system packages by accident:

```sudo ln -s /snap/bin/certbot /usr/bin/certbot```

If you have the ufw firewall enabled, as recommended by the prerequisite guides, you’ll need to adjust the settings to allow for HTTPS traffic. Luckily, Nginx registers a few profiles with ufw upon installation.

You can see the current setting by typing:

```sudo ufw status```


To additionally let in HTTPS traffic, allow the Nginx Full profile and delete the redundant Nginx HTTP profile allowance:

```sudo ufw allow 'Nginx Full'```
```sudo ufw delete allow 'Nginx HTTP'```


Certbot provides a variety of ways to obtain SSL certificates through plugins. The Nginx plugin will take care of reconfiguring Nginx and reloading the config whenever necessary. To use this plugin, type the following:

```sudo certbot --nginx```

Select the domain names you want to secure, enter your email, press "yes"