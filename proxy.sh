#!/bin/bash
echo Input domain tujuan:
read proxy_pass

echo Input port proxy:
read port
#setting port ssh

apt install nginx -y
rm /etc/nginx/sites-available/proxy.conf
rm /etc/nginx/sites-enabled/proxy.conf

rm /etc/nginx/sites-available/proxy
rm /etc/nginx/sites-enabled/proxy

wget -O /etc/nginx/nginx.conf "https://raw.githubusercontent.com/aunsys-dev/nginx-proxy/master/nginx.conf"
wget -O /etc/nginx/sites-available/proxy.conf "https://raw.githubusercontent.com/aunsys-dev/nginx-proxy/master/proxy.conf"
ln -s /etc/nginx/sites-available/proxy.conf /etc/nginx/sites-enabled/
service nginx restart

#setup vhost
IP=`curl -s ifconfig.me`;

sed -i "s/x.x.x.x/$IP/g" /etc/nginx/sites-available/proxy.conf
sed -i "s/z.z.z.z/$port/g" /etc/nginx/sites-available/proxy.conf
sed -i "s/y.y.y.y/$proxy_pass/g" /etc/nginx/sites-available/proxy.conf

systemctl restart nginx
